import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../shared/colors.dart';
import '../shared/styles.dart';
import '../model/ProductModel.dart';
import 'package:farmer/helper/CartHelper.dart';
import 'package:farmer/animation/FomatNumber.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:farmer/model/UserConstructer.dart';

Widget foodItem(Product product,
    {double imgWidth, onLike, onTapped, bool isProductPage = false}) {
  return Container(
    width: 180,
    height: 180,
    // color: Colors.red,
    margin: EdgeInsets.only(left: 20),
    child: Stack(
      children: <Widget>[
        Container(
          width: 180,
          height: 180,
          child: RaisedButton(
            color: white,
            elevation: (isProductPage) ? 20 : 12,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            onPressed: onTapped,
            child: SizedBox(
              width: 130,
              height: 130,
              child: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
//            child: Image.network(product.image,
//                width: (imgWidth != null) ? imgWidth : 100),
          ),
        ),
        Positioned(
          bottom: (isProductPage) ? 10 : 70,
          right: 0,
          child: FlatButton(
            padding: EdgeInsets.only(right: 0, left: 35, top: 30, bottom: 12),
            shape: CircleBorder(),
            onPressed: onLike,
            child: InkWell(
              onTap: () {
                CartHelper.insertFavourite(getIdUser.getid(), product.idproduct.toString());
              },
              child: Icon(
                Icons.favorite_border,
                color: Colors.red,
                size: 27,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          child: (!isProductPage)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.productname,
                      style: NameText,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                        "${Format.withoutFractionDigits(double.parse(product.price))} \$",
                        style: priceText),
                  ],
                )
              : Text(' '),
        ),
        Positioned(
            top: 10,
            left: 10,
            child: (product.sale != null)
                ? Container(
                    padding:
                        EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[600],
                        borderRadius: BorderRadius.circular(50)),
                    child: Text('-' + (product.sale).toString() + '%',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  )
                : SizedBox(width: 0))
      ],
    ),
  );
}
