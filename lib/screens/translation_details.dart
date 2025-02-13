import 'package:flutter/material.dart';
import 'package:now_ui_flutter/constants/Theme.dart';
import '../models/cargar_traduccion.dart';

class TranslationDetails extends StatelessWidget {
  final CargarTraduccion traduccion;

  const TranslationDetails({Key? key, required this.traduccion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar con un color vivo
      appBar: AppBar(
        backgroundColor: NowUIColors.primary,
        title: const Text(
          "Detalles de Traducción",
          style: TextStyle(
            fontSize: 24, // un poco más grande
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 4,
      ),

      // La magia: LayoutBuilder + SingleChildScrollView + ConstrainedBox
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              // minHeight = altura total disponible
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              // El contenedor con el gradiente
              child: Container(
                // Rellenará al menos toda la pantalla,
                // y si el contenido es mayor, crecerá y activará scroll
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      NowUIColors.bgColorScreen,
                      NowUIColors.bgColorScreen,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Emojis divertidos
                          const Text(
                            "🙌 🫶 👏 👋 👐 🤙",
                            style: TextStyle(fontSize: 35),
                          ),
                          const SizedBox(width: 10),
                          // Puedes poner un título si quieres
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Tarjeta colorida
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purpleAccent.withOpacity(0.3),
                              spreadRadius: 10,
                              blurRadius: 5,
                              offset: const Offset(2, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ID
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "ID de Traducción: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  TextSpan(
                                    text: "${traduccion.idCargarTraduccion}",
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Fecha
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Fecha: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  TextSpan(text: traduccion.fechaTraduccion),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Tipo
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Tipo de Traducción: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  TextSpan(text: traduccion.tipoTraduccion),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Texto
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black87,
                                ),
                                children: [
                                  const TextSpan(
                                    text: "Texto Traducido: ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  TextSpan(text: traduccion.texto),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
