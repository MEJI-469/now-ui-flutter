import 'dart:ui'; // Para ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:now_ui_flutter/constants/Theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/table-cell.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';
import 'package:now_ui_flutter/widgets/privacy_policy_dialog.dart';
import 'package:now_ui_flutter/widgets/dialog_utils.dart';
import 'package:now_ui_flutter/widgets/export-dialog.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool switchValueOne;
  late bool switchValueTwo;

  @override
  void initState() {
    super.initState();
    switchValueOne = true;
    switchValueTwo = false;
  }

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.clear(); // elimina TODOS los datos
    Navigator.pushReplacementNamed(context, '/onboarding');
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => PrivacyPolicyDialog(),
    );
  }

  void _showExportDialog() {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return ExportDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Ajustes",
        tags: [],
        getCurrentPage: () => 1,
        searchController: TextEditingController(),
        searchOnChanged: (value) {},
        transparent: false,
      ),
      backgroundColor: NowUIColors.muted,
      drawer: NowDrawer(currentPage: "Settings"),
      body: Stack(
        children: [
          // Fondo con imagen
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imgs/bg-ssetings.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Área segura + Centro
          SafeArea(
            child: Center(
              // Widget con efecto de "tarjeta difuminada"
              child: ClipRRect(
                // Recorte con esquinas redondeadas
                borderRadius: BorderRadius.circular(12),
                child: BackdropFilter(
                  // Aplica el desenfoque
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  // El contenedor semitransparente
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      // Color semitransparente para el efecto
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    // Contenido con scroll
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          // ------------------------------------------------------
                          // Sección: Historial y Juegos
                          // ------------------------------------------------------
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Historial y Juegos",
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
                                "Gestiona tu historial y progreso en juegos",
                                style: TextStyle(
                                  color: NowUIColors.time,
                                ),
                              ),
                            ),
                          ),
                          /*TableCellSettings(
                            title: "Borrar historial",
                            onTap: () {
                              DialogUtils.showConfirmationDialog(
                                context,
                                title: "Confirmar",
                                message:
                                    "¿Estás seguro de que deseas borrar el historial?",
                                onConfirm: () {
                                  // Aquí iría la lógica para borrar el historial
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Historial borrado"),
                                    ),
                                  );
                                },
                              );
                            },
                          ),*/
                          TableCellSettings(
                            title: "Exportar historial",
                            onTap: () {
                              _showExportDialog();
                            },
                          ),
                          /*TableCellSettings(
                            title: "Reiniciar progreso de juegos",
                            onTap: () {
                              DialogUtils.showConfirmationDialog(
                                context,
                                title: "Confirmar",
                                message:
                                    "¿Estás seguro de que deseas reiniciar el progreso de los juegos?",
                                onConfirm: () {
                                  // Lógica para reiniciar
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Progreso reiniciado"),
                                    ),
                                  );
                                },
                              );
                            },
                          ),*/
                          SizedBox(height: 36.0),
                          // ------------------------------------------------------
                          // Sección: Soporte y Ayuda
                          // ------------------------------------------------------
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
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Obtén ayuda y soporte técnico",
                                style: TextStyle(
                                  color: NowUIColors.time,
                                ),
                              ),
                            ),
                          ),
                          TableCellSettings(
                            title: "Política de privacidad",
                            onTap: () {
                              // Navigator.pushNamed(context, '/privacy-policy');
                              _showPrivacyPolicyDialog(context);
                            },
                          ),
                          TableCellSettings(
                            title: "Contactar con soporte",
                            onTap: () {
                              Navigator.pushNamed(context, '/developers');
                            },
                          ),
                          TableCellSettings(
                            title: "Redes Sociales",
                            onTap: () {
                              Navigator.pushNamed(context, '/networks');
                            },
                          ),
                          // ------------------------------------------------------
                          // NUEVA Sección: Cerrar sesión
                          // ------------------------------------------------------
                          SizedBox(height: 36.0),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Cuenta",
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
                                "Opciones de tu cuenta",
                                style: TextStyle(
                                  color: NowUIColors.time,
                                ),
                              ),
                            ),
                          ),
                          TableCellSettings(
                            title: "Cerrar sesión",
                            onTap: () {
                              DialogUtils.showConfirmationDialog(
                                context,
                                title: "Cerrar sesión",
                                message:
                                    "¿Estás seguro de que deseas cerrar tu sesión?",
                                onConfirm: _logout,
                              );
                            },
                          ),
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
    );
  }
}
