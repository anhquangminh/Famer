import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:convert';
import 'dart:async';
import '../../widgets/waiting.dart';
import '../../model/ProductModel.dart';
import 'ProductPage.dart';
import '../../shared/itemvertical.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/fryo_icons.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var product = new List<Product>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController keysearch = new TextEditingController();

  initState() {
    super.initState();
    _getProductSearch();
  }

  dispose() {
    super.dispose();
  }
  Future _getProductSearch() async {
    if (_formKey.currentState.validate()) {
      var response;
      if (keysearch.toString() != null) {
        try {
          response = await http.post(
              "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getsearchproduct.php",
              body: {
                "keysearch": keysearch.text.toString().trim(),
              });
          if (response.statusCode == 200) {
            // if every things are right decode the response and insertInf then return true
            Iterable list = await json.decode(response.body);
            setState(() {
              product.clear();
              product = list.map((model) => Product.fromJson(model)).toList();
            });
          }
        } catch (e) {
          print(e); // else print the error then return false
        }
      } else {
        return false;
      }
    }
  }

  Future<void> _alert(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warring !!'),
          content: const Text('Vui lòng nhập sản phẩm tìm kiếm'),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new KeyboardDismisser(
      gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: primaryColor,
          title: Text('Tìm kiếm sản phẩm',
              style: logoWhiteStyle, textAlign: TextAlign.center),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              iconSize: 21,
              icon: Icon(Fryo.alarm),
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  child: TextFormField(
                    controller: keysearch,
                    decoration: InputDecoration(
                      helperMaxLines: 1,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                      hintText: "Tìm sản phẩm",
                      suffixIcon: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(30.0),
                          child: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                _getProductSearch();
                              })),
                      border: InputBorder.none,
                      //prefixIcon: Icon(Icons.search),
                    ),
                    validator: (value) {
                      //check if the username is not less than two characters
                      if (value.length < 1) {
                        _alert(this.context);
                        return '$value';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: product.length == 0
                  ? new Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Image.asset(
                      'assets/images/icons_empty.png',
                      fit: BoxFit.fill,
                      width: 120.0,
                      height: 120.0,
                    ),
                    Text(
                      " Không có sản phẩm nào ",
                      style: GoogleFonts.pacifico(fontSize: 20.0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ) : Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
