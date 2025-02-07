import 'package:flutter/material.dart';

class DialogUtils {
  /// Muestra un diálogo de confirmación con [title], [message], y ejecuta [onConfirm] si el usuario confirma.
  static Future<void> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(), // Cierra sin confirmar
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop(); // Cierra el diálogo
                onConfirm(); // Ejecuta la acción confirmada
              },
              child: Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}
