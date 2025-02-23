import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

// Widgets
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/input.dart';
import 'package:now_ui_flutter/widgets/drawer.dart';

// Servicios
import 'package:now_ui_flutter/services/usuario_service.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _checkboxValue = false; // Para aceptar términos
  bool _tieneDiscapacidad = false; // Para mostrar/ocultar campos
  final double height = window.physicalSize.height;

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

  // Expresiones Regulares para validación
  final RegExp _usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,}$');
  final RegExp _nameRegex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]{3,}$');
  final RegExp _phoneRegex = RegExp(r'^\d{8,15}$');
  final RegExp _emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');

  // --- NUEVO: método para registrar ---
  Future<void> _performRegister() async {
    // 1. Tomar valores de los controllers
    final nombre = _nombreCtrl.text.trim();
    final edad = int.tryParse(_edadCtrl.text.trim()) ?? 0;
    final telefono = _telCtrl.text.trim();
    final correo = _correoCtrl.text.trim();
    final usuario = _usuarioCtrl.text.trim();
    final password = _passCtrl.text.trim();
    final numeroCarnet = _carnetCtrl.text.trim();
    final porcentajeDiscapacidad =
        int.tryParse(_porcentajeCtrl.text.trim()) ?? 0;

    // 2. Verificar si tiene discapacidad (basado en bool)
    final carnetDiscapacidad = _tieneDiscapacidad;

    // 3. Validaciones (opcional)
    // Ejemplo similar a Proyecto2:
    if (!_usernameRegex.hasMatch(usuario)) {
      _showMessage(
          "El usuario debe tener al menos 3 caracteres (letras, números, '_')");
      return;
    }
    if (password.length < 6) {
      _showMessage("La contraseña debe tener al menos 6 caracteres");
      return;
    }
    if (!_nameRegex.hasMatch(nombre)) {
      _showMessage("El nombre solo puede contener letras y espacios (min 3)");
      return;
    }
    if (edad < 5) {
      _showMessage("La edad debe ser mayor o igual a 5 años");
      return;
    }
    if (!_phoneRegex.hasMatch(telefono)) {
      _showMessage(
          "El teléfono debe tener solo dígitos y estar entre 8 y 15 caracteres");
      return;
    }
    if (!_emailRegex.hasMatch(correo)) {
      _showMessage("Formato de correo inválido");
      return;
    }
    if (!carnetDiscapacidad && _tieneDiscapacidad) {
      // (No aplica, igual lo dejamos de ejemplo)
    }

    if (_tieneDiscapacidad) {
      if (numeroCarnet.isEmpty) {
        _showMessage("Debe ingresar un número de carnet si tiene discapacidad");
        return;
      }
      if (porcentajeDiscapacidad < 1 || porcentajeDiscapacidad > 100) {
        _showMessage("El porcentaje de discapacidad debe estar entre 1 y 100");
        return;
      }
    }

    if (!_checkboxValue) {
      _showMessage("Debes aceptar los términos y condiciones");
      return;
    }

    // 4. Llamar a la función de registro (Proyecto2)
    final success = await UsuarioService.registerUser(
      usuario: usuario,
      password: password,
      nombre: nombre,
      edad: edad,
      telefono: telefono,
      correo: correo,
      carnetDiscapacidad: carnetDiscapacidad,
      numeroCarnet: _tieneDiscapacidad ? numeroCarnet : null,
      porcentajeDiscapacidad:
          _tieneDiscapacidad ? porcentajeDiscapacidad : null,
    );

    // 5. Si se registra con éxito => volver al login
    if (success) {
      _showMessage("Usuario registrado con éxito");
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      _showMessage("Error al registrar usuario");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Colores de los iconos de validación (por defecto en gris)
  Color _nombreIconColor = Colors.grey;
  Color _usuarioIconColor = Colors.grey;
  Color _correoIconColor = Colors.grey;
  Color _telefonoIconColor = Colors.grey;
  Color _edadIconColor = Colors.grey;
  Color _passwordIconColor = Colors.grey;
  Color _discapacidadIconColor = Colors.grey;
  Color _carnetIconColor = Colors.grey;
  Color _porcentajeIconColor = Colors.grey;

  // Validación en tiempo real del nombre
  void _validateNombre() {
    setState(() {
      if (_nombreCtrl.text.isEmpty || !_nameRegex.hasMatch(_nombreCtrl.text)) {
        _nombreIconColor = Colors.red; // Rojo si es inválido
      } else {
        _nombreIconColor = Colors.green; // Verde si es válido
      }
    });
  }

  // Validación en tiempo real del usuario
  void _validateUsuario() {
    setState(() {
      if (!_usernameRegex.hasMatch(_usuarioCtrl.text)) {
        _usuarioIconColor = Colors.red;
      } else {
        _usuarioIconColor = Colors.green;
      }
    });
  }

  // Validación en tiempo real del correo
  void _validateCorreo() {
    setState(() {
      if (!_emailRegex.hasMatch(_correoCtrl.text)) {
        _correoIconColor = Colors.red;
      } else {
        _correoIconColor = Colors.green;
      }
    });
  }

  // Validación en tiempo real del teléfono
  void _validateTelefono() {
    setState(() {
      if (!_phoneRegex.hasMatch(_telCtrl.text)) {
        _telefonoIconColor = Colors.red;
      } else {
        _telefonoIconColor = Colors.green;
      }
    });
  }

  // Validación en tiempo real de la edad
  void _validateEdad() {
    setState(() {
      int? edad = int.tryParse(_edadCtrl.text);
      if (edad == null || edad < 5) {
        _edadIconColor = Colors.red;
      } else {
        _edadIconColor = Colors.green;
      }
    });
  }

  // Validación en tiempo real de la contraseña
  void _validatePassword() {
    setState(() {
      if (_passCtrl.text.length < 6) {
        _passwordIconColor = Colors.red;
      } else {
        _passwordIconColor = Colors.green;
      }
    });
  }

  // Validación de discapacidad
  void _validateDiscapacidad() {
    setState(() {
      final lower = _discapacidadCtrl.text.toLowerCase();
      if (lower == 'si' || lower == 'sí') {
        _discapacidadIconColor = Colors.green;
        _tieneDiscapacidad = true;
      } else if (lower == 'no') {
        _discapacidadIconColor = Colors.green;
        _tieneDiscapacidad = false;
      } else if (_discapacidadCtrl.text.isEmpty) {
        _discapacidadIconColor = Colors.grey;
        _tieneDiscapacidad = false;
      } else {
        _discapacidadIconColor = Colors.red;
        _tieneDiscapacidad = false;
      }
    });
  }

// Validación del número de carnet (solo si tiene discapacidad)
  void _validateCarnet() {
    setState(() {
      if (_tieneDiscapacidad && _carnetCtrl.text.isEmpty) {
        _carnetIconColor = Colors.red;
      } else if (_tieneDiscapacidad) {
        _carnetIconColor = Colors.green;
      } else {
        _carnetIconColor = Colors.grey;
      }
    });
  }

// Validación del porcentaje de discapacidad (solo si tiene discapacidad)
  void _validatePorcentaje() {
    setState(() {
      int? porcentaje = int.tryParse(_porcentajeCtrl.text);
      if (_tieneDiscapacidad) {
        if (porcentaje == null || porcentaje < 1 || porcentaje > 100) {
          _porcentajeIconColor = Colors.red;
        } else {
          _porcentajeIconColor = Colors.green;
        }
      } else {
        _porcentajeIconColor = Colors.grey;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    // Listeners para validar en tiempo real
    _nombreCtrl.addListener(_validateNombre);
    _usuarioCtrl.addListener(_validateUsuario);
    _correoCtrl.addListener(_validateCorreo);
    _telCtrl.addListener(_validateTelefono);
    _edadCtrl.addListener(_validateEdad);
    _passCtrl.addListener(_validatePassword);
    _discapacidadCtrl.addListener(_validateDiscapacidad);
    _carnetCtrl.addListener(_validateCarnet);
    _porcentajeCtrl.addListener(_validatePorcentaje);
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _usuarioCtrl.dispose();
    _correoCtrl.dispose();
    _telCtrl.dispose();
    _edadCtrl.dispose();
    _passCtrl.dispose();
    _discapacidadCtrl.dispose();
    _carnetCtrl.dispose();
    _porcentajeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Registrarse",
          style:
              TextStyle(color: NowUIColors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: NowUIColors.primary,
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: NowUIColors.white, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      drawer: NowDrawer(currentPage: "Account"),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
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
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 24.0, bottom: 8),
                              child: Center(
                                child: Text(
                                  "Registrar",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 24.0, bottom: 24.0),
                              child: Center(
                                child: Text(
                                  "Binevenido a nuestra App",
                                  style: TextStyle(
                                      color: NowUIColors.time,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Nombre
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Input(
                                    placeholder: "Nombre...",
                                    prefixIcon: Icon(Icons.school, size: 20),
                                    suffixIcon: Icon(Icons.check,
                                        color: _nombreIconColor),
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
                                    prefixIcon: Icon(Icons.school, size: 20),
                                    suffixIcon: Icon(Icons.check,
                                        color: _edadIconColor),
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
                                    prefixIcon: Icon(Icons.phone, size: 20),
                                    suffixIcon: Icon(Icons.check,
                                        color: _telefonoIconColor),
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
                                    prefixIcon: Icon(Icons.email, size: 20),
                                    suffixIcon: Icon(Icons.check,
                                        color: _correoIconColor),
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
                                    prefixIcon: Icon(Icons.person, size: 20),
                                    suffixIcon: Icon(Icons.check,
                                        color: _usuarioIconColor),
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
                                    prefixIcon: Icon(Icons.lock, size: 20),
                                    suffixIcon: Icon(Icons.check,
                                        color: _passwordIconColor),
                                    controller: _passCtrl,
                                    obscureText: true, // Si lo soporta tu Input
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
                                        Icon(Icons.accessible, size: 20),
                                    suffixIcon: Icon(Icons.check,
                                        color: _discapacidadIconColor),
                                    controller: _discapacidadCtrl,
                                    onChanged: (value) {
                                      // Si pone 'si' o 'sí', activamos
                                      setState(() {
                                        final lower = value.toLowerCase();
                                        _tieneDiscapacidad =
                                            (lower == 'si' || lower == 'sí');
                                      });
                                    },
                                    onTap: () {
                                      print("Input tapped!");
                                    },
                                  ),
                                ),

                                // Número de carnet (solo si tiene discapacidad)
                                if (_tieneDiscapacidad)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Input(
                                      placeholder: "Número de carnet",
                                      prefixIcon: Icon(Icons.badge, size: 20),
                                      suffixIcon: Icon(Icons.check,
                                          color: _carnetIconColor),
                                      controller: _carnetCtrl,
                                      onTap: () {
                                        print("Input tapped!");
                                      },
                                      onChanged: (value) {
                                        print("Nuevo valor: $value");
                                      },
                                    ),
                                  ),

                                // Porcentaje de discapacidad (solo si tiene discapacidad)
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
                                      prefixIcon: Icon(Icons.percent, size: 20),
                                      suffixIcon: Icon(Icons.check,
                                          color: _porcentajeIconColor),
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
                                // CheckBox de términos
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, top: 0, bottom: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Checkbox(
                                        activeColor: NowUIColors.primary,
                                        onChanged: (bool? newValue) =>
                                            setState(() {
                                          _checkboxValue = newValue!;
                                        }),
                                        value: _checkboxValue,
                                      ),
                                      Text(
                                        "Yo acepto los términos y condiciones.",
                                        style: TextStyle(
                                            color: NowUIColors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w200),
                                      ),
                                    ],
                                  ),
                                ),

                                // Botón de Registrarse
                                Center(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: NowUIColors.primary,
                                      foregroundColor: NowUIColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ),
                                    ),
                                    onPressed: _performRegister, // NUEVO
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 32.0,
                                          right: 32.0,
                                          top: 12,
                                          bottom: 12),
                                      child: Text(
                                        "Registrarse",
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
