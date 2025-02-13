import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Importa también las pantallas que ya existen en tu Proyecto1
// ... y así con todas las que necesites

class CheckSession extends StatelessWidget {
  const CheckSession({Key? key}) : super(key: key);

  // Lógica de Proyecto2 para ver si hay sesión guardada
  Future<bool> _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        // Mientras se carga la info de SharedPreferences
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Si ya tenemos el dato de "isLoggedIn"
        if (snapshot.hasData && snapshot.data == true) {
          // Está logueado: navega a la pantalla "Home" de Proyecto1
          // (usando pushReplacement para no volver atrás)
          Future.microtask(
              () => Navigator.pushReplacementNamed(context, '/home'));
        } else {
          // No está logueado: navega al Onboarding (o /login) de Proyecto1
          Future.microtask(
              () => Navigator.pushReplacementNamed(context, '/onboarding'));
        }

        // Mientras hace el Future.microtask, devolvemos algo vacío
        return Container();
      },
    );
  }
}
