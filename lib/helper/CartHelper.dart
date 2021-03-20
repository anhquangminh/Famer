import 'dart:convert';
import 'package:farmer/screens/shopping/MyCartPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:farmer/screens/shopping/OrderHistoryPage.dart';
import 'package:farmer/animation/FadeInAnimation.dart';

class CartHelper {
  static Future insertFavourite(String iduser, String idproduct) async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/insertdata/insertfavourite.php",
          body: {
            "iduser": iduser.trim(),
            "idproduct": idproduct.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        var message = jsonDecode(response.body);
        print(message);
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }
  static Future _getAllCart(String iduser) async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getallcart.php",
          body: {
            "iduser": iduser.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        var userData = await json.decode(response.body);
        // return userData
        print(userData);
        return userData;
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }
  static Future sendCart(
      BuildContext context,
      String iduser,
      String idproduct,
      String count,
      ) async {
      try {
        var data = {
          'iduser': iduser,
          'idproduct': idproduct,
          'count': count,
        };
        var response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/insertdata/insertcart.php",
          body: json.encode(data),
        );
        if (response.statusCode == 200) {
          var message = jsonDecode(response.body);
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('Thêm sản phẩm vào giỏ hàng')),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Text(
                                "Thêm thành công",
                                style: GoogleFonts.antic(
                                  textStyle: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14),
                                ),
                              )),
                          SizedBox(height: 5,),
                          Center(
                            child: FlatButton(
                              child: Text("Đồng ý"),
                              color: Colors.blueAccent,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      } catch (e) {
        print(e);
      }
  }

  static Future sendOrder(
      BuildContext context,
      String iduser,
      ) async {
    try {
      var data = {
        'iduser': iduser,
      };
      var response = await http.post(
        "http://quangminh-api.000webhostapp.com/api_for_app/insertdata/insertorder.php",
        body: json.encode(data),
      );
      if (response.statusCode == 200) {
        var message = jsonDecode(response.body);
        Fluttertoast.showToast(msg: message,toastLength: Toast.LENGTH_SHORT);
      }
    } catch (e) {
      print(e);
    }
  }
}
