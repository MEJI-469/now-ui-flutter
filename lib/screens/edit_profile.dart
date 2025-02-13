import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:now_ui_flutter/constants/Theme.dart';
//widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/input.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';

// Importa tu servicio de usuario
import 'package:now_ui_flutter/services/usuario_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  //const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  // Para mostrar/ocultar campos de discapacidad
  bool _tieneDiscapacidad = false;

  // Controladores
  final TextEditingController _nombreCtrl = TextEditingController();
  final TextEditingController _edadCtrl = TextEditingController();
  final TextEditingController _telCtrl = TextEditingController();
  final TextEditingController _correoCtrl = TextEditingController();
  final TextEditingController _usuarioCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final TextEditingController _carnetCtrl = TextEditingController();
  final TextEditingController _porcentajeCtrl = TextEditingController();
  final TextEditingController _discapacidadCtrl = TextEditingController();

  // Si quieres validaciones
  final RegExp _nameRegex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]{3,}$');
  final RegExp _phoneRegex = RegExp(r'^\d{8,15}$');
  final RegExp _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  Future<void> _cargarDatosUsuario() async {
    try {
      // 1. Lee userId de SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getInt('userId');
      if (userId == null) {
        _showMessage("No se encontró la sesión del usuario");
        Navigator.pop(context);
        return;
      }

      // 2. Toma todos los datos que guardaste en SharedPreferences al iniciar sesión
      final nombre = prefs.getString('userNombre') ?? '';
      final edad = prefs.getInt('userEdad') ?? 0;
      final telefono = prefs.getString('userTelefono') ?? '';
      final correo = prefs.getString('userEmail') ?? '';
      final usuario = prefs.getString('userName') ?? '';
      final password = prefs.getString('userPassword') ?? '';
      final carnet = prefs.getBool('userCarnet') ?? false;
      final numeroCarnet = prefs.getString('userNumeroCarnet') ?? '';
      final porcentaje = prefs.getInt('userPorcentaje') ?? 0;

      // 3. Refleja estos valores en los controladores y variables
      setState(() {
        _nombreCtrl.text = nombre;
        _edadCtrl.text = edad.toString();
        _telCtrl.text = telefono;
        _correoCtrl.text = correo;
        _usuarioCtrl.text = usuario;
        _passCtrl.text =
            password; // Muestra la pass en claro, ojo a la seguridad

        // Discapacidad
        _tieneDiscapacidad = carnet;
        _discapacidadCtrl.text = _tieneDiscapacidad ? "Si" : "No";
        if (_tieneDiscapacidad) {
          _carnetCtrl.text = numeroCarnet;
          _porcentajeCtrl.text = porcentaje.toString();
        }
      });
    } catch (e) {
      _showMessage("Error cargando datos: $e");
    }
  }

  Future<void> _performUpdate() async {
    // 1. Recoge datos de controladores

    final nombre = _nombreCtrl.text.trim();
    final edad = int.tryParse(_edadCtrl.text.trim()) ?? 0;
    final telefono = _telCtrl.text.trim();
    final correo = _correoCtrl.text.trim();
    final usuario = _usuarioCtrl.text.trim();
    final password = _passCtrl.text.trim();
    final numeroCarnet = _carnetCtrl.text.trim();
    final porcDisc = int.tryParse(_porcentajeCtrl.text.trim()) ?? 0;

    // 2. Validaciones mínimas
    if (!_nameRegex.hasMatch(nombre)) {
      _showMessage("El nombre es inválido (min 3 letras)");
      return;
    }
    if (edad < 5) {
      _showMessage("La edad debe ser mayor o igual a 5");
      return;
    }
    if (!_phoneRegex.hasMatch(telefono)) {
      _showMessage("El telefono debe tener 8-15 dígitos");
      return;
    }
    if (!_emailRegex.hasMatch(correo)) {
      _showMessage("Correo inválido");
      return;
    }

    // 3. Obtener userId de SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    if (userId == null) {
      _showMessage("No se encontró ID de usuario en sesión");
      return;
    }

    final success = await UsuarioService.updateUser(
      id: userId, // <-- que le pongo aqui si me sale error
      nombre: nombre,
      edad: edad,
      telefono: telefono,
      correo: correo,
      usuario: usuario,
      password: password,
      carnetDiscapacidad: _tieneDiscapacidad,
      numeroCarnet: _tieneDiscapacidad ? numeroCarnet : null,
      porcentajeDiscapacidad: _tieneDiscapacidad ? porcDisc : null,
    );

    if (success) {
      // 5. Actualizar SharedPreferences local con los nuevos datos
      await prefs.setString('userNombre', nombre);
      await prefs.setInt('userEdad', edad);
      await prefs.setString('userTelefono', telefono);
      await prefs.setString('userEmail', correo);
      await prefs.setString('userName', usuario);
      await prefs.setString('userPassword', password);
      await prefs.setBool('userCarnet', _tieneDiscapacidad);
      await prefs.setString('userNumeroCarnet', numeroCarnet);
      await prefs.setInt('userPorcentaje', porcDisc);

      _showMessage("Perfil actualizado correctamente");

      // 6. Cierra la pantalla y devuelve "updated"
      Navigator.pop(context, "updated");
    } else {
      _showMessage("Error actualizando perfil");
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Perfil",
            style: TextStyle(
                color: NowUIColors.white, fontWeight: FontWeight.w500)),
        backgroundColor: NowUIColors.primary,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: NowUIColors.white, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/imgs/register-bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 16, left: 16.0, right: 16.0, bottom: 32),
              child: Card(
                elevation: 5,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.78,
                  color: NowUIColors.bgColorScreen,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Título
                            const Padding(
                              padding: EdgeInsets.only(top: 24.0, bottom: 8),
                              child: Center(
                                child: Text(
                                  "Editar Perfil",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 24.0, bottom: 24.0),
                              child: Center(
                                child: Text(
                                  "Modifica tus datos",
                                  style: TextStyle(
                                    color: NowUIColors.time,
                                    fontWeight: FontWeight.w200,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            // Campos
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Nombre
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Input(
                                    placeholder: "Nombre...",
                                    prefixIcon:
                                        const Icon(Icons.school, size: 20),
                                    suffixIcon: const Icon(Icons.check),
                                    controller: _nombreCtrl,
                                    onTap: () {
                                      print("Input tapped!");
                                    },
                                    onChanged: (value) {
                                      print("Nuevo valor: $value");
                                    },
                                  ),
                                ),
                                // Edad
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Input(
                                    placeholder: "Edad...",
                                    prefixIcon:
                                        const Icon(Icons.school, size: 20),
                                    suffixIcon: const Icon(Icons.check),
                                    controller: _edadCtrl,
                                    keyboardType: TextInputType.number,
                                    onTap: () {
                                      print("Input tapped!");
                                    },
                                    onChanged: (value) {
                                      print("Nuevo valor: $value");
                                    },
                                  ),
                                ),
                                // Telefono
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Input(
                                    placeholder: "Telefono...",
                                    prefixIcon:
                                        const Icon(Icons.phone, size: 20),
                                    suffixIcon: const Icon(Icons.check),
                                    controller: _telCtrl,
                                    keyboardType: TextInputType.phone,
                                    onTap: () {
                                      print("Input tapped!");
                                    },
                                    onChanged: (value) {
                                      print("Nuevo valor: $value");
                                    },
                                  ),
                                ),
                                // Correo
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Input(
                                    placeholder: "Correo...",
                                    prefixIcon:
                                        const Icon(Icons.email, size: 20),
                                    suffixIcon: const Icon(Icons.check),
                                    controller: _correoCtrl,
                                    keyboardType: TextInputType.emailAddress,
                                    onTap: () {
                                      print("Input tapped!");
                                    },
                                    onChanged: (value) {
                                      print("Nuevo valor: $value");
                                    },
                                  ),
                                ),
                                // Usuario
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Input(
                                    placeholder: "Usuario...",
                                    prefixIcon:
                                        const Icon(Icons.person, size: 20),
                                    suffixIcon: const Icon(Icons.check),
                                    controller: _usuarioCtrl,
                                    onTap: () {
                                      print("Input tapped!");
                                    },
                                    onChanged: (value) {
                                      print("Nuevo valor: $value");
                                    },
                                  ),
                                ),
                                // Contraseña
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Input(
                                    placeholder: "Contraseña...",
                                    prefixIcon:
                                        const Icon(Icons.lock, size: 20),
                                    suffixIcon: const Icon(Icons.check),
                                    controller: _passCtrl,
                                    obscureText: true,
                                    onTap: () {
                                      print("Input tapped!");
                                    },
                                    onChanged: (value) {
                                      print("Nuevo valor: $value");
                                    },
                                  ),
                                ),
                                // ¿Tiene discapacidad?
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Input(
                                    placeholder: "¿Tiene discapacidad?",
                                    prefixIcon:
                                        const Icon(Icons.accessible, size: 20),
                                    suffixIcon: const Icon(Icons.check),
                                    controller: _discapacidadCtrl,
                                    onChanged: (value) {
                                      final lower = value.toLowerCase();
                                      setState(() {
                                        _tieneDiscapacidad =
                                            (lower == 'si' || lower == 'sí');
                                      });
                                    },
                                    onTap: () {
                                      print("Input tapped!");
                                    },
                                  ),
                                ),
                                // Número de carnet
                                if (_tieneDiscapacidad)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Input(
                                      placeholder: "Número de carnet",
                                      prefixIcon:
                                          const Icon(Icons.badge, size: 20),
                                      suffixIcon: const Icon(Icons.check),
                                      controller: _carnetCtrl,
                                      onTap: () {
                                        print("Input tapped!");
                                      },
                                      onChanged: (value) {
                                        print("Nuevo valor: $value");
                                      },
                                    ),
                                  ),
                                // Porcentaje
                                if (_tieneDiscapacidad)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 8.0,
                                        right: 8.0,
                                        bottom: 0),
                                    child: Input(
                                      placeholder:
                                          "Porcentaje de discapacidad...",
                                      prefixIcon:
                                          const Icon(Icons.percent, size: 20),
                                      suffixIcon: const Icon(Icons.check),
                                      controller: _porcentajeCtrl,
                                      keyboardType: TextInputType.number,
                                      onTap: () {
                                        print("Input tapped!");
                                      },
                                      onChanged: (value) {
                                        print("Nuevo valor: $value");
                                      },
                                    ),
                                  ),
                              ],
                            ),

                            // Botón de Actualizar
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: NowUIColors.primary,
                                  foregroundColor: NowUIColors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32.0),
                                  ),
                                ),
                                onPressed: _performUpdate,
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                    left: 32.0,
                                    right: 32.0,
                                    top: 12,
                                    bottom: 12,
                                  ),
                                  child: Text(
                                    "Actualizar",
                                    style: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
