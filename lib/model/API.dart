import 'dart:async';
import 'package:http/http.dart' as http;

const urlProduct = "http://quangminh-api.000webhostapp.com/api_for_app/getdata/";
const urlSelect = "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getlistproduct.php";

class APIProduct {
  static Future getProduct(String url) {
    return  http.get(urlProduct+url);
  }
}

