import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      child: TextField(
        decoration: InputDecoration(
          helperMaxLines: 1,
          contentPadding: EdgeInsets.symmetric(horizontal: 32.0,vertical: 14.0),
          hintText: "Nhập sản phẩm",
          suffixIcon: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            child: IconButton(icon: Icon(Icons.search,color:Colors.black,), onPressed: null)
          ),
          border: InputBorder.none,
          //prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
