import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/historial_traduccion.dart';
import '../models/cargar_traduccion.dart';

class HistorialTraduccionService {
  final String baseUrl = "https://creative-joy-production.up.railway.app/api";
  //final String baseUrl = "http://192.168.52.59:8080/api";

  // Obtener todo el historial de traducción
  Future<List<HistorialTraduccion>> obtenerHistorial() async {
    final url = Uri.parse("$baseUrl/historial");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Decodificar en UTF-8 para que ñ/acentos salgan bien
      final decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data = jsonDecode(decodedBody);
      return data.map((json) => HistorialTraduccion.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener el historial de traducción");
    }
  }

  // Crear un nuevo registro en el historial
  Future<bool> crearHistorial(HistorialTraduccion historial) async {
    final url = Uri.parse("$baseUrl/historial");
    print(
        "Datos enviados al backend para guardar: ${jsonEncode(historial.toJson())}");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(historial.toJson()),
    );

    print("Estado del guardado: ${response.statusCode}");
    print("Respuesta del backend: ${response.body}");

    return response.statusCode == 201; // Devuelve true si se creó con éxito
  }

  // Eliminar un registro del historial
  Future<bool> eliminarHistorial(int idHistorial) async {
    final url = Uri.parse("$baseUrl/eliminar/$idHistorial");
    final response = await http.delete(url);

    return response.statusCode == 204; // Devuelve true si se eliminó con éxito
  }

  // Obtener las traducciones de un usuario
  Future<List<CargarTraduccion>> obtenerHistorialPorUsuario(int userId) async {
    final url = Uri.parse("$baseUrl/historial/usuario/$userId");
    final response = await http.get(url);

    // Log para imprimir la respuesta
    print("Respuesta completa del backend: ${response.body}");

    if (response.statusCode == 200) {
      try {
        // Decodifica en UTF-8
        final decodedBody = utf8.decode(response.bodyBytes);
        final List<dynamic> data = jsonDecode(decodedBody);

        return data.map((json) => CargarTraduccion.fromJson(json)).toList();
      } catch (e) {
        print("Error al procesar la respuesta: $e");
        throw Exception("Error al procesar la respuesta del servidor");
      }
    } else {
      throw Exception("Error al obtener el historial: ${response.statusCode}");
    }
  }

  // Obtener las traducciones de un usuario por fechas
  Future<List<CargarTraduccion>> obtenerHistorialPorRango(
      int userId, String startDate, String endDate) async {
    final url = Uri.parse(
        "$baseUrl/historial/usuario/$userId/rango?start=$startDate&end=$endDate");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // También aquí decodificamos en UTF-8
      final decodedBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data = jsonDecode(decodedBody);
      return data.map((json) => CargarTraduccion.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener el historial: ${response.statusCode}");
    }
  }
}
