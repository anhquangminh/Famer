import 'package:farmer/provider/UserProvider.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../shared/styles.dart';
import '../../shared/colors.dart';
import '../../shared/fooditem.dart';
import '../../shared/buttons.dart';
import '../../model/ProductModel.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:farmer/helper/CartHelper.dart';
import 'package:farmer/model/UserConstructer.dart';

class ProductPage extends StatefulWidget {
  final String pageTitle;
  final Product productData;

  ProductPage({Key key, this.pageTitle, this.productData}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  double _rating = 4;
  int _quantity = 1;
  String iduser=getIdUser.getid();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: bgColor,
          centerTitle: true,
          leading: BackButton(
            color: darkText,
          ),
          title: Text(widget.productData.productname, style: TextStyle(fontSize: 20.0 ,fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        body: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 15),
              child: Center(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(top: 100, bottom: 100),
                        padding: EdgeInsets.only(top: 100, bottom: 50),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.productData.productname, style: h5),
                            Text(widget.productData.price.toString()+' \$', style: h4),
                            Container(
                              margin: EdgeInsets.only(top: 5, bottom: 20),
                              child: SmoothStarRating(
                                allowHalfRating: false,
                                // onRatingChanged: (v) {
                                //   setState(() {
                                //     _rating = v;
                                //   });
                                // },
                                starCount: 5,
                                rating: _rating,
                                size: 27.0,
                                color: Colors.orange,
                                borderColor: Colors.orange,
                              ),
                            ),
                            Container(
                              width: 180,
                              child: Text(
                                widget.productData.discription,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: DiscriptionText,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 10, bottom: 25),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text('Số lượng', style: h6),
                                    margin: EdgeInsets.only(bottom: 15),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: OutlineButton(
                                          onPressed: () {
                                            setState(() {
                                              if(_quantity == 1) return;
                                              _quantity -= 1;
                                            }
                                            );
                                          },
                                          child: Icon(Icons.remove),
                                        ),
                                      ),
                                      Container(
                                        margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                        child: Text(_quantity.toString(), style: h3),
                                      ),
                                      Container(
                                        width: 55,
                                        height: 55,
                                        child: OutlineButton(
                                          onPressed: () {
                                            setState(() {
                                              if(_quantity == int.parse(widget.productData.sum)) return;
                                              _quantity += 1;
                                            });
                                          },
                                          child: Icon(Icons.add),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // Container(
                            //   width: 180,
                            //   child: froyoOutlineBtn('Buy Now', () {}),
                            // ),
                            Container(
                              width: 180,
                              child: froyoFlatBtn('Thêm vào giỏ hàng', () {
                                CartHelper.sendCart(context,iduser,widget.productData.idproduct,_quantity.toString());
                              }),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 15,
                                  spreadRadius: 5,
                                  color: Color.fromRGBO(0, 0, 0, .05))
                            ]),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 200,
                        height: 160,
                        child: foodItem(widget.productData,
                            isProductPage: true,
                            onTapped: () {},
                            imgWidth: 250,
                            onLike: () {}),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
