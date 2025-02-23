import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:now_ui_flutter/constants/Theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/card-horizontal.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';
import 'package:now_ui_flutter/widgets/slider-product.dart';

// import 'package:now_ui_flutter/screens/product.dart';

final Map<String, Map<String, dynamic>> articlesCards = {
  "Developers": {
    "title": "View developers",
    "image":
        "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
    "participants": [
      {
        "img":
            "https://scontent.fcue2-1.fna.fbcdn.net/v/t39.30808-6/464858886_2382641502067015_9201867715336565630_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_eui2=AeFxUiICc_klJ1UThpjF5ZrZvuX8mwJHL2u-5fybAkcva18fwEAtHyAEAhOG2XRASlrQX5c5zEsm1a5Sk67R5brk&_nc_ohc=w_oUyj3CslAQ7kNvgFBws-I&_nc_oc=Adg-GjB7uUB16FJFze5irtoU_A-ozsZhjIQBJrHGzgXteVIrfhPyb-j6bPqABW7Yo-0&_nc_zt=23&_nc_ht=scontent.fcue2-1.fna&_nc_gid=ANzYKqaHeMutAj5bSqxGcAi&oh=00_AYBiwO9WZGMZJ7orTalIEOnBfwwkH_6T-BFHbInCclVbmw&oe=67BFEC84",
        "title": "Derek Vergara",
        "description": "Scrum Master, Desarrollador y Tester",
        "price": "\©",
        "url": "https://wa.me/+593 96 887 5491",
      },
      {
        "img":
            "https://th.bing.com/th/id/OIP.jUQ3nbMKbg_N4NSD_f68UwHaHa?rs=1&pid=ImgDetMain",
        "title": "Bryam Escobar",
        "description": "Desarrollador y Tester",
        "price": "\©",
        "url": "https://wa.me/+593 96 326 8696",
      },
      {
        "img":
            "https://www.creativefabrica.com/wp-content/uploads/2023/07/02/Anime-Software-Engineer-Working-On-73473900-1.png",
        "title": "Marlon Marca",
        "description": "Desarrollador y Tester",
        "price": "\©",
        "url": "https://wa.me/+593 98 403 7422",
      },
      {
        "img":
            "https://th.bing.com/th/id/OIP.mB6G7-uaYdOqCRSZvdZN1gHaHa?w=626&h=626&rs=1&pid=ImgDetMain",
        "title": "Eduardo Cajeca",
        "description": "Desarrollador y Tester",
        "price": "\©",
        "url": "https://wa.me/+593 98 104 9052",
      },
      {
        "img":
            "https://i.pinimg.com/736x/ae/d6/42/aed642caf9da427f664c49ac5ebd00b8.jpg",
        "title": "Mauricio Parra",
        "description": "Ducumentacion",
        "price": "\©",
        "url": "https://wa.me/+593 99 904 0548",
      },
    ],
  }
};

class Developers extends StatelessWidget {
  const Developers({Key? key}) : super(key: key);

  void _launchURL(String link) async {
    final Uri url = Uri.parse(link);

    if (!await launchUrl(url)) {
      throw 'No se pudo lanzar $url';
    }
  }

  // Función para abrir WhatsApp
  void _openWhatsApp() async {
    String phoneNumber = "+1234567890"; // 🔹 Reemplaza con un número válido
    String message =
        Uri.encodeComponent("Hola, estoy interesado en su aplicación.");
    String whatsappUrl = "https://wa.me/$phoneNumber?text=$message";

    final Uri url = Uri.parse(whatsappUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir WhatsApp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Desarroladores",
        rightOptions: false,
        tags: [], // List<String>
        getCurrentPage: () => 1, // Una función que retorne int
        searchController: TextEditingController(),
        searchOnChanged: (text) {
          // Lógica al cambiar texto
        },
      ),
      /*appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Desarrolladores",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),*/
      backgroundColor: NowUIColors.bgColorScreen,
      drawer: NowDrawer(currentPage: "Developers"),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 176, 237, 255),
            ),
          ),
          SafeArea(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Desarrolladores",
                                style: TextStyle(
                                  color: NowUIColors.text,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Desarrolladores que contribuyeron con el desarrollo y creación de la aplicación.",
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 106, 106, 106),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          SizedBox(height: 36.0),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 24, left: 24, bottom: 36),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Carousel(
                                        imgArray: articlesCards["Developers"]![
                                            "participants"]),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // Botón de WhatsApp
      /*floatingActionButton: FloatingActionButton(
        onPressed: _openWhatsApp,
        backgroundColor: Colors.green, // Color de WhatsApp
        child: FaIcon(FontAwesomeIcons.whatsapp),
      ),*/
    );
  }
}
