import 'package:flutter/material.dart';

import 'package:now_ui_flutter/constants/Theme.dart';
import 'package:url_launcher/url_launcher.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/card-horizontal.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';

// import 'package:now_ui_flutter/screens/product.dart';

final Map<String, Map<String, String>> homeCards = {
  "Facebook": {
    "title": "Contactenos por Facebook",
    "image":
        "https://th.bing.com/th/id/OIP.MHNWAEjX95uG3maQoGtZzAHaHa?rs=1&pid=ImgDetMain",
    "url": "https://facebook.com",
  },
  "Instagram": {
    "title": "Contactenos por Instagram",
    "image":
        "https://static.vecteezy.com/system/resources/previews/017/743/718/original/instagram-icon-logo-free-png.png",
    "url": "https://instagram.com", // EJEMPLO
  },
  "WhatsApp": {
    "title": "Contactenos por WhatsApp",
    "image":
        "https://th.bing.com/th/id/OIP.XLR5b123Km1O24np1HU7_gHaHa?rs=1&pid=ImgDetMain",
    "url": "https://wa.me/0984037422", // EJEMPLO WhatsApp con un número
  },
};

class Soporte extends StatelessWidget {
  void _launchURL(String link) async {
    final Uri _url = Uri.parse(link);

    if (!await launchUrl(_url)) {
      throw 'No se pudo lanzar $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: Navbar(
        title: "Soporte",
        reverseTextcolor: true,
        tags: [], // List<String> obligatorio
        getCurrentPage: () => 0, // o alguna lógica que retorne un int
        searchController: TextEditingController(),
        searchOnChanged: (text) {
          // tu lógica
        },
      ),*/
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Soporte",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: NowUIColors.bgColorScreen,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    "Soporte y Ayuda",
                    style: TextStyle(
                      color: NowUIColors.text,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CardHorizontal(
                  cta: "Contactar",
                  title: homeCards["Facebook"]!['title']!,
                  img: homeCards["Facebook"]!['image']!,
                  tap: () {
                    final link = homeCards["Facebook"]?['url'];
                    if (link != null) {
                      _launchURL(link);
                    } else {
                      print("URL de Facebook es null");
                    }
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CardHorizontal(
                  cta: "Contactar",
                  title: homeCards["Instagram"]!['title']!,
                  img: homeCards["Instagram"]!['image']!,
                  tap: () {
                    final link = homeCards["Instagram"]?['url'];
                    if (link != null) {
                      _launchURL(link);
                    } else {
                      print("URL de Instagram es null");
                    }
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: CardHorizontal(
                  cta: "Contactar",
                  title: homeCards["WhatsApp"]!['title']!,
                  img: homeCards["WhatsApp"]!['image']!,
                  tap: () {
                    final link = homeCards["WhatsApp"]?['url'];
                    if (link != null) {
                      _launchURL(link);
                    } else {
                      print("URL de WhatsApp es null");
                    }
                  },
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        )),
      ),
    );
  }
}
