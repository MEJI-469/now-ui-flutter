import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:ui';

import 'package:now_ui_flutter/constants/Theme.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/input.dart';

import 'package:now_ui_flutter/widgets/drawer.dart';

class ScreenTemplates extends StatelessWidget {
  const ScreenTemplates({Key? key}) : super(key: key);

  //final String title;

  //const ScreenTemplates({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Screens Templates",
        reverseTextcolor: true,
        tags: [], // List<String> obligatorio
        getCurrentPage: () => 0, // o alguna lógica que retorne un int
        searchController: TextEditingController(),
        searchOnChanged: (text) {
          // tu lógica
        },
      ),
      backgroundColor: NowUIColors.bgColorScreen,
      extendBodyBehindAppBar: true,
      drawer: NowDrawer(currentPage: "Screens"),
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Inicia boton letras
              ElevatedButton(
                onPressed: () {
                  print("Boton 'Componentes' presionado");
                  Navigator.pushReplacementNamed(context, '/components');
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          FontAwesomeIcons.dharmachakra,
                          size: 35,
                        ),
                        SizedBox(width: 20),
                        Text('Componentes'),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              //Inicia boton numeros
              ElevatedButton(
                onPressed: () {
                  print("Boton 'Articles' presionado");
                  Navigator.pushReplacementNamed(context, '/articles');
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          FontAwesomeIcons.newspaper,
                          size: 35,
                        ),
                        SizedBox(width: 20),
                        Text('Articulos'),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("Boton 'Pro' presionado");
                  Navigator.pushReplacementNamed(context, '/pro');
                },
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(
                          FontAwesomeIcons.crown,
                          size: 35,
                        ),
                        SizedBox(width: 20),
                        Text('Pro'),
                      ],
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
