import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart'; // Para formatear la fecha
import 'package:shared_preferences/shared_preferences.dart';
import '../models/historial_traduccion.dart';
import '../services/historial_traduccion_service.dart';

class TextToSignScreen extends StatefulWidget {
  const TextToSignScreen({Key? key}) : super(key: key);

  @override
  _TextToSignScreenState createState() => _TextToSignScreenState();
}

class _TextToSignScreenState extends State<TextToSignScreen> {
  final TextEditingController _textController = TextEditingController();
  String? _currentImage; // Imagen actual que se mostrará
  int _currentIndex = 0; // Índice actual para iterar las letras
  List<String> _letters = []; // Lista de letras del texto ingresado
  Timer? _timer; // Temporizador para cambiar imágenes automáticamente

  @override
  void dispose() {
    _textController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTranslation() {
    // Obtén el texto ingresado y aplica validaciones
    String text = _textController.text.toLowerCase();

    // Reemplazar letras con tildes por letras normales
    text = text
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ü', 'u');

    // Eliminar todo lo que no sea alfanumérico (letras y números)
    text = text.replaceAll(RegExp(r'[^a-z0-9]'), '');

    // Verificar si el texto está vacío después de la limpieza
    if (text.isEmpty) {
      setState(() {
        _currentImage = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("El texto no contiene caracteres válidos")),
      );
      return;
    }

    // Convertir el texto a una lista de letras
    setState(() {
      _letters = text.split('');
      _currentIndex = 0;
      _currentImage = 'assets/sign/${_letters[_currentIndex]}.png';
    });

    // Configurar el temporizador para cambiar las imágenes
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentIndex++;
        if (_currentIndex < _letters.length) {
          _currentImage = 'assets/sign/${_letters[_currentIndex]}.png';
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _clearTranslation() {
    _textController.clear();
    setState(() {
      _letters = [];
      _currentImage = null;
      _currentIndex = 0;
    });
    _timer?.cancel();
  }

  Future<void> _saveTranslation() async {
    final text = _textController.text.trim();

    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Por favor, ingrese un texto para traducir")),
      );
      return;
    }

    try {
      // Obtener el id del usuario autenticado
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt(
          'userId'); // Supongo que guardaste el ID del usuario como 'userId'

      if (userId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Error: No se encontró la sesión del usuario")),
        );
        return;
      }

      // Obtener la fecha actual
      final fechaActual = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Crear un objeto de tipo HistorialTraduccion
      final nuevoHistorial = HistorialTraduccion(
        // El ID será generado por el backend
        usuarioId: userId,
        texto: text,
        tipoTraduccion: "Texto a señas",
        fechaTraduccion: fechaActual,
      );

      // Guardar en el backend
      final success =
          await HistorialTraduccionService().crearHistorial(nuevoHistorial);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Traducción guardada con éxito")),
        );
        _clearTranslation();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error al guardar la traducción")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al conectar con el servidor: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo, // Color elegante para jóvenes/niños
        title: const Text(
          "Traductor IA",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 3, // pequeña sombra para dar un look más moderno
      ),
      // Usamos un fondo con un ligero degradado pastel, más suave
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                //height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE3F2FD),
                      Color(0xFFEDE7F6)
                    ], // Colores suaves
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Imagen o ícono
                      Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: _currentImage == null
                            ? const Icon(Icons.image,
                                size: 50, color: Colors.grey)
                            : Image.asset(_currentImage!, fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 20),

                      // Título "Traducción"
                      const Text(
                        "Traducción",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          color: Colors.indigo,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Etiqueta de Texto a traducir
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Texto a traducir a señas",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Caja de texto
                      TextField(
                        controller: _textController,
                        maxLines: 5,
                        style: const TextStyle(color: Colors.black87),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.85),
                          hintText: "Escribe aquí tu texto...",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Verifica que esté escrito correctamente antes de traducir",
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Botón "Traducir"
                      ElevatedButton(
                        onPressed: _startTranslation,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: const Text(
                          "Traducir",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Fila de botones "Guardar" y "Limpiar"
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: _saveTranslation,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.indigo,
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.indigo),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            child: const Text(
                              "Guardar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _clearTranslation,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.indigo,
                              backgroundColor: Colors.white,
                              side: const BorderSide(color: Colors.indigo),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                            ),
                            child: const Text(
                              "Limpiar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
