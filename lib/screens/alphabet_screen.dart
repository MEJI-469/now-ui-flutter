import 'package:flutter/material.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';
import 'package:now_ui_flutter/screens/sings_screen.dart';

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
      body: Container(
        decoration: NowUIColors.alphabetGradient(), // Added gradient
        child: SafeArea(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //Inicia boton letras
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SingsScreen(contentType: 'alphabet'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent, // Changed text color
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
                            color: Colors.blueAccent, // Changed icon color
                          ),
                          SizedBox(width: 20),
                          Text('Abecedario',
                              style: TextStyle(
                                  color:
                                      Colors.blueAccent)), // Changed text color
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.blueAccent, // Changed icon color
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //Inicia boton numeros
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SingsScreen(contentType: 'numbers'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent, // Changed text color
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
                            color: Colors.blueAccent, // Changed icon color
                          ),
                          SizedBox(width: 20),
                          Text('Numeros',
                              style: TextStyle(
                                  color:
                                      Colors.blueAccent)), // Changed text color
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.blueAccent, // Changed icon color
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //Inicia boton Meses
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SingsScreen(contentType: 'months'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent, // Changed text color
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
                            color: Colors.blueAccent, // Changed icon color
                          ),
                          SizedBox(width: 20),
                          Text('Meses del Año',
                              style: TextStyle(
                                  color:
                                      Colors.blueAccent)), // Changed text color
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.blueAccent, // Changed icon color
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //Inicia boton Colores
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SingsScreen(contentType: 'colors'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent, // Changed text color
                        fontWeight: FontWeight.bold,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.color_lens,
                            size: 40,
                            color: Colors.blueAccent, // Changed icon color
                          ),
                          SizedBox(width: 20),
                          Text('Colores',
                              style: TextStyle(
                                  color:
                                      Colors.blueAccent)), // Changed text color
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.blueAccent, // Changed icon color
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //Inicia boton Semana
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SingsScreen(contentType: 'week'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent, // Changed text color
                        fontWeight: FontWeight.bold,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.calendar_today,
                            size: 40, // Changed icon to calendar_today
                            color: Colors.blueAccent, // Changed icon color
                          ),
                          SizedBox(width: 20),
                          Text('Días de la Semana',
                              style: TextStyle(
                                  color:
                                      Colors.blueAccent)), // Changed text color
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.blueAccent, // Changed icon color
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                //Inicia boton Animales
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SingsScreen(contentType: 'animals'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent, // Changed text color
                        fontWeight: FontWeight.bold,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.pets,
                            size: 40, // Changed icon to pets
                            color: Colors.blueAccent, // Changed icon color
                          ),
                          SizedBox(width: 20),
                          Text('Animales',
                              style: TextStyle(
                                  color:
                                      Colors.blueAccent)), // Changed text color
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 30,
                        color: Colors.blueAccent, // Changed icon color
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
