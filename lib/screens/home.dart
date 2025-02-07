import 'package:flutter/material.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/card-horizontal.dart';
import 'package:now_ui_flutter/widgets/card-small.dart';
import 'package:now_ui_flutter/widgets/card-square.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';

// import 'package:now_ui_flutter/screens/product.dart';

final Map<String, Map<String, String>> homeCards = {
  "Ice Cream": {
    "title": "Traducir de señas a texto mediante la camara.",
    "image": "assets/imgs/singtotext.png"
  },
  "Makeup": {
    "title": "Traducir de texto a señas.",
    "image": "assets/imgs/texttosing.png"
  },
  "Coffee": {
    "title": "Historial de las traducciones.",
    "image":
        "https://raw.githubusercontent.com/creativetimofficial/public-assets/master/now-ui-pro-react-native/bg40.jpg"
  },
  "Fashion": {
    "title": "Why would anyone pick blue over?",
    "image":
        "https://images.unsplash.com/photo-1536686763189-829249e085ac?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=705&q=80"
  },
  "Argon": {
    "title": "Juegos diventidos para aprender.",
    "image": "assets/imgs/satoru-gojo.png"
  }
};

class Home extends StatelessWidget {
  // final GlobalKey _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Mano Amiga Tec",
          searchBar: false,
          tags: [], // List<String>
          getCurrentPage: () => 1, // Una función que retorne int
          searchController: TextEditingController(),
          searchOnChanged: (text) {
            // Lógica al cambiar texto
          },
        ),
        backgroundColor: NowUIColors.bgColorScreen,
        // key: _scaffoldKey,
        drawer: NowDrawer(currentPage: "Home"),
        body: Container(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CardHorizontal(
                      cta: "Ingresar",
                      title: homeCards["Ice Cream"]!['title']!,
                      img: homeCards["Ice Cream"]!['image']!,
                      tap: () {
                        Navigator.pushNamed(context, '/singtotext');
                      }),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardSmall(
                        cta: "Ingresar",
                        title: homeCards["Makeup"]!['title']!,
                        img: homeCards["Makeup"]!['image']!,
                        tap: () {
                          Navigator.pushNamed(context, '/texttosing');
                        }),
                    CardSmall(
                        cta: "Ingresar",
                        title: homeCards["Coffee"]!['title']!,
                        img: homeCards["Coffee"]!['image']!,
                        tap: () {
                          Navigator.pushNamed(context, '/history');
                        })
                  ],
                ),
                SizedBox(height: 8.0),
                /*CardHorizontal(
                    cta: "Ingresar",
                    title: homeCards["Fashion"]!['title']!,
                    img: homeCards["Fashion"]!['image']!,
                    tap: () {
                      Navigator.pushNamed(context, '/pro');
                    }),
                SizedBox(height: 8.0),*/
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: CardSquare(
                      cta: "Ingresar",
                      title: homeCards["Argon"]!['title']!,
                      img: homeCards["Argon"]!['image']!,
                      tap: () {
                        Navigator.pushNamed(context, '/games');
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
