import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/input.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';

// ------------------ NUEVO: imports para la lógica  ------------------ //
import 'package:shared_preferences/shared_preferences.dart';
import 'package:now_ui_flutter/services/usuario_service.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _checkboxValue = false;

  // ------------------ NUEVO: controllers y servicio ------------------ //
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UsuarioService _usuarioService = UsuarioService();

  // El height venía de window, puedes usarlo o quitarlo
  final double height = window.physicalSize.height;

  // ------------------ NUEVO: método para login  ------------------ //
  void _performLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Por favor, completa todos los campos")),
      );
      return;
    }

    try {
      // Llamamos al login de UsuarioService (Proyecto2)
      final usuario = await _usuarioService.login(username, password);

      if (usuario != null) {
        // Guardar estado de sesión y datos del usuario
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setInt('userId', usuario.id);
        await prefs.setString('userName', usuario.usuario);
        await prefs.setString('userPassword', usuario.password);
        await prefs.setString('userNombre', usuario.nombre);
        await prefs.setInt('userEdad', usuario.edad);
        await prefs.setString('userTelefono', usuario.telefono);
        await prefs.setString('userEmail', usuario.correo);
        await prefs.setBool('userCarnet', usuario.carnetDiscapacidad);
        await prefs.setString('userNumeroCarnet', usuario.numeroCarnet ?? '');
        await prefs.setInt(
            'userPorcentaje', usuario.porcentajeDeDiscapacidad ?? 0);
        // ... si tienes otros campos, guárdalos aquí

        print("ID del usuario guardado: ${usuario.id}");
        print("Nombre de usuario guardado: ${usuario.usuario}");
        print("Edad del usuario guardado: ${usuario.edad}");
        print("Telefono del usuario guardado: ${usuario.telefono}");
        print(
            "Tiene discapacidad del usuario guardado: ${usuario.carnetDiscapacidad}");
        print("num carnet del usuario guardado: ${usuario.numeroCarnet}");
        print(
            "porcentaje carnet del usuario guardado: ${usuario.porcentajeDeDiscapacidad}");

        // Navegamos a /home
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Credenciales incorrectas
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Usuario o contraseña incorrectos")),
        );
      }
    } catch (e) {
      // Error en la petición o en el servidor
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al conectar con el servidor: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NowDrawer(currentPage: "Login"),
      body: Stack(
        children: [
          // Fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imgs/register-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 45, left: 16.0, right: 16.0, bottom: 32),
                  child: Card(
                    elevation: 5,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.78,
                      color: NowUIColors.bgColorScreen,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10.0, bottom: 8),
                                child: Center(
                                  child: Text(
                                    "Iniciar sesión",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "assets/imgs/logo-of-bw.png",
                                    scale: 2,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10.0, bottom: 10.0),
                                child: Center(
                                  child: Text(
                                    "Binevenido a nuestra App",
                                    style: TextStyle(
                                      color: NowUIColors.time,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              // Campos de texto
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Usuario
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Input(
                                      placeholder: "Su Usuario...",
                                      prefixIcon: Icon(Icons.email, size: 20),
                                      suffixIcon: Icon(Icons.check),
                                      // NUEVO: usa el controller
                                      controller: _usernameController,
                                      onTap: () {
                                        print("Input tapped!");
                                      },
                                      onChanged: (value) {
                                        print("Nuevo valor: $value");
                                      },
                                    ),
                                  ),
                                  // Contraseña
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 0),
                                    child: Input(
                                      placeholder: "Contraseña...",
                                      prefixIcon: Icon(Icons.lock, size: 20),
                                      suffixIcon: Icon(Icons.check),
                                      // NUEVO: usa el controller
                                      controller: _passwordController,
                                      // si el widget Input lo permite, podrías agregar obscureText: true
                                      onTap: () {
                                        print("Input tapped!");
                                      },
                                      onChanged: (value) {
                                        print("Nuevo valor: $value");
                                      },
                                    ),
                                  ),
                                  // Recordarme
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 0, bottom: 16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Checkbox(
                                          activeColor: NowUIColors.primary,
                                          onChanged: (bool? newValue) =>
                                              setState(
                                            () => _checkboxValue = newValue!,
                                          ),
                                          value: _checkboxValue,
                                        ),
                                        Text(
                                          "Recordarme.",
                                          style: TextStyle(
                                              color: NowUIColors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w200),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Link de registro
                                  Center(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "¿No tienes cuenta? ",
                                          style: TextStyle(
                                            color: NowUIColors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/account');
                                          },
                                          child: Text(
                                            "Regístrate aquí",
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // Botón de login
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: NowUIColors.primary,
                                    foregroundColor: NowUIColors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ),
                                  ),
                                  // NUEVO: llama a _performLogin
                                  onPressed: _performLogin,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 32.0,
                                        right: 32.0,
                                        top: 12,
                                        bottom: 12),
                                    child: Text(
                                      "Ingresar...",
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
