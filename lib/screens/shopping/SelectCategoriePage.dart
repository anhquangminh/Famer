import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import '../../widgets/waiting.dart';
import '../../model/ProductModel.dart';
import '../../model/API.dart';
import 'ProductPage.dart';
import '../../shared/itemvertical.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/fryo_icons.dart';
import 'SearchPage.dart';

class SelectCategorie extends StatefulWidget {
  final String url;
  final String tittle;

  SelectCategorie(this.url, this.tittle);

  @override
  _SelectCategorieState createState() => _SelectCategorieState();
}

class _SelectCategorieState extends State<SelectCategorie> {
  var product = new List<Product>();

  Future _getFavoriteProduct() async {
    APIProduct.getProduct(widget.url).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        product = list.map((model) => Product.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getFavoriteProduct();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: BackButton(
            color: darkText,
          ),
          backgroundColor: primaryColor,
          title: Text(widget.tittle,
              style: logoWhiteStyle, textAlign: TextAlign.center),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return SearchPage();
                }));
              },
              iconSize: 21,
              icon: Icon(Fryo.search),
            ),
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              iconSize: 21,
              icon: Icon(Fryo.alarm),
            )
          ],
        ),
        body: new Container(
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: product.length,
              itemBuilder: (BuildContext context, i) {
                return FadeIn(
                    i.toDouble(),
                    ItemVertical(product[i], onTapped: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return new ProductPage(
                              productData: product[i],
                            );
                          },
                        ),
                      );
                    }, onLike: () {}));
              }),
        ));
  }
}
