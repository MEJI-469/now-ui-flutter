import 'package:flutter/material.dart';
import 'package:now_ui_flutter/constants/Theme.dart';

class PrivacyPolicyDialog extends StatelessWidget {
  const PrivacyPolicyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      backgroundColor: NowUIColors.bgColorScreen,
      child: Stack(
        children: [
          // Contenido principal
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Políticas de Privacidad",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "¡Hola!\n\n"
                    "Gracias por usar nuestra aplicación. Queremos asegurarnos de que tus datos estén protegidos. "
                    "Aquí te explicamos cómo recopilamos y usamos tu información.\n\n"
                    "📡 ¿Qué recopilamos?\n"
                    "Recopilamos datos como tu nombre, edad y preferencias para ofrecerte la mejor experiencia posible.\n\n"
                    "🔐 ¿Cómo protegemos tus datos?\n"
                    "Utilizamos tecnología avanzada para asegurar que tus datos siempre estén seguros.\n\n"
                    "🛠️ ¿Cómo puedes gestionar tus datos?\n"
                    "Puedes actualizar o eliminar tu información en cualquier momento desde la sección de configuración.",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // Botón de cierre (X) en la esquina superior derecha
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
