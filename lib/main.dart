import 'dart:ffi';

import 'package:flutter/material.dart';

//screens
import 'package:now_ui_flutter/screens/onboarding.dart';
import 'package:now_ui_flutter/screens/pro.dart';
import 'package:now_ui_flutter/screens/home.dart';
import 'package:now_ui_flutter/screens/profile.dart';
import 'package:now_ui_flutter/screens/settings.dart';  
import 'package:now_ui_flutter/screens/register.dart';
import 'package:now_ui_flutter/screens/articles.dart';
import 'package:now_ui_flutter/screens/components.dart';
import 'package:now_ui_flutter/screens/login.dart';
import 'package:now_ui_flutter/screens/history.dart';
import 'package:now_ui_flutter/screens/juegos/games_screen.dart';
import 'package:now_ui_flutter/screens/alphabet_screen.dart';
import 'package:now_ui_flutter/screens/signstotext_screen.dart';
import 'package:now_ui_flutter/screens/texttosigns_screen.dart';
import 'package:now_ui_flutter/screens/screen-templates.dart';
import 'package:now_ui_flutter/screens/developers.dart';
import 'package:now_ui_flutter/screens/networks.dart';
import 'package:now_ui_flutter/screens/edit_profile.dart';

// <-- Asegúrate de importar tu nuevo CheckSession
import 'package:now_ui_flutter/widgets/check_session.dart'; // donde definiste la clase

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Now UI PRO Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Montserrat'),
      // El "home" será la lógica que chequea sesión (tomada de Proyecto2)
      home: CheckSession(),
      // Mantenemos las rutas de Proyecto1
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Home(),
        '/settings': (BuildContext context) => Settings(),
        "/onboarding": (BuildContext context) => Onboarding(),
        "/pro": (BuildContext context) => Pro(),
        "/profile": (BuildContext context) => Profile(),
        "/articles": (BuildContext context) => Articles(),
        "/components": (BuildContext context) => Components(),
        "/account": (BuildContext context) => Register(),
        "/login": (BuildContext context) => Login(),
        "/history": (BuildContext context) => History(),
        "/games": (BuildContext context) => GamesScreen(),
        "/alphabet": (BuildContext context) => AlphabetScreen(),
        "/singtotext": (BuildContext context) => SignToTextScreen(),
        "/texttosing": (BuildContext context) => TextToSignScreen(),
        "/screens": (BuildContext context) => ScreenTemplates(),
        "/developers": (BuildContext context) => Developers(),
        "/networks": (BuildContext context) => Networks(),
        "/edit-profile": (BuildContext context) => EditProfile(),
      },
    );
  }
}
