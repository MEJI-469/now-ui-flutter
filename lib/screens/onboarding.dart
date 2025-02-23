import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Imagen de fondo
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imgs/bg-on-two.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: MediaQuery.of(context).size.height * 0.05,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // Logo y título
                        Column(
                          children: [
                            Image.asset("assets/imgs/logo-of.png", scale: 6),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                Stack(
                                  children: [
                                    Image.asset("assets/imgs/slogan-bg.png",
                                        scale: 1.5),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Créditos
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Diseñado por",
                                  style: TextStyle(
                                    color: NowUIColors.white,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.3,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Image.asset("assets/imgs/logo-tec-cicular.png",
                                    scale: 3),
                              ],
                            ),
                          ],
                        ),
                        // Botones
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: NowUIColors.white,
                                    backgroundColor: NowUIColors.info,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                  child: Text(
                                    "EMPEZAR",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: NowUIColors.white,
                                    backgroundColor: Colors.orangeAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 16.0),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/home');
                                  },
                                  child: Text(
                                    "INVITADO",
                                    style: TextStyle(fontSize: 12.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Footer con fondo semitransparente y sombra en el texto
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    color:
                        Colors.black.withOpacity(0.5), // Fondo semitransparente
                    child: Center(
                      child: Text(
                        "© 2025 Desarrollo de Software Copyright. \nTodos los derechos reservados.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          shadows: [
                            Shadow(
                              blurRadius: 3.0,
                              color: Colors.black,
                              offset: Offset(1.5,
                                  1.5), // Sombra para mejorar la visibilidad
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
