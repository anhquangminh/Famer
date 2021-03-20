import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../model/ProductModel.dart';
import 'package:http/http.dart' as http;

class ProductProvider with ChangeNotifier {
  Future<bool> getSearchProduct (String keysearch) async {
    var response;
    var product = new List<Product>();
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getsearchproduct.php",
          body: {
            "keysearch": keysearch.trim()
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
//        product = await json.decode(response.body);
        Iterable list = json.decode(response.body);
        product = list.map((model) => Product.fromJson(model)).toList();
        return true;
      }
      print(product);
    } catch (e) {
      print(e); // else print the error then return false
    }
    return false;
  }
}