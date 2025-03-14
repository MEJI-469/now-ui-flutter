import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cargar_traduccion.dart';
import '../services/historial_traduccion_service.dart';
import 'translation_details.dart';

import 'dart:ui';

import 'package:now_ui_flutter/constants/Theme.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/input.dart';

import 'package:now_ui_flutter/widgets/drawer.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<CargarTraduccion> _allHistorial = []; // Historial completo
  List<CargarTraduccion> _filteredHistorial = []; // Historial filtrado
  bool _isLoading = true;

  final bool _checkboxValue = false;

  final double height = window.physicalSize.height;

  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarHistorial();
  }

  Future<void> _cargarHistorial() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId =
          prefs.getInt('userId'); // Recupera el ID del usuario actual

      if (userId != null) {
        // Llama al servicio para obtener el historial del usuario
        final historial = await HistorialTraduccionService()
            .obtenerHistorialPorUsuario(userId);
        setState(() {
          _allHistorial = historial;
          _filteredHistorial = historial; // al inicio, sin filtro
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Error: No se encontró la sesión del usuario")),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar el historial: $e")),
      );
      print("Error al cargar el historial: $e");
    }
  }

  void _filterByDate(String query) {
    print("Buscando: $query"); // debug
    setState(() {
      // Si el usuario borró todo y la query es vacía, mostramos todo:
      if (query.isEmpty) {
        _filteredHistorial = _allHistorial;
      } else {
        final lowerQuery = query.toLowerCase();
        _filteredHistorial = _allHistorial.where((item) {
          return item.fechaTraduccion.toLowerCase().contains(lowerQuery);
          print("Buscando: $query"); // debug
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Historial",
        searchBar: true,
        backButton: true,
        tags: [], // List<String>
        getCurrentPage: () => 1, // Una función que retorne int
        searchController: _searchCtrl,
        searchOnChanged: (text) {
          _filterByDate(text);
        },
      ),
      backgroundColor: NowUIColors.bgColorScreen,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _filteredHistorial.isEmpty
              ? const Center(child: Text("No hay traducciones registradas"))
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ListView.builder(
                    itemCount: _filteredHistorial.length,
                    itemBuilder: (context, index) {
                      final traduccion = _filteredHistorial[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.access_time,
                              size: 40,
                              color: Colors.grey,
                            ),
                            title: Text(
                              "Traducción ${traduccion.idCargarTraduccion}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle:
                                Text("Fecha: ${traduccion.fechaTraduccion}"),
                            trailing: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TranslationDetails(
                                        traduccion: traduccion),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                side: const BorderSide(color: Colors.blue),
                              ),
                              child: const Text(
                                "Ver",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
