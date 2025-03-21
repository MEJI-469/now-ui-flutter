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
                      image: AssetImage("assets/anime/per-anime.png"),
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
                                backgroundImage: AssetImage(
                                  "assets/imgs/logo-of-cd.png",
                                ),
                                radius: 65.0,
                              ),
                              // Nombre
                              Padding(
                                padding: const EdgeInsets.only(top: 24.0),
                                child: Text(
                                  _userName,
                                  style: TextStyle(
                                    color: NowUIColors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 28, // un poco más grande
                                    // fontFamily: 'KidFont', // Si agregas una fuente para niños
                                    shadows: [
                                      Shadow(
                                        blurRadius: 3.0,
                                        color: const Color.fromARGB(
                                            255, 109, 109, 109),
                                        offset: Offset(1.5,
                                            1.5), // Sombra para mejorar la visibilidad
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Correo
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _userEmail,
                                  style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 255, 255, 255)
                                            .withOpacity(0.85),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 3.0,
                                        color: const Color.fromARGB(
                                            255, 109, 109, 109),
                                        offset: Offset(1.5,
                                            1.5), // Sombra para mejorar la visibilidad
                                      ),
                                    ],
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 20.0),
                      child: _buildColorfulUserInfo(context),
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
                      onPressed: () async {
                        // Navegamos a la pantalla de edición, esperando resultado
                        final result =
                            await Navigator.pushNamed(context, '/edit-profile');

                        // Si result == "updated", recargamos SharedPreferences
                        if (result == "updated") {
                          setState(() {
                            _loadUserData();
                            // Esto vuelve a leer de SharedPreferences y actualiza la UI
                          });
                        }
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

  /// Construye un widget colorido e infantil para mostrar los datos irrelevantes
  Widget _buildColorfulUserInfo(BuildContext context) {
    return Column(
      children: [
        // Título
        const SizedBox(height: 20),
        Text(
          "¡Conoce tus datos!",
          style: TextStyle(
            color: Colors.purple, // un color vibrante
            fontSize: 22,
            fontWeight: FontWeight.bold,
            // fontFamily: 'KidFont', // Si agregas fuente infantil
          ),
        ),
        SizedBox(height: 20),

        // Tarjeta con diseño infantil
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 158, 236, 255), // color de fondo alegre
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.pink.shade200.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Edad
              if (_userEdad > 0)
                _buildInfoRow(
                  icon: Icons.cake,
                  label: "Edad",
                  value: "$_userEdad añitos 🎉",
                  color: Colors.deepOrange,
                ),
              // Teléfono
              if (_userTelefono.isNotEmpty)
                _buildInfoRow(
                  icon: Icons.phone,
                  label: "Teléfono",
                  value: _userTelefono,
                  color: Colors.green,
                ),
              // Carnet de Discapacidad
              _buildInfoRow(
                icon: Icons.badge,
                label: "Carnet Discapacidad",
                value: _userCarnet ? "¡Sí, lo tengo!" : "No 😔",
                color: Colors.blue,
              ),
              // Número de Carnet
              if (_userCarnet && _userNumeroCarnet.isNotEmpty)
                _buildInfoRow(
                  icon: Icons.confirmation_num,
                  label: "Número de Carnet",
                  value: _userNumeroCarnet,
                  color: Colors.teal,
                ),
              // Porcentaje
              if (_userCarnet && _userPorcentaje > 0)
                _buildInfoRow(
                  icon: Icons.percent,
                  label: "Porcentaje",
                  value: "$_userPorcentaje%",
                  color: Colors.amber,
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Construye cada fila de info con un ícono y colores.
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          // Ícono con color
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8),
            child: Icon(icon, color: color),
          ),
          SizedBox(width: 10),
          // Texto label
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  // fontFamily: 'KidFont', // si la agregas
                ),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: TextStyle(color: Colors.purple.shade900),
                  ),
                  TextSpan(
                    text: value,
                    style: TextStyle(
                      color: Colors.purple.shade900,
                      fontWeight: FontWeight.bold,
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
