import 'package:flutter/material.dart';
import 'package:now_ui_flutter/constants/Theme.dart';

class SingsScreen extends StatefulWidget {
  final String contentType;

  const SingsScreen({Key? key, required this.contentType}) : super(key: key);

  @override
  _SingsScreenState createState() => _SingsScreenState();
}

class _SingsScreenState extends State<SingsScreen> {
  List<Map<String, String>> currentContent = [];
  final List<String> alphabet = [
    'a',
    'b',
    'c',
    'ch',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'll',
    'm',
    'n',
    'ñ',
    'o',
    'p',
    'q',
    'r',
    'rr',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];
  final List<String> numbers = '0123456789'.split('');
  final List<String> months = [
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'septiembre',
    'octubre',
    'noviembre',
    'diciembre'
  ];
  final List<String> colors = [
    'amarillo',
    'anaranjado',
    'azul',
    'blanco',
    'brillante',
    'cafe',
    'claro',
    'color',
    'gris',
    'morado',
    'negro',
    'oro',
    'oscuro',
    'plata',
    'rojo_oscuro',
    'rojo',
    'rosa',
    'verde'
  ];

  @override
  void initState() {
    super.initState();
    switch (widget.contentType) {
      case 'alphabet':
        currentContent = alphabet
            .map((letter) => {
                  'image': 'assets/sign/$letter.png',
                  'text': letter.toUpperCase()
                })
            .toList();
        break;
      case 'numbers':
        currentContent = numbers
            .map((number) =>
                {'image': 'assets/sign/$number.png', 'text': number})
            .toList();
        break;
      case 'months':
        currentContent = months
            .map((month) => {
                  'image': 'assets/months/$month.png',
                  'text': month.capitalize()
                })
            .toList();
        break;
      case 'colors':
        currentContent = colors
            .map((color) => {
                  'image': 'assets/colors/$color.png',
                  'text': color.capitalize()
                })
            .toList();
        break;
      default:
        currentContent = [];
    }
  }

  void showImageDialog(String imagePath, String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: NowUIColors.bgColorScreen,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath,
                  errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 50, color: Colors.red);
              }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sings Screen'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: currentContent.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showImageDialog(
                      currentContent[index]['image']!,
                      currentContent[index]['text']!,
                    );
                  },
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(currentContent[index]['image']!,
                            errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.error, size: 50, color: Colors.red);
                        }),
                      ),
                      Text(currentContent[index]['text']!),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
