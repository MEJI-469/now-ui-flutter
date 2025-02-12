import 'dart:ui';
import 'package:flutter/material.dart';

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
                image: AssetImage("assets/imgs/ista.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenido principal
          SafeArea(
            child: Container(
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: MediaQuery.of(context).size.height * 0.15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Logo y título
                  Column(
                    children: [
                      Image.asset("assets/imgs/logo_manos.png", scale: 3.5),
                      SizedBox(height: 20),
                      Container(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "Mano Amiga",
                                    style: TextStyle(
                                      color: NowUIColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Text(
                                    "TEC",
                                    style: TextStyle(
                                      color: NowUIColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
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
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Image.asset("assets/imgs/ista-rectangle-f.png",
                              scale: 5.5)
                        ],
                      ),
                      SizedBox(height: 8.0),
                      // Si no usas la segunda línea de créditos, quítala o coméntala.
                      /*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Coded By",
                              style: TextStyle(
                                  color: NowUIColors.white,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.3)),
                          SizedBox(width: 10.0),
                          Image.asset("assets/imgs/creative-tim.png", scale: 7.0),
                        ],
                      ),
                      */
                    ],
                  ),
                  // Botones
                  Column(
                    children: [
                      // Primer botón
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
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Text(
                              "EMPEZAR",
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                        ),
                      ),
                      // Espacio entre los botones
                      SizedBox(height: 16.0),
                      // Segundo botón duplicado con otra ruta y otro texto
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
                              // Aquí la ruta que necesites
                              Navigator.pushReplacementNamed(context, '/home');
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
        ],
      ),
    );
  }
}
