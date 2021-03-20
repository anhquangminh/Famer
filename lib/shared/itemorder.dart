import 'package:flutter/material.dart';
import '../model/OrderModel.dart';
import 'package:farmer/animation/FomatNumber.dart';
import 'package:farmer/animation/FomatNumber.dart';
import 'package:cached_network_image/cached_network_image.dart';


Widget ItemOrder(OrderModel orderModel) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    child: new GestureDetector(
      child: new Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 6,
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.only(left: 10.0, bottom: 2.0),
                          child: new Text(
                            orderModel.productname,
                            overflow: TextOverflow.ellipsis,
                            style: new TextStyle(
                                fontSize: 15.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.bold,
                                fontFamily: "Merriweather"),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0,),
                            child: new Text(
                              "Số lượng: ${orderModel.count} ",
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto"),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0,),
                            child: new Text(
                              "Giá: ${Format.withoutFractionDigits(double.parse(orderModel.price))} \$",
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto"),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              "Người mua: ${orderModel.username}",
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto"),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              "Điện thoại : ${orderModel.phone}",
                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto"),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              "Địa chỉ: ${orderModel.address}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: new TextStyle(
                                  fontSize: 14.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Roboto",

                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.only(left: 10.0),
                            child: new Text(
                              "Ngày mua: ${Format.formatdate(orderModel.dateorder)}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: new TextStyle(
                                fontSize: 14.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto",
                              ),
                            )),
                      ]),
                ),
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: orderModel.image,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    ),
  );
}
