import 'package:flutter/material.dart';
import 'package:now_ui_flutter/constants/Theme.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final Color borderColor;

  // NUEVO: agregamos estas propiedades
  final bool obscureText;
  final TextInputType keyboardType;

  const Input({Key? key, 
    required this.placeholder,
    required this.suffixIcon,
    required this.prefixIcon,
    required this.onTap,
    required this.onChanged,
    this.autofocus = false,
    this.borderColor = NowUIColors.border,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        cursorColor: NowUIColors.muted,
        onTap: onTap,
        onChanged: onChanged,
        controller: controller,
        autofocus: autofocus,
        // NUEVO: aquí usas los nuevos parámetros
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(height: 0.55, fontSize: 13.0, color: NowUIColors.time),
        textAlignVertical: TextAlignVertical(y: 0.6),
        decoration: InputDecoration(
            filled: true,
            fillColor: NowUIColors.white,
            hintStyle: TextStyle(
              color: NowUIColors.time,
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide(
                    color: borderColor, width: 1.0, style: BorderStyle.solid)),
            hintText: placeholder));
  }
}
