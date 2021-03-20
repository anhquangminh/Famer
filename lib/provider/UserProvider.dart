/**the provider for parent */

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

//ParentClass
class UserInf {
  final String iduser;
  final String username;
  final String password;
  final String email;
  final String address;
  final String phone;
  final String birthday;
  final String sex;
  final String image;
  final String registerdate;
  UserInf(
      {this.iduser,
      this.username,
      this.password,
      this.email,
      this.address,
      this.phone,
      this.birthday,
      this.sex,
      this.image,
      this.registerdate});
}

// the class for the provider

class User with ChangeNotifier {
  UserInf _inf; // we will put the data that we will get at this variable

  // we will get the _inf variable by calling this function
  UserInf getUserInf() {
    return _inf;
  }
  // we will insert the data using this function
  void setUserInf(UserInf inf) {
    _inf = inf;
    print(_inf);
    notifyListeners();
  }

  //we will use this function to login and get parent infromation by passing the username and password to it
  // we use it Future Boolean <so when we use it we check if the user logged properly return true other wise return false>
  Future<bool> loginUserAndGetInf(String user, String pass) async {
    var response;
    var datauser;
    print(user);
    print(pass);
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/login.php",
          body: {
            "username": user.trim(),
            // we use trim method to avoid spaces that user may make when logging
            "password": pass.trim(),
            // we use trim method to avoid spaces that user may make when logging
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        datauser = await json.decode(response.body);
        insertInf(datauser);
        return true;
      }
      print(datauser);
    } catch (e) {
      print(e); // else print the error then return false

    }
    return false;
  }

//  Future<bool> GetInfUser(String iduser) async {
//    var response;
//    var datauser;
//    try {
//      response = await http.post(
//          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getuserbyid.php",
//          body: {
//            "iduser": iduser.trim(),
//          });
//      if (response.statusCode == 200) {
//        // if every things are right decode the response and insertInf then return true
//        datauser = await json.decode(response.body);
//        _inf = new UserInf(); // we will empty the _inf variable cause the user logged out
//        notifyListeners();
//        insertInf(datauser);
//        return true;
//      }
//      print(datauser);
//    } catch (e) {
//      print(e); // else print the error then return false
//
//    }
//    return false;
//  }

// i just used this function to make the code more organised and not so messed
  insertInf(dynamic datauser) {
    UserInf userInf = UserInf(
        iduser: datauser[0]['id_user'],
        username: datauser[0]['user_name'],
        password: datauser[0]['password'],
        email: datauser[0]['email'],
        address: datauser[0]['address'],
        phone: datauser[0]['phone'],
        birthday: datauser[0]['birthday'],
        sex: datauser[0]['sex'],
        image: datauser[0]['image'],
        registerdate: datauser[0]['register_date']);
    // after inserting then pass it to setParentInf to insert the data to our _inf variable
    setUserInf(userInf);
  }

  logOut() {
    _inf = new UserInf(); // we will empty the _inf variable cause the user logged out
    notifyListeners();
    print(_inf.iduser);
  }
}

