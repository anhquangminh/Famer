import 'package:flutter/material.dart';
import '../model/ProductModel.dart';
import 'package:farmer/animation/FomatNumber.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget ItemMyProduct(Product product,
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
                  child:SizedBox(
                    width: 100,
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: product.image,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                          child: new Text(
                            product.productname,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                                fontSize: 16.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Merriweather"),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            child: new Text(
                              product.discription,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto"),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 5.0),
                            child: new Text(
                              "${Format.withoutFractionDigits(double.parse(product.price))} \$",
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto"),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
                            child: new Text(
                              "Amount :${Format.withoutFractionDigits(double.parse(product.sum))}",
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto"),
                            )),
                      ]),
                ),
                Expanded(
                  flex: 1,
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 5, left: 3),
                          child: new IconButton(
                            icon: Icon(
                              Icons.delete_outline,
                              color: Colors.teal[800],
                              size: 25,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0, bottom: 10),
                          child: new Icon(
                            Icons.mode_edit,
                            color: Colors.teal[800],
                            size: 25.0,
                          ),
                        ),
                      ]),
                ),
              ]),
        ),
      ),
    ),
  );
}
