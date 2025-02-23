import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

class Carousel extends StatefulWidget {
  final List<Map<String, String>> imgArray;

  const Carousel({
    Key? key,
    required this.imgArray,
  }) : super(key: key);

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: widget.imgArray
          .map((item) => Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.4),
                              blurRadius: 8,
                              spreadRadius: 0.3,
                              offset: Offset(0, 3))
                        ]),
                        child: AspectRatio(
                          aspectRatio: 2 / 2,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              item["img"]!,
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Column(
                        children: [
                          Text(item["price"]!,
                              style: TextStyle(
                                  fontSize: 16, color: NowUIColors.text)),
                          Text(
                            item["title"]!,
                            style: TextStyle(
                                fontSize: 32, color: NowUIColors.text),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 8),
                            child: Text(
                              item["description"]!,
                              style: TextStyle(
                                  fontSize: 16, color: NowUIColors.muted),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: 10), // Espaciado antes del icono
                          // 🔹 Icono como botón
                          IconButton(
                            icon: Icon(Icons.info_outline,
                                color: NowUIColors.primary, size: 30),
                            onPressed: () {
                              print("Botón de información presionado");
                              // Aquí puedes navegar a otra pantalla o ejecutar una acción
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ))
          .toList(),
      options: CarouselOptions(
          height: 530,
          autoPlay: false,
          enlargeCenterPage: false,
          aspectRatio: 4 / 4,
          enableInfiniteScroll: false,
          initialPage: 0,
          // viewportFraction: 1.0,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
    );
  }
}
