import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:math' as math;
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'dart:async';
import '../constants/Theme.dart';

Timer? _captureTimer;
late bool switchValueOne;

class SignToTextScreen extends StatefulWidget {
  @override
  _SignToTextScreenState createState() => _SignToTextScreenState();
}

class _SignToTextScreenState extends State<SignToTextScreen>
    with WidgetsBindingObserver {
  late CameraController _cameraController;
  bool isCameraInitialized = false;
  String translatedText = "";
  final FlutterTts flutterTts = FlutterTts();
  List<CameraDescription> cameras = [];
  int selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initializeCamera();
    switchValueOne = false;
    _initTts();
  }

  void startDetection() {
    _captureTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (isCameraInitialized) {
        captureAndSendImage();
      }
    });
  }

  void stopDetection() {
    _captureTimer?.cancel();
    _captureTimer = null;
  }

  Future<void> captureAndSendImage() async {
    if (!_cameraController.value.isInitialized) return;

    try {
      final XFile imageFile = await _cameraController.takePicture();
      final bytes = await imageFile.readAsBytes();

      String base64Image = base64Encode(bytes);
      base64Image = 'data:image/jpeg;base64,$base64Image';

      final response = await http.post(
        Uri.parse('http://192.168.3.11:5000/predict'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          translatedText += data['prediction'];
        });
      } else {
        print('Error en la predicción: ${response.body}');
      }
    } catch (e) {
      print('Error al capturar o enviar la imagen: $e');
    }
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(
      cameras[selectedCameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _cameraController.initialize();
      if (mounted) {
        setState(() {
          isCameraInitialized = true;
        });
      }
    } catch (e) {
      print('Error al inicializar la cámara: $e');
    }
  }

  void switchCamera() async {
    if (cameras.isNotEmpty) {
      selectedCameraIndex = (selectedCameraIndex + 1) % cameras.length;

      if (_cameraController.value.isInitialized) {
        await _cameraController.dispose();
      }
      initializeCamera();
    }
  }

  void _initTts() {
    flutterTts.setLanguage("es-ES");
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.5);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController.dispose();
    flutterTts.stop();
    stopDetection();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.paused) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initializeCamera();
    }
  }

  Widget _rearCameraView() {
    return Transform.rotate(
      angle: math.pi / 2,
      child: CameraPreview(_cameraController),
    );
  }

  Widget _frontCameraView() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationY(math.pi),
      child: Transform.rotate(
        angle: -math.pi / 2,
        child: CameraPreview(_cameraController),
      ),
    );
  }

  Widget _cameraView() {
    return cameras[selectedCameraIndex].lensDirection ==
            CameraLensDirection.front
        ? _frontCameraView()
        : _rearCameraView();
  }

  void speakText() {
    if (translatedText.isNotEmpty) {
      flutterTts.speak(translatedText);
    }
  }

  void saveTranslation() {
    print("Guardado: $translatedText");
  }

  void clearTranslation() {
    setState(() {
      translatedText = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nuevo Traductor IA',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 370,
            width: 350,
            child: isCameraInitialized
                ? Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ClipRect(
                      child: _cameraView(),
                    ),
                  )
                : Center(
                    child: Icon(
                      Icons.camera_alt,
                      size: 75,
                      color: Colors.grey,
                    ),
                  ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Text(
                        "Detectar",
                        style: TextStyle(color: NowUIColors.text),
                      ),
                      Switch.adaptive(
                        value: switchValueOne,
                        onChanged: (bool newValue) {
                          setState(() {
                            switchValueOne = newValue;
                            if (newValue) {
                              startDetection();
                            } else {
                              stopDetection();
                            }
                          });
                        },
                        activeColor: NowUIColors.primary,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 3,
                  child: ElevatedButton.icon(
                    onPressed: switchCamera,
                    icon: Icon(Icons.switch_camera),
                    label: Text('Cambiar cámara'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(20, 40),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Señas traducidas a texto',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
                SizedBox(height: 8),
                TextField(
                  readOnly: true,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Texto traducido',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: translatedText),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FloatingActionButton.extended(
                    onPressed: speakText,
                    label: Text('Reproducir'),
                    icon: Icon(Icons.volume_up_rounded),
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: saveTranslation,
                      child: Text('Guardar'),
                    ),
                    ElevatedButton(
                      onPressed: clearTranslation,
                      child: Text('Limpiar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
