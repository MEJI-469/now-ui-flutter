import 'package:flutter/material.dart';
import '../../services/juego_service.dart'; // Importamos el servicio del backend
import '../../models/juego.dart';
import 'levels_screen.dart'; // Importamos la pantalla de niveles

import 'package:shared_preferences/shared_preferences.dart';
import '../../models/cargar_traduccion.dart';
import '../../services/historial_traduccion_service.dart';
import '../translation_details.dart';

import 'dart:ui';

import 'package:now_ui_flutter/constants/Theme.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/input.dart';

import 'package:now_ui_flutter/widgets/drawer.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({Key? key}) : super(key: key);

  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final JuegoService _juegoService = JuegoService(); // Instancia del servicio
  late Future<List<Juego>> _juegosFuture; // Futuro para cargar los juegos

  @override
  void initState() {
    super.initState();
    _juegosFuture =
        _juegoService.getJuegos(); // Cargar juegos al iniciar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Juegos",
        reverseTextcolor: true,
        tags: [], // List<String> obligatorio
        getCurrentPage: () => 0, // o alguna lógica que retorne un int
        searchController: TextEditingController(),
        searchOnChanged: (text) {
          // tu lógica
        },
      ),
      backgroundColor: NowUIColors.bgColorScreen,
      extendBodyBehindAppBar: true,
      drawer: NowDrawer(currentPage: "Games"),
      body: FutureBuilder<List<Juego>>(
        future: _juegosFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Indicador de carga
          } else if (snapshot.hasError) {
            return const Center(
                child: Text("Error al cargar los juegos")); // Manejo de error
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text("No hay juegos disponibles")); // Caso sin datos
          } else {
            List<Juego> juegos = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: juegos.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelsScreen(
                              juegoId: juegos[index].idJuego ??
                                  0), // Pasamos el ID del juego
                        ),
                      );
                    },
                    child: _buildGameCard(
                      title: juegos[index].nombreJuego,
                      description: juegos[index].descripcionJuego,
                      icon: Icons.gamepad,
                      color: Colors.blueAccent,
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  // Método para construir las tarjetas de los juegos
  Widget _buildGameCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: color,
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
        children: [
          Icon(icon, size: 50, color: Colors.white),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
