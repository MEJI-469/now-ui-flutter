import 'package:flutter/material.dart';
import 'package:now_ui_flutter/constants/Theme.dart';

class CardCategory extends StatelessWidget {
  const CardCategory(
      {Key? key, this.title = "Placeholder Title",
      this.img = "https://via.placeholder.com/250",
      this.tap = defaultFunc}) : super(key: key);

  final String img;
  final VoidCallback tap;
  final String title;

  static void defaultFunc() {
    print("the function works!");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 252,
        width: null,
        child: GestureDetector(
          onTap: tap,
          child: Card(
              elevation: 0.4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))),
              child: Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        image: DecorationImage(
                          // Aquí chequeamos si es un asset local o una URL
                          image: img.startsWith('assets/')
                              ? AssetImage(img)
                              : NetworkImage(img) as ImageProvider<Object>,
                          fit: BoxFit.cover,
                        ))),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.black45,
                        borderRadius: BorderRadius.all(Radius.circular(6.0)))),
                Center(
                  child: Text(title,
                      style: TextStyle(
                          color: NowUIColors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0)),
                )
              ])),
        ));
  }
}
