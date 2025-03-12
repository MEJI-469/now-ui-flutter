import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

import 'package:now_ui_flutter/widgets/drawer-tile.dart';

class NowDrawer extends StatelessWidget {
  final String currentPage;

  const NowDrawer({Key? key, required this.currentPage}) : super(key: key);

  _launchURL() async {
    final Uri url = Uri.parse('https://eduv.tecazuay.edu.ec/');

    if (!await launchUrl(url)) {
      throw 'No se pudo lanzar $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: NowUIColors.primary,
      child: Column(children: [
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.85,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Image.asset("assets/imgs/logo-of-bw.png"),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: IconButton(
                          icon: Icon(Icons.menu,
                              color: NowUIColors.white.withOpacity(0.82),
                              size: 24.0),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
          flex: 2,
          child: ListView(
            padding: EdgeInsets.only(top: 36, left: 8, right: 16),
            children: [
              DrawerTile(
                  icon: FontAwesomeIcons.home,
                  onTap: () {
                    if (currentPage != "Home") {
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                  },
                  iconColor: NowUIColors.primary,
                  title: "Home",
                  isSelected: currentPage == "Home" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.dharmachakra,
                  onTap: () {
                    if (currentPage != "Games") {
                      Navigator.pushReplacementNamed(context, '/games');
                    }
                  },
                  iconColor: NowUIColors.error,
                  title: "Juegos",
                  isSelected: currentPage == "Games" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.newspaper,
                  onTap: () {
                    if (currentPage != "Alphabet") {
                      Navigator.pushReplacementNamed(context, '/alphabet');
                    }
                  },
                  iconColor: NowUIColors.primary,
                  title: "Abecedario",
                  isSelected: currentPage == "Alphabet" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.user,
                  onTap: () {
                    if (currentPage != "Profile") {
                      Navigator.pushReplacementNamed(context, '/profile');
                    }
                  },
                  iconColor: NowUIColors.warning,
                  title: "Perfil",
                  isSelected: currentPage == "Profile" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.cog,
                  onTap: () {
                    if (currentPage != "Settings") {
                      Navigator.pushReplacementNamed(context, '/settings');
                    }
                  },
                  iconColor: NowUIColors.success,
                  title: "Ajustes",
                  isSelected: currentPage == "Settings" ? true : false),
              DrawerTile(
                  icon: FontAwesomeIcons.code,
                  onTap: () {
                    if (currentPage != "Developers")
                      Navigator.pushReplacementNamed(context, '/developers');
                  },
                  iconColor: NowUIColors.info,
                  title: "Desarrolladores",
                  isSelected: currentPage == "Developers" ? true : false),
              /*DrawerTile(
                  icon: FontAwesomeIcons.windows,
                  onTap: () {
                    if (currentPage != "Screens Templates") {
                      Navigator.pushReplacementNamed(context, '/screens');
                    }
                  },
                  iconColor: NowUIColors.success,
                  title: "Screen templates",
                  isSelected: currentPage == "Screens" ? true : false),*/
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
              padding: EdgeInsets.only(left: 8, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                      height: 4,
                      thickness: 0,
                      color: NowUIColors.white.withOpacity(0.8)),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, bottom: 8),
                    child: Text("INFORMACIÓN",
                        style: TextStyle(
                          color: NowUIColors.white.withOpacity(0.8),
                          fontSize: 13,
                        )),
                  ),
                  DrawerTile(
                      icon: FontAwesomeIcons.satellite,
                      onTap: _launchURL,
                      iconColor: NowUIColors.muted,
                      title: "Información Sobre nuestra Institución",
                      isSelected:
                          currentPage == "Getting started" ? true : false),
                ],
              )),
        ),
      ]),
    ));
  }
}
