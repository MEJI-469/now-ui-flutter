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
  "CamSing": {
    "title": "Traducir de señas a texto.",
    "image": "assets/imgs/singtotext.png"
  },
  "TextSing": {
    "title": "Traducir de texto a señas.",
    "image": "assets/imgs/texttosing.png"
  },
  "History": {
    "title": "Historial de las traducciones.",
    "image": "assets/imgs/bg-history.jpg"
  },
  "Fashion": {
    "title": "Why would anyone pick blue over?",
    "image":
        "https://images.unsplash.com/photo-1536686763189-829249e085ac?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=705&q=80"
  },
  "Game": {
    "title": "Juegos divertidos para aprender.",
    "image": "assets/imgs/satoru-gojo.png"
  }
};

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardSmall(
                        cta: "Ingresar",
                        title: homeCards["CamSing"]!['title']!,
                        img: homeCards["CamSing"]!['image']!,
                        tap: () {
                          Navigator.pushNamed(context, '/singtotext');
                        }),
                    CardSmall(
                        cta: "Ingresar",
                        title: homeCards["TextSing"]!['title']!,
                        img: homeCards["TextSing"]!['image']!,
                        tap: () {
                          Navigator.pushNamed(context, '/texttosing');
                        })
                  ],
                ),
                SizedBox(height: 8.0),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: CardHorizontal(
                      cta: "Ingresar",
                      title: homeCards["History"]!['title']!,
                      img: homeCards["History"]!['image']!,
                      tap: () {
                        Navigator.pushNamed(context, '/history');
                      }),
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
                      title: homeCards["Game"]!['title']!,
                      img: homeCards["Game"]!['image']!,
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
