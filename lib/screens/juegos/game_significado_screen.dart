import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/progreso_service.dart';
import '../../models/progreso.dart';
import 'juego_significado_data.dart'; // Importamos la clase con los datos de los niveles

import '../../services/juego_service.dart'; // Importamos el servicio para obtener los niveles
import '../../models/juego.dart';

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
    _cargarProgreso();
    _cargarNivel();
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
    List<String> opcionesIncorrectas = ["SILLA", "AGUA", "MESA", "CASA"];
    opcionesIncorrectas.remove(palabraCorrecta);
    opcionesIncorrectas.shuffle();

    // Seleccionamos 3 opciones incorrectas y agregamos la correcta
    opciones = [palabraCorrecta, ...opcionesIncorrectas.take(3)];
    opciones.shuffle(); // Mezclamos las opciones
  }

  // Maneja la selección del usuario
  void _seleccionarOpcion(String opcionSeleccionada) async {
    if (opcionSeleccionada == palabraCorrecta) {
      print("✅ Respuesta correcta, actualizando progreso...");

      /*await ProgresoService().actualizarProgreso(_usuarioId, widget.juegoId,
          widget.nivel + 1, (widget.nivel / 7) * 100);*/ //Si no actuaiza, descomentar esta linea de codigo/////////////

      // Actualizar el progreso solo si se responde correctamente
      await _completarNivel();

      _mostrarDialogo("¡Correcto!", "Has adivinado la palabra correctamente.");
    } else {
      _mostrarDialogo("Incorrecto", "Inténtalo de nuevo.");
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
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(titulo),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (titulo == "¡Correcto!") {
                  Navigator.pop(context); // Volver a la pantalla de niveles
                }
              },
              child: const Text("Continuar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Selecciona su significado",
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Mostrar imágenes de señas
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: nivelData.imagenes.map((img) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/sign/$img", width: 60),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),

            // Mostrar opciones de respuesta
            Column(
              children: opciones.map((opcion) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    onPressed: () => _seleccionarOpcion(opcion),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.blue),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 50),
                    ),
                    child: Text(
                      opcion,
                      style: const TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            // Botón para pasar al siguiente nivel (se activará solo si acierta)
            ElevatedButton(
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
            ),
          ],
        ),
      ),
    );
  }
}
