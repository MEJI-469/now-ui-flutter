// Servicio para gestionar los juegos desde el backend
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/juego.dart';

class JuegoService {
  final String baseUrl =
      'https://creative-joy-production.up.railway.app/api/juego';
  //final String baseUrl = 'http://192.168.52.43:8080/api/juego';

  // Método para obtener la lista de juegos desde el backend
  Future<List<Juego>> getJuegos() async {
    final response = await http.get(Uri.parse(baseUrl));
    print("🔵 Respuesta del servidor: ${response.body}"); // Ver qué JSON llega
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((e) => Juego.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener los juegos desde el backend');
    }
  }

  // Método para obtener un juego específico por ID desde el backend
  Future<Juego> getJuegoById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'));
    print("🟢 Respuesta del servidor: ${response.body}"); // Ver qué JSON llega
    if (response.statusCode == 200) {
      return Juego.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Error al obtener el juego');
    }
  }

  // Método para obtener el nombre del juego desde la API
  Future<String> _obtenerNombreJuego(int juegoId) async {
    try {
      final juego = await JuegoService().getJuegoById(juegoId);
      print("Nombre del juego: $getJuegoById(nombre) ");
      return juego.nombreJuego; // Extraemos el nombre del juego
    } catch (e) {
      print("⚠️ Error al obtener el nombre del juego: $e");
      return "Desconocido"; // En caso de error, devolvemos un valor por defecto
    }
  }
}
