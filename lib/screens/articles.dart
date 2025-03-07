import 'package:flutter/material.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

//screens
// import 'package:now_ui_flutter/screens/product.dart';
// import 'package:now_ui_flutter/screens/category.dart';

//widgets
import 'package:now_ui_flutter/widgets/drawer.dart';
import 'package:now_ui_flutter/widgets/navbar.dart';
import 'package:now_ui_flutter/widgets/card-horizontal.dart';
import 'package:now_ui_flutter/widgets/card-small.dart';
import 'package:now_ui_flutter/widgets/card-square.dart';
import 'package:now_ui_flutter/widgets/card-category.dart';
import 'package:now_ui_flutter/widgets/slider-product.dart';

final Map<String, Map<String, dynamic>> articlesCards = {
  "Ice Cream": {
    "title": "Ice cream is made with carrageenan …",
    "image":
        "https://images.unsplash.com/photo-1516559828984-fb3b99548b21?ixlib=rb-1.2.1&auto=format&fit=crop&w=2100&q=80"
  },
  "Makeup": {
    "title": "Is makeup one of your daily esse …",
    "image":
        "https://images.unsplash.com/photo-1519368358672-25b03afee3bf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2004&q=80"
  },
  "Coffee": {
    "title": "Coffee is more than just a drink: It’s …",
    "image":
        "https://images.unsplash.com/photo-1500522144261-ea64433bbe27?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2102&q=80"
  },
  "Fashion": {
    "title": "Fashion is a popular style, especially in …",
    "image":
        "https://images.unsplash.com/photo-1487222477894-8943e31ef7b2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1326&q=80"
  },
  "Argon": {
    "title": "Argon is a great free UI packag …",
    "image":
        "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=1947&q=80"
  },
  "Music": {
    "title": "View article",
    "image":
        "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
    "products": [
      {
        "img":
            "https://images.unsplash.com/photo-1501084817091-a4f3d1d19e07?fit=crop&w=2700&q=80",
        "title": "Painting Studio",
        "description":
            "You need a creative space ready for your art? We got that covered.",
        "price": "\$125",
      },
      {
        "img":
            "https://scontent.floh4-1.fna.fbcdn.net/v/t39.30808-6/464858886_2382641502067015_9201867715336565630_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=6ee11a&_nc_ohc=8XVBU4qgw8QQ7kNvgElyuC7&_nc_oc=AdgWpYocSKdtap4zxF5HdWWh7P09QUZn9FLSlyKxD7fL42iLMDomsCdAZ4QpBpRxzFw&_nc_zt=23&_nc_ht=scontent.floh4-1.fna&_nc_gid=ATaWw-TeOQdavA7a1mhIvHB&oh=00_AYBHKl8MbYBkL-fRxVtFzC3c0wbEyum6_1uTBK5ju33rVA&oe=67A7F944",
        "title": "Derek Vergara",
        "description":
            "Premio doble, se cree que puede mandar por ser Scrum Master.",
        "price": "\$Free",
      },
      {
        "img":
            "https://images.unsplash.com/photo-1496680392913-a0417ec1a0ad?fit=crop&w=2700&q=80",
        "title": "Video Services",
        "description":
            "Some of the best music video services someone could have for the lowest prices.",
        "price": "\$300",
      },
    ],
    "suggestions": [
      {
        "img":
            "https://images.unsplash.com/photo-1511379938547-c1f69419868d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music studio for real..."
      },
      {
        "img":
            "https://images.unsplash.com/photo-1477233534935-f5e6fe7c1159?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=2700&q=80",
        "title": "Music equipment to borrow..."
      },
    ]
  }
};

class Articles extends StatelessWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Navbar(
          title: "Articles",
          rightOptions: false,
          tags: [], // List<String>
          getCurrentPage: () => 1, // Una función que retorne int
          searchController: TextEditingController(),
          searchOnChanged: (text) {
            // Lógica al cambiar texto
          },
        ),
        backgroundColor: NowUIColors.bgColorScreen,
        drawer: NowDrawer(currentPage: "Articles"),
        body: Container(
            padding: EdgeInsets.only(right: 24, left: 24, bottom: 36),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 32),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Cards",
                          style: TextStyle(
                              color: NowUIColors.text,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: CardHorizontal(
                        cta: "View article",
                        title: articlesCards["Ice Cream"]!['title'],
                        img: articlesCards["Ice Cream"]!['image'],
                        tap: () {
                          Navigator.pushNamed(context, '/pro');
                        }),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      CardSmall(
                          cta: "View article",
                          title: articlesCards["Makeup"]!['title'],
                          img: articlesCards["Makeup"]!['image'],
                          tap: () {
                            Navigator.pushNamed(context, '/pro');
                          }),
                      CardSmall(
                          cta: "View article",
                          title: articlesCards["Coffee"]!['title'],
                          img: articlesCards["Coffee"]!['image'],
                          tap: () {
                            Navigator.pushNamed(context, '/pro');
                          })
                    ],
                  ),
                  SizedBox(height: 8.0),
                  CardHorizontal(
                      cta: "View article",
                      title: articlesCards["Fashion"]!['title'],
                      img: articlesCards["Fashion"]!['image'],
                      tap: () {
                        Navigator.pushNamed(context, '/pro');
                      }),
                  SizedBox(height: 8.0),
                  CardSquare(
                      cta: "View article",
                      title: articlesCards["Argon"]!['title'],
                      img: articlesCards["Argon"]!['image'],
                      tap: () {
                        Navigator.pushNamed(context, '/pro');
                      }),
                  CardCategory(
                      tap: () {
                        Navigator.pushNamed(context, '/pro');
                      },
                      title: articlesCards["Music"]!["title"],
                      img: articlesCards["Music"]!["image"]),
                  Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Album",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: NowUIColors.text),
                          ),
                          Text(
                            "View All",
                            style: TextStyle(
                                color: NowUIColors.primary,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      )),
                  SizedBox(
                    height: 250,
                    child: GridView.count(
                        primary: false,
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 15.0),
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        children: <Widget>[
                          Container(
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6.0)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://images.unsplash.com/photo-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                    fit: BoxFit.cover),
                              )),
                          Container(
                              decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1543747579-795b9c2c3ada?fit=crop&w=240&q=80hoto-1501601983405-7c7cabaa1581?fit=crop&w=240&q=80"),
                                fit: BoxFit.cover),
                          )),
                          Container(
                              decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1551798507-629020c81463?fit=crop&w=240&q=80"),
                                fit: BoxFit.cover),
                          )),
                          Container(
                              decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1470225620780-dba8ba36b745?fit=crop&w=240&q=80"),
                                fit: BoxFit.cover),
                          )),
                          Container(
                              decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1503642551022-c011aafb3c88?fit=crop&w=240&q=80"),
                                fit: BoxFit.cover),
                          )),
                          Container(
                              decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.unsplash.com/photo-1482686115713-0fbcaced6e28?fit=crop&w=240&q=80"),
                                fit: BoxFit.cover),
                          )),
                        ]),
                  ),
                  Carousel(
                      imgArray: articlesCards["Music"]!["products"]),
                ],
              ),
            )));
  }
}
