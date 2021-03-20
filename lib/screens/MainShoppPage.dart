import 'package:flutter/material.dart';
import '../shared/styles.dart';
import '../shared/colors.dart';
import '../shared/fryo_icons.dart';
import 'shopping/MyCartPage.dart';
import 'shopping/SettingPage.dart';
import 'shopping/FavouritePage.dart';
import 'shopping/Dashbroad.dart';
import 'shopping/SearchPage.dart';
import 'package:farmer/provider/UserProvider.dart';
import 'package:provider/provider.dart';

class MainShop extends StatefulWidget {
  final String pageTitle;
  MainShop({Key key, this.pageTitle}) : super(key: key);

  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final _tabs = [
      // OrderPage(),
      Dashboard(),
      MyCartPage(),
      FavouritePage(),
      SettingPage(),
    ];

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {},
            iconSize: 21,
            icon: Icon(Fryo.funnel),
          ),
          backgroundColor: primaryColor,
          title: Text('Farmer',
              style: logoWhiteStyle, textAlign: TextAlign.center),
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SearchPage();
                }));
              },
              iconSize: 21,
              icon: Icon(Fryo.search),
            ),
            IconButton(
              padding: EdgeInsets.all(0),
              onPressed: () {

              },
              iconSize: 21,
              icon: Icon(Fryo.alarm),
            )
          ],
        ),
        body: _tabs[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Fryo.shop),
                title: Text(
                  'Cửa hàng',
                  style: tabLinkStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Fryo.cart),
                title: Text(
                  'Giỏ hàng',
                  style: tabLinkStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Fryo.heart),
                title: Text(
                  'Yêu thích',
                  style: tabLinkStyle,
                )),
            BottomNavigationBarItem(
                icon: Icon(Fryo.cog_1),
                title: Text(
                  'Cài đặt',
                  style: tabLinkStyle,
                ))
          ],
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.green[600],
          onTap: _onItemTapped,
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
