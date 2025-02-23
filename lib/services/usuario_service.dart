import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class UsuarioService {
  final String baseUrl = "https://creative-joy-production.up.railway.app/api";
  //final String baseUrl = "http://192.168.18.240:8080/api/usuario"; // URL para conectar con el móvil localmente
  //final String baseUrl = "http://192.168.52.59:8080/api"; // URL para conectar con el móvil localmente

  // Método para obtener la lista de usuarios
  Future<List<Usuario>> obtenerUsuarios() async {
    final url = Uri.parse("$baseUrl/usuario");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception("Error al obtener la lista de usuarios");
    }
  }

  Future<Usuario?> login(String username, String password) async {
    final url = Uri.parse("$baseUrl/login");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'usuario': username, 'pasword': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['success'] == true) {
        // Devuelve un objeto Usuario con los datos del backend
        return Usuario(
          id: data['id'],
          usuario: username,
          password: password,
          nombre: data['nombre'] ?? "",
          edad:
              data['edad'] ?? 0, // No devuelto por el backend, se puede ajustar
          telefono: data['telefono'] ?? "",
          correo: data['correo'] ?? "",
          carnetDiscapacidad: data['carnet_discapacidad'] ??
              false, // Ajustar según el backend si es necesario
          porcentajeDeDiscapacidad: data['porcentaje_de_discapacidad'] ??
              0, // Ajustar según el backend si es necesario
          numeroCarnet: data['numero_carnet'] ??
              "", // Ajustar según el backend si es necesario
        );
      }
    } else if (response.statusCode == 401) {
      return null; // Credenciales incorrectas
    } else {
      throw Exception("Error en el servidor: ${response.statusCode}");
    }
    return null;
  }

  // Método para registrar un usuario
  static const String _baseUrl =
      "https://creative-joy-production.up.railway.app/api";
  //static const String _baseUrl = "http://192.168.52.59:8080/api";

  static Future<bool> registerUser({
    required String usuario,
    required String password,
    required String nombre,
    required int edad,
    required String telefono,
    required String correo,
    required bool carnetDiscapacidad,
    int? porcentajeDiscapacidad,
    String? numeroCarnet,
  }) async {
    final url = Uri.parse("$_baseUrl/usuario");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "usuario": usuario,
        "pasword": password,
        "nombre": nombre,
        "edad": edad,
        "telefono": telefono,
        "correo": correo,
        "carnet_discapacidad": carnetDiscapacidad,
        "porcentaje_de_discapacidad": porcentajeDiscapacidad,
        "numero_carnet": numeroCarnet,
      }),
    );

    print("Estado de respuesta: ${response.statusCode}");
    print("Cuerpo de respuesta: ${response.body}");

    return response.statusCode == 201; // Devuelve true si se registra con éxito
  }

  // Método para actualizar/editar un usuario
  static Future<bool> updateUser({
    required int id,
    required String usuario,
    required String password,
    required String nombre,
    required int edad,
    required String telefono,
    required String correo,
    required bool carnetDiscapacidad,
    int? porcentajeDiscapacidad,
    String? numeroCarnet,
  }) async {
    final url = Uri.parse("$_baseUrl/usuario/$id");

    // Armamos el JSON según lo que el backend espera:
    final body = jsonEncode({
      "usuario": usuario,
      "pasword": password,
      "nombre": nombre,
      "edad": edad,
      "telefono": telefono,
      "correo": correo,
      "carnet_discapacidad": carnetDiscapacidad,
      "porcentaje_de_discapacidad": porcentajeDiscapacidad,
      "numero_carnet": numeroCarnet,
    });

    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    print("Respuesta updateUser() -> status: ${response.statusCode}");
    print("Respuesta updateUser() -> body: ${response.body}");

    // Tu endpoint de @PutMapping usa @ResponseStatus(HttpStatus.CREATED),
    // lo que significa que usualmente retornará código 201
    // Podrías chequear 200, 201 o 204 según el caso
    return (response.statusCode == 201);
  }
}
