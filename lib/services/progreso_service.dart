import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/progreso.dart';

class ProgresoService {
  static const String baseUrl =
      'https://creative-joy-production.up.railway.app/api/progreso';
  //static const String baseUrl = 'http://192.168.52.43:8080/api/progreso';

  // Obtener progreso del usuario en un juego
  Future<Progreso?> obtenerProgreso(int usuarioId, int juegoId) async {
    final response = await http.get(Uri.parse('$baseUrl/$usuarioId/$juegoId'));
    if (response.statusCode == 200) {
      print("🟢 Progreso del usuario cargado corectamente: ${response.body}");
      return Progreso.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // Crear progreso si no existe
  Future<Progreso?> crearProgreso(int usuarioId, int juegoId) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario': {'id': usuarioId},
        'juego': {'idJuego': juegoId},
        'nivel_actual': 1,
        'porcentaje_progreso': 0.0
      }),
    );
    print("🔵 Creando progreso: ${response.body}");
    if (response.statusCode == 201) {
      return Progreso.fromJson(jsonDecode(response.body));
    } else {
      print("🔴 Error al crear progreso: ${response.statusCode}");
      return null;
    }
  }

  // Actualizar progreso solo si el usuario avanza
  /*Future<bool> actualizarProgreso(
      int idProgreso, int nuevoNivel, double nuevoProgreso) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$idProgreso'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nivel_actual': nuevoNivel,
        'porcentaje_progreso': nuevoProgreso,
      }),
    );
    return response.statusCode == 200;
  }*/
  Future<bool> actualizarProgreso(
      int usuarioId, int juegoId, int nuevoNivel, double nuevoProgreso) async {
    // Obtener el progreso correcto antes de actualizar
    Progreso? progreso = await obtenerProgreso(usuarioId, juegoId);
    if (progreso == null) {
      print(
          "⚠️ Error: No se encontró progreso para usuario $usuarioId en el juego $juegoId.");
      return false;
    }

    final response = await http.put(
      Uri.parse(
          '$baseUrl/${progreso.idProgreso}'), // Asegurar que se usa el ID correcto
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nivel_actual': nuevoNivel,
        'porcentaje_progreso': nuevoProgreso,
      }),
    );

    print(
        "🟢 Respuesta del servidor (${response.statusCode}): ${response.body}");

    return response.statusCode == 200;
  }
}
