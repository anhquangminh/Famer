import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import '../../widgets/waiting.dart';
import '../../model/ProductModel.dart';
import '../../model/API.dart';
import 'ProductPage.dart';
import 'package:http/http.dart' as http;
import 'package:farmer/animation/FomatNumber.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmer/model/UserConstructer.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  var product = new List<Product>();
  String iduser = getIdUser.getid();


  Future _getFavoriteProduct(String iduser) async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getlistfavorite.php",
          body: {
            "iduser": iduser.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        setState(() {
          Iterable list = json.decode(response.body);
          product = list.map((model) => Product.fromJson(model)).toList();

        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  Future _deleteFavourite(String iduser, String idfavourite) async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/delete/deletefavourite.php",
          body: {
            "iduser": iduser.trim(),
            "idproduct": idfavourite.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        var message = jsonDecode(response.body);
        print(message);
        setState(() {
          _getFavoriteProduct(iduser);
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  initState() {
    super.initState();
    _getFavoriteProduct(iduser);
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return product.length == 0
        ? new Container(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                new Image.asset(
//                  'assets/images/icons_empty.png',
//                  fit: BoxFit.fill,
//                  width: 120.0,
//                  height: 120.0,
//                ),
//                Text(
//                  " No product ",
//                  style: GoogleFonts.pacifico(fontSize: 20.0),
//                  textAlign: TextAlign.center,
//                ),
//              ],
//            ),
          )
        : new Container(
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
          );
  }

  Widget ItemVertical(Product product,
      {onLike, onTapped, bool isProductPage = false}) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: new GestureDetector(
        onTap: onTapped,
        child: new Card(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                            child: new Text(
                              product.productname,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 16.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Merriweather"),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: new Text(
                                product.discription,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Roboto"),
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 20.0, bottom: 10.0),
                              child: new Text(
                                "${Format.withoutFractionDigits(double.parse(product.price))} \$",
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Roboto"),
                              )),
                        ]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 60,
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Bạn muốn xóa khỏi danh sách yêu thích'),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text('Hủy'),
                                        onPressed: () {
                                          Navigator.pop(context, true);
                                        },
                                      ),
                                      FlatButton(
                                        child: const Text('Tiếp tục'),
                                        onPressed: () {
                                          _deleteFavourite(
                                              iduser, product.idproduct);
                                          Navigator.pop(context, true);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: new Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
