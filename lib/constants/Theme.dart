import 'dart:ui' show Color;
import 'package:flutter/material.dart';

class NowUIColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color defaultColor = Color.fromRGBO(136, 136, 136, 1.0);
  static const Color primary = Color.fromARGB(255, 50, 202, 249);
  static const Color secondary = Color.fromRGBO(68, 68, 68, 1.0);
  static const Color label = Color.fromRGBO(254, 36, 114, 1.0);
  static const Color neutral = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color tabs = Color.fromRGBO(222, 222, 222, 0.3);
  static const Color info = Color.fromRGBO(44, 168, 255, 1.0);
  static const Color error = Color.fromRGBO(255, 54, 54, 1.0);
  static const Color success = Color.fromRGBO(24, 206, 15, 1.0);
  static const Color warning = Color.fromRGBO(255, 178, 54, 1.0);
  static const Color text = Color.fromRGBO(44, 44, 44, 1.0);
  static const Color bgColorScreen = Color.fromRGBO(255, 255, 255, 1.0);
  static const Color border = Color.fromRGBO(231, 231, 231, 1.0);
  static const Color inputSuccess = Color.fromRGBO(27, 230, 17, 1.0);
  static const Color input = Color.fromRGBO(220, 220, 220, 1.0);
  static const Color inputError = Color.fromRGBO(255, 54, 54, 1.0);
  static const Color muted = Color.fromRGBO(136, 152, 170, 1.0);
  static const Color time = Color.fromRGBO(154, 154, 154, 1.0);
  static const Color priceColor = Color.fromRGBO(234, 213, 251, 1.0);
  static const Color active = Color.fromRGBO(249, 99, 50, 1.0);
  static const Color buttonColor = Color.fromRGBO(156, 38, 176, 1.0);
  static const Color placeholder = Color.fromRGBO(159, 165, 170, 1.0);
  static const Color switchON = Color.fromRGBO(249, 99, 50, 1.0);
  static const Color switchOFF = Color.fromRGBO(137, 137, 137, 1.0);
  static const Color gradientStart = Color.fromRGBO(107, 36, 170, 1.0);
  static const Color gradientEnd = Color.fromRGBO(172, 38, 136, 1.0);
  static const Color socialFacebook = Color.fromRGBO(59, 89, 152, 1.0);
  static const Color socialTwitter = Color.fromRGBO(91, 192, 222, 1.0);
  static const Color socialDribbble = Color.fromRGBO(234, 76, 137, 1.0);

  // Nuevos colores
  static const Color lightBlue = Color(0xFF81D4FA);
  static const Color lightGreen = Color(0xFF81C784);
  static const Color lightOrange = Color(0xFFFFB74D);
  static const Color lightPurple = Color(0xFFBA68C8);

  // Método para aplicar fondo degradado
  static BoxDecoration gradientBackground(List<Color> colors) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
    );
  }

  // Degradado para SignToTextScreen (Suave y tranquilo)
  static BoxDecoration signToTextGradient() {
    return gradientBackground([
      Color(0xFFB3E5FC), // Celeste claro (relajante)
      Color(0xFF81D4FA), // Azul pastel
      Color(0xFF4FC3F7), // Azul cielo suave
      Color(0xFFD1C4E9), // Lila sutil (creatividad)
      Color(0xFFEDE7F6), // Lavanda claro (suave y elegante)
    ]);
  }

// Degradado para AlphabetScreen (Equilibrio y energía positiva)
  static BoxDecoration alphabetGradient() {
    return gradientBackground([
      Color(0xFFA7FFEB), // Verde menta suave (frescura)
      Color(0xFF80DEEA), // Turquesa claro (creatividad)
      Color(0xFFFFF59D), // Amarillo pastel (alegría)
      Color(0xFFFFD180), // Durazno claro (cálido y amigable)
      Color(0xFFE1F5FE), // Azul muy claro (tranquilidad)
    ]);
  }

// Degradado para signs_screen (Juvenil y moderno)
  static BoxDecoration signs_screen() {
    return gradientBackground([
      Color(0xFFFFF3E0), // Crema pastel (acogedor)
      Color(0xFFFFCCBC), // Coral suave (energía sin ser intenso)
      Color(0xFFE1BEE7), // Lila pastel (creatividad)
      Color(0xFFB2EBF2), // Azul aguamarina (relajante)
      Color(0xFFF8BBD0), // Rosa pastel (suave y amigable)
    ]);
  }
}
