import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../screens/LoginPage.dart';
import 'package:farmer/screens/MainShoppPage.dart';
import 'package:farmer/screens/wellcome/onboarding1.dart';

class UserHelper {
  static Future sendRegister(
      GlobalKey<FormState> formKey,
      BuildContext context,
      String username,
      String password,
      String email,
      String address,
      String phone,
      String birthday,
      String sex
      ) async {
    if (formKey.currentState.validate()) {
      try {
        // if you do not understand these data go to (insert_task.php)
        var data = {
          'username': username,
          'password': password,
          'email': email,
          'address': address,
          'phone': phone,
          'birthday': birthday,
          'sex': sex,
        };
        var response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/insertdata/insertUser.php",
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
                  title: Center(child: Text('Chào mừng bạn tới với Farmer ')),
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
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          )),
                          SizedBox(height: 5,),
                          Center(
                            child: FlatButton(
                              child: Text("Đăng nhập"),
                              color: Colors.blueAccent,
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Onboarding1()),
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

  static Future sendChangePassword(
      GlobalKey<FormState> formKey,
      BuildContext context,
      String iduser,
      String username,
      String password,
      String newpassword,) async {
    if (formKey.currentState.validate()) {
      try {
        // if you do not understand these data go to (insert_task.php)
        var data = {
          'iduser':iduser,
          'username': username,
          'password': password,
          'newpassword': newpassword,
        };
        var response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/update/updatepassword.php",
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
                  title: Center(child: Text('Change password success ')),
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
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              )),
                          SizedBox(height: 5,),
                          Center(
                            child: FlatButton(
                              child: Text("Đăng nhập"),
                              color: Colors.blueAccent,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
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

  static Future sendInforUser(
      BuildContext context,
      String iduser,
      String adress,
      String phone,
      String email,
      String birthday,
      String sex,) async {
    try {
      // if you do not understand these data go to (insert_task.php)
      var data = {
        'iduser':iduser,
        'adress': adress,
        'phone': phone,
        'email': email,
        'birthday': birthday,
        'sex':sex,
      };
      var response = await http.post(
        "http://quangminh-api.000webhostapp.com/api_for_app/update/updateinforuser.php",
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
                title: Center(child: Text('Update success')),
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
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            )),
                        SizedBox(height: 5,),
                        Center(
                          child: FlatButton(
                            child: Text("Đồng ý"),
                            color: Colors.blueAccent,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MainShop()));
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

  static Future sendImageUser(
      BuildContext context,
      String iduser,
      String image,
      String name,) async {
    try {
      // if you do not understand these data go to (insert_task.php)
      var data = {
        'iduser':iduser,
        'image': image,
        'name': name,
      };
      var response = await http.post(
        "http://quangminh-api.000webhostapp.com/api_for_app/insertdata/updateimageuser.php",
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
                title: Center(child: Text('Cập nhật thành công')),
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
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                              ),
                            )),
                        SizedBox(height: 5,),
                        Center(
                          child: FlatButton(
                            child: Text("OK"),
                            color: Colors.blueAccent,
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>MainShop()));
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
