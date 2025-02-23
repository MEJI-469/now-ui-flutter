import 'package:flutter/material.dart';
import 'package:now_ui_flutter/constants/Theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/progreso_service.dart';
import '../../models/progreso.dart';
import 'juego_significado_data.dart'; // Importamos la clase con los datos de los niveles

import '../../services/juego_service.dart'; // Importamos el servicio para obtener los niveles
import '../../models/juego.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';

class JuegoSignificadoScreen extends StatefulWidget {
  final int nivel;
  final int juegoId;
  final VoidCallback onLevelComplete;

  const JuegoSignificadoScreen({
    Key? key,
    required this.nivel,
    required this.juegoId,
    required this.onLevelComplete,
  }) : super(key: key);

  @override
  _JuegoSignificadoScreenState createState() => _JuegoSignificadoScreenState();
}

class _JuegoSignificadoScreenState extends State<JuegoSignificadoScreen> {
  late NivelSignificado nivelData;
  late List<String> opciones;
  late String palabraCorrecta;
  ProgresoService progresoService = ProgresoService();
  final JuegoService juegoService = JuegoService();
  int _cantidadNiveles = 7; // Se actualizará dinámicamente según el juego
  int _usuarioId = 0;
  int _nivelActual = 1;

  @override
  void initState() {
    super.initState();
    _cargarNivel();
    _cargarProgreso();
  }

  // Carga el ID del usuario desde SharedPreferences
  Future<void> _cargarProgreso() async {
    final prefs = await SharedPreferences.getInstance();
    _usuarioId = prefs.getInt('userId') ?? 0;

    if (_usuarioId != 0) {
      Progreso? progreso =
          await progresoService.obtenerProgreso(_usuarioId, widget.juegoId);
      if (progreso != null) {
        setState(() {
          _nivelActual = progreso.nivelActual;
        });
      } else {
        await progresoService.crearProgreso(_usuarioId, widget.juegoId);
      }
    }

    // Obtener la cantidad total de niveles desde la API
    Juego? juego = await juegoService.getJuegoById(widget.juegoId);
    if (juego != null) {
      setState(() {
        _cantidadNiveles = juego.niveles;
        //_nombreJuego = juego.nombreJuego;
      });
    }
  }

  // Carga los datos del nivel actual
  void _cargarNivel() {
    nivelData =
        JuegoSignificadoData.niveles.firstWhere((n) => n.nivel == widget.nivel);
    palabraCorrecta = nivelData.palabraCorrecta;

    // Generamos opciones incorrectas aleatorias
    List<String> opcionesIncorrectas = [
      "SILLA",
      "AGUA",
      "MESA",
      "CASA",
      "PERRO",
      "GATO",
      "LUNA",
      "SOL",
      "FLOR",
      "ARBOL",
      "PATO",
      "RANA",
      "PISO",
      "TEJA",
      "LAGO",
      "RIO",
      "NUBE",
      "TREN",
      "AVION",
      "BARCO"
    ];
    opcionesIncorrectas.remove(palabraCorrecta);
    opcionesIncorrectas.shuffle();

    // Seleccionamos 3 opciones incorrectas y agregamos la correcta
    opciones = [palabraCorrecta, ...opcionesIncorrectas.take(3)];
    opciones.shuffle(); // Mezclamos las opciones
  }

  final AudioPlayer _audioPlayer = AudioPlayer()
    ..setReleaseMode(ReleaseMode.stop);
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  // Maneja la selección del usuario
  void _seleccionarOpcion(String opcionSeleccionada) async {
    if (opcionSeleccionada == palabraCorrecta) {
      print("✅ Respuesta correcta, actualizando progreso...");

      // Reproducir sonido de acierto
      await _audioPlayer.play(AssetSource('sounds/celebrate.mp3'));

      // Activar confetti
      _confettiController.play();

      // Actualizar el progreso solo si se responde correctamente
      await _completarNivel();

      _mostrarDialogo(
          "🎉 ¡Correcto!", "Has adivinado la palabra correctamente.");
    } else {
      // Reproducir sonido de error
      await _audioPlayer.play(AssetSource('sounds/wrong.mp3'));

      _mostrarDialogo("❌ Incorrecto", "Inténtalo de nuevo.");
    }
  }

  Future<void> _completarNivel() async {
    if (widget.nivel >= _nivelActual) {
      int nuevoNivel = widget.nivel + 1;
      int idJuego = widget.juegoId;
      double nuevoProgreso = ((nuevoNivel - 1) / _cantidadNiveles) * 100;

      print(
          "🔵 Intentando actualizar progreso para juegoId: ${widget.juegoId}, nivel: $nuevoNivel");
      print(
          "🔍 Progreso actual antes de actualizar: usuarioId=$_usuarioId, juegoId=${widget.juegoId}, nivelActual=$_nivelActual");

      print("🟢 Enviando actualización de progreso...");
      bool actualizado = await progresoService.actualizarProgreso(
          _usuarioId, idJuego, nuevoNivel, nuevoProgreso);

      if (actualizado) {
        print("✅ Progreso actualizado correctamente en el backend");
        widget.onLevelComplete();
      } else {
        print("⚠️ No se pudo actualizar el progreso");
      }
    }
  }

  // Mostrar diálogo de éxito o error
  void _mostrarDialogo(String titulo, String mensaje) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(titulo, textAlign: TextAlign.center),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(mensaje),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (titulo == "🎉 ¡Correcto!") {
                    Navigator.pop(context); // Volver a la pantalla de niveles
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("Seguir jugando",
                    style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("🌟 Selecciona su significado",
            style: TextStyle(color: Colors.white, fontSize: 20)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: [
            // 🎨 Fondo de color con gradiente
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.cyan],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  // 👉 Indicador de deslizamiento
                  Align(
                    alignment: Alignment
                        .centerRight, // Alinea el contenido a la derecha
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Deslizar -->",
                        style: TextStyle(
                          color: NowUIColors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign
                            .end, // Alinea el texto dentro del contenedor
                      ),
                    ),
                  ),
                  // Mostrar imágenes de señas con scroll horizontal
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: nivelData.imagenes.map((img) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 70, 91)
                                      .withOpacity(0.5), // Color de la sombra
                                  blurRadius: 5.0, // Difuminado de la sombra
                                  spreadRadius: 2.0, // Extensión de la sombra
                                  offset: Offset(2.0,
                                      2.0), // Desplazamiento de la sombra (x, y)
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child:
                                  Image.asset("assets/sign/$img", width: 120),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🎯 Opciones con botones infantiles
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: opciones.map((opcion) {
                      return ElevatedButton(
                        onPressed: () => _seleccionarOpcion(opcion),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orangeAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 25),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              opcion,
                              style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🎉 Confetti de celebración
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: [Colors.green, Colors.blue, Colors.yellow, Colors.red],
              ),
            ),

            // Botón para pasar al siguiente nivel (se activará solo si acierta)
            /*ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              ),
              child: const Text("Siguiente",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),*/
          ],
        ),
      ),
    );
  }
}
