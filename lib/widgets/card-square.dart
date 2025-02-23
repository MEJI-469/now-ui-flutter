import 'package:flutter/material.dart';
import 'package:now_ui_flutter/constants/Theme.dart';

class CardSquare extends StatelessWidget {
  const CardSquare({
    Key? key,
    this.title = "Placeholder Title",
    this.cta = "",
    this.img = "https://via.placeholder.com/200",
    required this.tap,
  }) : super(key: key);

  final String cta;
  final String img;
  final VoidCallback tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        width: null,
        child: GestureDetector(
          onTap: tap,
          child: Card(
              elevation: 3,
              shadowColor: NowUIColors.muted.withOpacity(0.22),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 3,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0)),
                              image: DecorationImage(
                                // Aquí chequeamos si es un asset local o una URL
                                image: img.startsWith('assets/')
                                    ? AssetImage(img)
                                    : NetworkImage(img)
                                        as ImageProvider<Object>,
                                fit: BoxFit.cover,
                              )))),
                  Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 9.0, bottom: 10.0, left: 16.0, right: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(title,
                                style: TextStyle(
                                    color: NowUIColors.text, fontSize: 15)),
                            Text(cta,
                                style: TextStyle(
                                    color: NowUIColors.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                      ))
                ],
              )),
        ));
  }
}
