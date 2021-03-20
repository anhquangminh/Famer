import 'dart:async';
import 'package:flutter/material.dart';
import 'package:farmer/widgets/myproduct.dart';
import 'package:farmer/widgets/soldproduct.dart';
import 'package:farmer/widgets/chartmystore.dart';
import '../MainShoppPage.dart';
import '../../shared/styles.dart';
import '../../shared/fryo_icons.dart';
import '../saler/AddProduct.dart';

var primarySwatch = Colors.deepPurple;

class MyStorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: HomePage(title: ''),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController productname = new TextEditingController();

  var _tab = <Widget>[
    ChartMyStore(),
    MyProduct(),
    SoldProduct(),
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<bool> _onWillPopScope() {
    return Future(() => true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: DefaultTabController(
        length: _tab.length,
        child: NestedScrollView(
          physics: NeverScrollableScrollPhysics(),
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.green[300],
                leading: BackButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MainShop()));
                  },
                  color: Colors.white,
                ),
                title: Center(
                  child: Text('Cửa hàng của tôi',
                      style: logoWhiteStyle, textAlign: TextAlign.center),
                ),
                actions: <Widget>[
                  Builder(
                      builder: (context) => IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {},
                            iconSize: 21,
                            icon: Icon(Fryo.alarm),
                          ))
                ],
                pinned: true,
                floating: true,
                forceElevated: isScrolled,
                bottom: TabBar(
                  indicatorColor: Colors.black,
                  unselectedLabelColor: Colors.deepPurple,
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.insert_chart),),
                    Tab(icon: Icon(Icons.child_friendly),),
                    Tab(icon: Icon(Icons.history),),
                  ],
                ),
              )
            ];
          },
          body: GestureDetector(
            onTap: () {},
            child: Scaffold(
              body: TabBarView(
                children: _tab,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)=> AddProduct()));
                },
                backgroundColor: const Color(0xFFea8d5c),
                child: Icon(
                  Icons.add,
                  color: const Color(0xFFd3fdfd),
                  size: 35,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//  _showDialog(context) async {
//    showDialog(
//        context: context,
//        builder: (BuildContext context) {
//          return Dialog(
//            shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(20.0)), //this right here
//            child: Scaffold(
//              body: Container(
//                height: MediaQuery.of(context).size.height-20,
//                width: MediaQuery.of(context).size.width-10,
//                child: Padding(
//                  padding: const EdgeInsets.all(12.0),
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    crossAxisAlignment: CrossAxisAlignment.start,
//                    children: [
//                      Expanded(
//                        child: _input(
//                            'Product Name', productname, TextInputType.text),
//                      ),
//                      SizedBox(
//                        width: 320.0,
//                        child: RaisedButton(
//                          onPressed: () {
//                            Navigator.pop(context, true);
//                          },
//                          child: Text(
//                            "Save",
//                            style: TextStyle(color: Colors.white),
//                          ),
//                          color: const Color(0xFF1BC0C5),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          );
//        });
//  }
//
//  Widget _input(String title, TextEditingController controller,
//      TextInputType keyboardType) {
//    return new TextFormField(
//      controller: controller,
//      autofocus: true,
//      maxLines: 2,
//      keyboardType: keyboardType,
//      decoration: new InputDecoration(labelText: title, hintText: ''),
//      validator: (value) {
//        if (value.isEmpty) {
//          return 'Please enter some text';
//        }
//        return null;
//      },
//    );
//  }
}
