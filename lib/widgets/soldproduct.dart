import 'package:flutter/material.dart';
import 'waiting.dart';
import '../model/ProductModel.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import '../shared/itemorder.dart';
import 'package:farmer/model/OrderModel.dart';
import 'package:farmer/model/UserConstructer.dart';
import 'package:google_fonts/google_fonts.dart';

class SoldProduct extends StatefulWidget {
  @override
  _SoldProductState createState() => _SoldProductState();
}

class _SoldProductState extends State<SoldProduct> {
  var order = new List<OrderModel>();
  String iduser=getIdUser.getid();

  Future _getFavoriteProduct() async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/orderhistory.php",
          body: {
            "iduser": iduser.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        Iterable list = await json.decode(response.body);
        setState(() {
          order.clear();
          order = list.map((model) => OrderModel.fromJson(model)).toList();
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  initState() {
    super.initState();
    _getFavoriteProduct();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return order.length == 0
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
            "Empty product ",
            style: GoogleFonts.pacifico(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    )
        : Container(
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: order.length,
          itemBuilder: (BuildContext context, i) {
            return FadeIn(
                i.toDouble(), ItemOrder(order[i]));
          }),
    );
  }
}
