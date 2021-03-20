import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import '../../widgets/waiting.dart';
import '../../model/CartModel.dart';
import '../../model/API.dart';
import 'ProductPage.dart';
import 'package:http/http.dart' as http;
import 'package:farmer/animation/FomatNumber.dart';
import 'package:farmer/model/UserConstructer.dart';
import 'package:cached_network_image/cached_network_image.dart';


class OrderHistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<OrderHistoryPage> {
  var order = new List<CartModel>();
  String iduser = getIdUser.getid();
  int totalproducts = 0;
  int paymentamount = 0;

  Future _getOrder(String iduser) async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getorder.php",
          body: {
            "iduser": iduser.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        setState(() {
          Iterable list = json.decode(response.body);
          order = list.map((model) => CartModel.fromJson(model)).toList();

          totalproducts=0;
          paymentamount=0;
          for(int i=0 ;i< order.length ;i++){
            paymentamount +=int.parse(order[i].count) * int.parse(order[i].price);
            totalproducts += int.parse(order[i].count);
          }
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  initState() {
    super.initState();
    _getOrder(iduser);
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lịch sử đặt hàng',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: order.length,
            itemBuilder: (BuildContext context, i) {
              return FadeIn(
                  i.toDouble(),
                  ItemVertical(order[i], onTapped: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) {
//                          return new ProductPage(
//                            productData: product[i],
//                          );
//                        },
//                      ),
//                    );
                  }, onLike: () {}));
            }),
      ),
      bottomNavigationBar: _buildTotalContainer(),
    );
  }

  Widget ItemVertical(CartModel order,
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
                        imageUrl: order.image,
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            child: new Text(
                              order.productname,
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 16.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Merriweather"),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 20.0, bottom: 2.0),
                              child: new Text(
                                order.discription,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Roboto"),
                              )),
                          Padding(
                              padding:
                                  EdgeInsets.only(left: 20.0, bottom: 2.0),
                              child: new Text(
                                "Giá : ${Format.withoutFractionDigits(double.parse(order.price))} \$",
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Roboto"),
                              )),
                          Padding(
                              padding:
                              EdgeInsets.only(left: 20.0, bottom: 2.0),
                              child: new Text(
                                "Số lượng : ${order.count.toString()}",
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Roboto"),
                              )),
                          Padding(
                              padding:
                              EdgeInsets.only(left: 20.0, bottom: 2.0),
                              child: new Text(
                                "Thời gian đặt: ${Format.formatdate(order.dateadd)}",
                                overflow: TextOverflow.ellipsis,
                                style: new TextStyle(
                                    fontSize: 15.0,
                                    color: const Color(0xFF000000),
                                    fontWeight: FontWeight.w300,
                                    fontFamily: "Roboto"),
                              )),

                        ]),
                  ),
                ]),
          ),
        ),
      ),
    );
  }

  Widget _buildTotalContainer() {
    return Card(
      color: Colors.tealAccent,
      margin: EdgeInsets.only(bottom: 0),
      child: Container(
        height: 120.0,
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 10.0
        ),
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  new Icon(
                      Icons.filter_vintage,
                      color: const Color(0xFFb96f6f),
                      size: 20.0),
                  Text(
                    " Tổng sản phẩm: ",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown),
                  ),
                  Spacer(),
                  Text("${totalproducts.toString()} ",
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown)),
                ],
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Icon(
                      Icons.monetization_on,
                      color: const Color(0xFF425691),
                      size: 20.0),
                  Text(
                    " Số tiền thanh toán : ",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Spacer(),
                  Text('${Format.symbolOnRight(paymentamount.toDouble())}',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
