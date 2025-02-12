import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:now_ui_flutter/constants/Theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';
import 'package:now_ui_flutter/widgets/photo-album.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Variables base: nombre y email
  String _userName = "Invitado";
  String _userEmail = "invitado@ejemplo.com";

  // Otras variables irrelevantes
  int _userEdad = 0;
  String _userTelefono = "";
  bool _userCarnet = false;
  String _userNumeroCarnet = "";
  int _userPorcentaje = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  /// Carga todos los datos “irrelevantes” del usuario desde SharedPreferences.
  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Datos principales
      _userName = prefs.getString('userNombre') ?? "Invitado";
      _userEmail = prefs.getString('userEmail') ?? "invitado@ejemplo.com";

      // Datos “irrelevantes”
      _userEdad = prefs.getInt('userEdad') ?? 0;
      _userTelefono = prefs.getString('userTelefono') ?? "";
      _userCarnet = prefs.getBool('userCarnet') ?? false;
      _userNumeroCarnet = prefs.getString('userNumeroCarnet') ?? "";
      _userPorcentaje = prefs.getInt('userPorcentaje') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: Navbar(
        title: "Perfil",
        transparent: true,
        tags: [],
        getCurrentPage: () => 1,
        searchController: TextEditingController(),
        searchOnChanged: (value) {},
      ),
      backgroundColor: NowUIColors.bgColorScreen,
      drawer: NowDrawer(currentPage: "Profile"),
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              // Parte superior con fondo y avatar
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/imgs/bg-profile.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      SafeArea(
                        bottom: false,
                        right: false,
                        left: false,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            children: [
                              // Avatar del usuario
                              CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/imgs/logo-perfil.png"),
                                radius: 65.0,
                              ),
                              // Nombre
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Text(
                                  _userName,
                                  style: TextStyle(
                                    color: NowUIColors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                              // Correo
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _userEmail,
                                  style: TextStyle(
                                    color: NowUIColors.white.withOpacity(0.85),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              // Aquí podrías agregar estadísticas, etc.
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 24.0, left: 42, right: 32),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Parte inferior con la info
              Flexible(
                flex: 1,
                child: Container(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 32.0, right: 32.0, top: 42.0),
                      child: Column(
                        children: [
                          // Sección "About me"
                          Text(
                            "Informacion del usuario",
                            style: TextStyle(
                              color: NowUIColors.text,
                              fontWeight: FontWeight.w600,
                              fontSize: 17.0,
                            ),
                          ),
                          // Aquí mostramos los datos irrelevantes:
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 24.0, right: 24, top: 30, bottom: 24),
                            child: Column(
                              children: [
                                // Edad
                                if (_userEdad > 0)
                                  Text("Edad: $_userEdad",
                                      style:
                                          TextStyle(color: NowUIColors.time)),
                                const SizedBox(height: 5),
                                // Teléfono
                                if (_userTelefono.isNotEmpty)
                                  Text("Teléfono: $_userTelefono",
                                      style:
                                          TextStyle(color: NowUIColors.time)),
                                const SizedBox(height: 5),
                                // ¿Carnet de Discapacidad?
                                Text(
                                  "¿Tiene carnet de discapacidad?: ${_userCarnet ? 'Sí' : 'No'}",
                                  style: TextStyle(color: NowUIColors.time),
                                ),
                                const SizedBox(height: 5),
                                // Número de Carnet
                                if (_userCarnet && _userNumeroCarnet.isNotEmpty)
                                  Text("Número de Carnet: $_userNumeroCarnet",
                                      style:
                                          TextStyle(color: NowUIColors.time)),
                                const SizedBox(height: 5),
                                // Porcentaje
                                if (_userCarnet && _userPorcentaje > 0)
                                  Text(
                                      "Porcentaje de Discapacidad: $_userPorcentaje%",
                                      style:
                                          TextStyle(color: NowUIColors.time)),
                              ],
                            ),
                          ),
                          // Si quieres poner un álbum de fotos:
                          // PhotoAlbum(imgArray: imgArray)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Botón para “Editar”
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: NowUIColors.white,
                        backgroundColor: NowUIColors.info,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        padding: const EdgeInsets.only(
                            left: 12.0, right: 12.0, top: 10, bottom: 10),
                      ),
                      onPressed: () {
                        // Lógica de edición de perfil
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 12.0, right: 12.0, top: 10, bottom: 10),
                        child: Text(
                          "...Editar...",
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ),
                    ),
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
