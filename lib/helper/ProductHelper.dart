import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:farmer/screens/saler/MyStorePage.dart';

class ProductHelper {
  static Future sendProduct(
      GlobalKey<FormState> formKey,
      BuildContext context,
      String iduser,
      String productname,
      String idgroup,
      String price,
      String sum,
      String sale,
      String description,
      String image,
      String name
      ) async {
    if (formKey.currentState.validate()) {
      try {
        // if you do not understand these data go to (insert_task.php)
        var data = {
          'iduser': iduser,
          'productname': productname,
          'idgroup': idgroup,
          'price': price,
          'sum': sum,
          'sale': sale,
          'description': description,
          'image': image,
          'name': name,
        };
        var response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/insertdata/insertproduct.php",
          body: json.encode(data),
        );
        if (response.statusCode == 200) {
          // if every things are right then return true
          var message = jsonDecode(response.body);
          print(message);

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('Thêm thành công !')),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Text(
                                message,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyStorePage()),
                                );
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
  }

  static Future sendEditProduct(
      GlobalKey<FormState> formKey,
      BuildContext context,
      String idproduct,
      String productname,
      String idgroup,
      String price,
      String sum,
      String sale,
      String description,
      ) async {
    if (formKey.currentState.validate()) {
      try {
        // if you do not understand these data go to (insert_task.php)
        var data = {
          'idproduct': idproduct,
          'productname': productname,
          'idgroup': idgroup,
          'price': price,
          'sum': sum,
          'sale': sale,
          'description': description,
        };
        var response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/update/updateproduct.php",
          body: json.encode(data),
        );
        if (response.statusCode == 200) {
          // if every things are right then return true
          var message = jsonDecode(response.body);
          print(message);

          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Center(child: Text('Edit product suscessfully !')),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  content: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Center(
                              child: Text(
                               message,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyStorePage()),
                                );
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
  }
}
