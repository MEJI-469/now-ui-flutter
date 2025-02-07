import 'package:flutter/material.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';

class AlphabetScreen extends StatelessWidget {
  final String title;

  const AlphabetScreen({Key? key, this.title = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Abecedario",
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
      drawer: NowDrawer(currentPage: "Alphabet"),
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
                  print("Boton ' Abecedario' presionado");
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
                          Icons.abc,
                          size: 40,
                        ),
                        SizedBox(width: 20),
                        Text('Abecedario'),
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
                  print("Boton ' Abecedario' presionado");
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
                          Icons.numbers,
                          size: 40,
                        ),
                        SizedBox(width: 20),
                        Text('Numeros'),
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
              //Inicia boton Meses
              ElevatedButton(
                onPressed: () {
                  print("Boton ' Meses' presionado");
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
                          Icons.calendar_month,
                          size: 40,
                        ),
                        SizedBox(width: 20),
                        Text('Meses del Año'),
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
            ],
          ),
        )),
      ),
    );
  }
}
