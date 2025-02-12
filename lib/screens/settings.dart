import 'package:flutter/material.dart';
import 'package:now_ui_flutter/constants/Theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/table-cell.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';
import 'package:now_ui_flutter/widgets/privacy_policy_dialog.dart';

// NUEVO: Importar la clase utilitaria para los diálogos
import 'package:now_ui_flutter/widgets/dialog_utils.dart';
// Asegúrate de ajustarlo a la ruta real donde lo pusiste

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

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

  // NUEVO: método para cerrar sesión
  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    // Borra datos del usuario, etc.
    // Navegar a /login
    Navigator.pushReplacementNamed(context, '/onboarding');
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => PrivacyPolicyDialog(), // Invoca tu widget
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
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imgs/settings-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.8,
                  color: NowUIColors.bgColorScreen,
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
                        TableCellSettings(
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
                        ),
                        TableCellSettings(
                          title: "Exportar historial",
                          onTap: () {
                            // Lógica para exportar
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Historial exportado"),
                              ),
                            );
                          },
                        ),
                        TableCellSettings(
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
                        ),
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
                            Navigator.pushNamed(context, '/soporte');
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
        ],
      ),
    );
  }
}
