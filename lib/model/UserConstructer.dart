import 'package:farmer/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class UserConstructer {
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

  UserConstructer(
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

  UserConstructer.fromJson(Map json)
      : iduser = json['id_user'],
        username = json['user_name'],
        password = json['password'],
        email = json['email'],
        address = json['address'],
        phone = json['phone'],
        birthday = json['birthday'],
        sex = json['sex'],
        image = json['image'],
        registerdate = json['register_date'];

  Map toJson() {
    return {
      'id_user': iduser,
      'user_name': username,
      'password': password,
      'email': email,
      'address': address,
      'phone': phone,
      'birthday': birthday,
      'sex': sex,
      'image': image,
      'register_date': registerdate
    };
  }
}

class getIdUser{
  static String iduser='0';
  static String setid(String id){
    iduser=id;
  }
  static String getid(){
    return iduser;
  }
}


