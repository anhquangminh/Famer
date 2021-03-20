import 'package:farmer/screens/saler/MyStorePage.dart';
import 'package:flutter/material.dart';
import 'waiting.dart';
import '../model/ProductModel.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:farmer/screens/shopping/ProductPage.dart';
import 'package:farmer/animation/FomatNumber.dart';
import 'package:farmer/model/UserConstructer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer/screens/saler/EditProduct.dart';

class MyProduct extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyProductState();
  }
}

// AutomaticKeepAliveClientMixin: keep state after switch tab
class _MyProductState extends State<MyProduct> {
  @override
  var product = new List<Product>();
  String iduser = getIdUser.getid();

  double monney = 0;

  Future _getMyProduct() async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getmyproduct.php",
          body: {
            "iduser": iduser.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        Iterable list = await json.decode(response.body);
        setState(() {
          product = list.map((model) => Product.fromJson(model)).toList();
          double a = 0;
          for (int i = 0; i < product.length; i++) {
            a = a +
                (double.parse(product[i].price) * double.parse(product[i].sum));
          }
          monney = a;
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  initState() {
    super.initState();
    _getMyProduct();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  product.length == 0 ? new Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            'assets/images/people_empty.png',
            fit: BoxFit.fill,
            width: 64.0,
            height: 64.0,
          ),
          Text(
            " Không có sản phẩm nào ",
            style: GoogleFonts.pacifico(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ) : Column(
      children: <Widget>[
        Expanded(
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(
                    'Sản phẩm : ${product.length.toString()}',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Tổng tiền : ${Format.symbolOnRight(monney)}',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87),
                  ),
                )
              ],
            ),
          ),
        ),
        Divider(),
        Expanded(
          flex: 10,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: product.length,
              itemBuilder: (BuildContext context, i) {
                return FadeIn(
                    i.toDouble(),
                    ItemMyProduct(product[i], onTapped: () {
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
        ),
      ],
    );
  }

  Future _deleteProduct(String iduser, String idproduct) async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/delete/deleteproduct.php",
          body: {
            "iduser": iduser.trim(),
            "idproduct": idproduct.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        var message = jsonDecode(response.body);
        print(message);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyStorePage()));
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  Widget ItemMyProduct(Product product,
      {onLike, onTapped, bool isProductPage = false}) {
    return Container(
      padding: const EdgeInsets.all(8.0),
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
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
                              padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                              child: new Text(
                                "${Format.withoutFractionDigits(double.parse(product.price))} \$",
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Roboto"),
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 20.0, bottom: 10.0),
                              child: new Text(
                                "Tổng :${product.sum}",
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
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 1, left: 1),
                            child: new IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.teal[800],
                                size: 25,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Xóa'),
                                        content: Text(
                                            "Bạn muốn xóa : ${product.productname}"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: const Text('Không'),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                            },
                                          ),
                                          FlatButton(
                                            child: const Text('Tiếp tục'),
                                            onPressed: () {
                                              _deleteProduct(iduser,
                                                  product.idproduct.toString());
                                              Navigator.pop(context, true);
                                            },
                                          )
                                        ],
                                      );
                                    });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 1.0, bottom: 1.0),
                            child: IconButton(
                              icon: new Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 25.0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => new EditProduct(product: product,)));

                              },
                            ),
                          ),
                        ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
