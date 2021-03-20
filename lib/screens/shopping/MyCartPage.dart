import 'dart:ui' as prefix0;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:farmer/model/CartModel.dart';
import 'dart:convert';
import '../../widgets/waiting.dart';
import 'package:farmer/animation/FomatNumber.dart';
import 'package:farmer/model/UserConstructer.dart';
import 'package:farmer/helper/CartHelper.dart';
import 'package:farmer/animation/FadeInAnimation.dart';
import 'package:farmer/screens/MainShoppPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCartPage extends StatefulWidget {
  MyCartPage({Key key}) : super(key: key);

  @override
  _MyCartPageState createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  var cart = new List<CartModel>();
  String iduser = getIdUser.getid();
  int sum = 0;
  int amount = 0;

  Future _getAllCart() async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getallcart.php",
          body: {
            "iduser": iduser.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        Iterable list = await json.decode(response.body);
        setState(() {
          cart.clear();
          cart = list.map((model) => CartModel.fromJson(model)).toList();
          sum = 0;
          amount = 0;
          for (int i = 0; i < cart.length; i++) {
            sum += int.parse(cart[i].count) * int.parse(cart[i].price);
            amount += int.parse(cart[i].count);
          }
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  Future _deleteProduct(String iduser, String idproduct) async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/delete/deletecart.php",
          body: {
            "iduser": iduser.trim(),
            "idproduct": idproduct.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        var message = jsonDecode(response.body);
        print(message);
        setState(() {
          _getAllCart();
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  Future _updatecount(String idcart, String count) async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/update/updatecountcart.php",
          body: {
            "idcart": idcart.trim(),
            "count": count.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        var message = jsonDecode(response.body);
        print(message);
        setState(() {
          _getAllCart();
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  initState() {
    super.initState();
    _getAllCart();
  }

  dispose() {
    super.dispose();
  }

  Widget _itemCart(CartModel cart,
      {onLike, onTapped, bool isProductPage = false}) {
    var total = int.parse(cart.count) * int.parse(cart.price);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(right: 5, top: 2),
                height: 95.0,
                width: 40.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        var _quantity = int.parse(cart.count);
                        _quantity += 1;
                        print(_quantity);
                        _updatecount(cart.idcart, _quantity.toString());
                      },
                      child: Icon(Icons.keyboard_arrow_up, color: Colors.black),
                    ),
                    Text(
                      cart.count,
                      style: TextStyle(fontSize: 18.0),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          var _quantity = int.parse(cart.count);
                          if (_quantity == 1) return;
                          _quantity -= 1;
                          print(_quantity);
                          _updatecount(cart.idcart, _quantity.toString());
                        });
                      },
                      child:
                          Icon(Icons.keyboard_arrow_down, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(right: 5),
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: CachedNetworkImage(
                      imageUrl: cart.image,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    cart.productname,
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    cart.discription,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    "${Format.withoutFractionDigits(double.parse(cart.price))} \$",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    "Total : ${Format.withoutFractionDigits(total.toDouble())} \$",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Xóa sản phẩm khỏi giỏ hàng'),
                          content: Text(
                              "Bạn muốn xóa sản phẩm : ${cart.productname}"),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Không'),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                            FlatButton(
                              child: const Text('Tiếp tục'),
                              onPressed: () {
                                _deleteProduct(
                                    iduser, cart.idproduct.toString());
                                Navigator.pop(context, true);
                              },
                            )
                          ],
                        );
                      });
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: cart.length == 0
          ? new Container(
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  new Image.asset(
//                    'assets/images/icons_empty.png',
//                    fit: BoxFit.fill,
//                    width: 120.0,
//                    height: 120.0,
//                  ),
//                  Text(
//                    " No product ",
//                    style: GoogleFonts.pacifico(fontSize: 20.0),
//                    textAlign: TextAlign.center,
//                  ),
//                ],
//              ),
            )
          : new Container(
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: cart.length,
                  itemBuilder: (BuildContext context, i) {
                    return FadeIn(i.toDouble(),
                        _itemCart(cart[i], onTapped: () {}, onLike: () {}));
                  }),
            ),
      bottomNavigationBar: _buildTotalContainer(),
    );
  }

  Widget _buildTotalContainer() {
    return Container(
      height: 200.0,
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 15,
                spreadRadius: 5,
                color: Color.fromRGBO(0, 0, 0, .07))
          ]),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Số lượng: ",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown),
                ),
                Text("${amount.toString()} ",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Divider(
            color: Colors.black,
          ),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Tổng tiền :",
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Spacer(),
                Text('${Format.symbolOnRight(sum.toDouble())}',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                if (sum > 0) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Mua hàng'),
                          content: Text("Bạn có chắc chắn muốn đặt hàng không?"),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('Hủy'),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                            FlatButton(
                              child: const Text('Tiếp tục'),
                              onPressed: () {
                                CartHelper.sendOrder(context, iduser);
                                setState(() {
                                  _getAllCart();
                                  Navigator.pop(context, true);
                                });
                              },
                            )
                          ],
                        );
                      });
                } else {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(child: Text('Warring !!')),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          content: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: SingleChildScrollView(
                              child: Column(
                                children: <Widget>[
                                  Center(
                                      child: Text(
                                    'Không có sản phẩm nào',
                                    style: TextStyle(fontSize: 15.0),
                                  )),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: FlatButton(
                                      child: Text(
                                        "Mua hàng ngay",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.blue,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            SlideRightRoute(page: MainShop()));
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
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                height: 45.0,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                  child: Text(
                    "Đặt mua hàng",
                    style: TextStyle(
                        fontFamily: 'Fryo',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
