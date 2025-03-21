import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/progreso_service.dart';
import '../../services/juego_service.dart'; // Importamos el servicio para obtener los niveles
import '../../models/progreso.dart';
import '../../models/juego.dart';
import 'game_significado_screen.dart'; // Importamos la pantalla del juego
import 'game_carta_screen.dart';

class LevelsScreen extends StatefulWidget {
  final int juegoId; // Recibe el ID del juego seleccionado

  const LevelsScreen({Key? key, required this.juegoId}) : super(key: key);

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  int _nivelActual = 1; // Último nivel alcanzado por el usuario
  double _progreso = 0.0; // Progreso en porcentaje
  int _usuarioId = 0; // ID del usuario
  int _cantidadNiveles = 5; // Se actualizará dinámicamente según el juego
  String _nombreJuego = "juego desconocido";
  final ProgresoService progresoService = ProgresoService();
  final JuegoService juegoService = JuegoService();

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  // Cargar el progreso del usuario y la cantidad de niveles del juego
  Future<void> _cargarDatos() async {
    final prefs = await SharedPreferences.getInstance();
    _usuarioId = prefs.getInt('userId') ?? 0;

    if (_usuarioId != 0) {
      // Obtener progreso del usuario en este juego
      Progreso? progreso =
          await progresoService.obtenerProgreso(_usuarioId, widget.juegoId);
      if (progreso != null) {
        setState(() {
          _nivelActual = progreso.nivelActual;
          _progreso = progreso.porcentajeProgreso / 100;
        });
      }
    }

    // Obtener la cantidad total de niveles desde la API
    Juego? juego = await juegoService.getJuegoById(widget.juegoId);
    if (juego != null) {
      setState(() {
        _cantidadNiveles = juego.niveles;
        _nombreJuego = juego.nombreJuego;
      });
    }
  }

  // Guardar progreso en la API cuando el usuario completa un nivel
  Future<void> _guardarProgreso(int nuevoNivel) async {
    if (_usuarioId == 0) return;

    double nuevoPorcentaje = (nuevoNivel / _cantidadNiveles) * 100;

    await progresoService.actualizarProgreso(
        _usuarioId, widget.juegoId, nuevoNivel, nuevoPorcentaje);

    setState(() {
      _nivelActual = nuevoNivel;
      _progreso = nuevoPorcentaje / 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Niveles",
          style: TextStyle(
            fontSize: 20,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProgressBar(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount:
                    _cantidadNiveles, // Carga dinámicamente la cantidad de niveles
                itemBuilder: (context, index) {
                  int nivel = index + 1;
                  bool desbloqueado = nivel <= _nivelActual;
                  return _buildLevelButton(nivel, desbloqueado);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir la barra de progreso
  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Progreso: ${(_progreso * 100).toInt()} %",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: _progreso,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          minHeight: 8,
        ),
      ],
    );
  }

  // Método para construir los botones de los niveles
  Widget _buildLevelButton(int nivel, bool desbloqueado) {
    return GestureDetector(
      onTap: desbloqueado
          ? () async {
              // Obtener el nombre del juego desde la API
              String nombreJuego = _nombreJuego;

              // Seleccionar la pantalla correcta según el nombre del juego
              Widget pantallaJuego;
              if (nombreJuego == "Voltea la Carta") {
                pantallaJuego = GameCartaScreen(
                  nivel: nivel,
                  juegoId: widget.juegoId,
                  onLevelComplete: () => _guardarProgreso(nivel + 1),
                );
              } else if (nombreJuego == "Selecciona el significado") {
                pantallaJuego = JuegoSignificadoScreen(
                  nivel: nivel,
                  juegoId: widget.juegoId,
                  onLevelComplete: () => _guardarProgreso(nivel + 1),
                );
              } else {
                print("⚠️ Juego desconocido: $nombreJuego");
                return;
              }

              // Navegar a la pantalla correspondiente
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => pantallaJuego),
              ).then((_) => _cargarDatos()); // Recargar progreso al volver
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: desbloqueado ? Colors.lightGreenAccent : Colors.grey[400],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.extension, size: 30, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  "Nivel $nivel",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Icon(
              desbloqueado ? Icons.play_arrow : Icons.lock,
              size: 30,
              color: desbloqueado ? Colors.black : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_screen.dart'; // Importamos la pantalla del juego
import '../../services/progreso_service.dart';
import '../../models/progreso.dart';

class LevelsScreen extends StatefulWidget {
  final int juegoId;

  const LevelsScreen({Key? key, required this.juegoId}) : super(key: key);

  @override
  _LevelsScreenState createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  int _nivelActual = 1;
  double _progreso = 0.0;
  int _usuarioId = 0;
  ProgresoService progresoService = ProgresoService();

  @override
  void initState() {
    super.initState();
    _cargarProgreso();
  }

  // Cargar el progreso desde la API
  Future<void> _cargarProgreso() async {
    final prefs = await SharedPreferences.getInstance();
    _usuarioId = prefs.getInt('userId') ?? 0;

    if (_usuarioId != 0) {
      Progreso? progreso =
          await progresoService.obtenerProgreso(_usuarioId, widget.juegoId);
      if (progreso != null) {
        setState(() {
          _nivelActual = progreso.nivelActual;
          _progreso = progreso.porcentajeProgreso / 100;
        });
      }
    }
  }

  // Guardar progreso en la API
  Future<void> _guardarProgreso(int nuevoNivel) async {
    if (_usuarioId == 0) return;
    await progresoService.actualizarProgreso(
        _usuarioId, nuevoNivel, (nuevoNivel - 1) * 20.0);
    setState(() {
      _nivelActual = nuevoNivel;
      _progreso = (nuevoNivel - 1) / 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Niveles",
          style: TextStyle(
            fontSize: 20,
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProgressBar(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  int nivel = index + 1;
                  bool desbloqueado = nivel <= _nivelActual;
                  return _buildLevelButton(nivel, desbloqueado);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir la barra de progreso
  Widget _buildProgressBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Progreso: ${(_progreso * 100).toInt()} %",
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        LinearProgressIndicator(
          value: _progreso,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          minHeight: 8,
        ),
      ],
    );
  }

  // Método para construir los botones de los niveles
  Widget _buildLevelButton(int nivel, bool desbloqueado) {
    return GestureDetector(
      onTap: desbloqueado
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameScreen(
                    nivel: nivel,
                    juegoId: widget.juegoId,
                    onLevelComplete: () => _guardarProgreso(nivel + 1),
                  ),
                ),
              );
            }
          : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.extension, size: 30, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  "Nivel $nivel",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Icon(
              desbloqueado ? Icons.play_arrow : Icons.lock,
              size: 30,
              color: desbloqueado ? Colors.black : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
*/
