import 'package:flutter/material.dart';
import '../../shared/appTheme.dart';
import 'ProfilePage.dart';
import '../../provider/UserProvider.dart';
import 'package:provider/provider.dart';
import '../LoginPage.dart';
import '../saler/MyStorePage.dart';
import 'OrderHistoryPage.dart';
import 'package:farmer/widgets/about.dart';
import 'package:farmer/widgets/changepassword.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage>
    with SingleTickerProviderStateMixin {
  UserInf getUserInfo;

  String username;
  String image;
  @override
  bool _status = true;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo = Provider.of<User>(context).getUserInf();
    username = getUserInfo.username;
    image = getUserInfo.image;
    if (image == null && username == null) {
      image = 'assets/images/logo.png';
      username = 'farmer';
    }

    return Scaffold(
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              new Container(
                height: 180.0,
                child: new Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: new Stack(fit: StackFit.loose, children: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              width: 150.0,
                              height: 150.0,
                              child: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(image),
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ]),
                    )
                  ],
                ),
              ),
              new Container(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 1.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 5.0),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  new Text(
                                    username,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _status ? _getEditIcon() : new Container(),
                                ],
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              new Container(
                padding: EdgeInsets.fromLTRB(30.0, 10.0, 20.0, 30.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePage()));
                      },
                      title: Text("Tài khoản", style: AppTheme.body1),
                      leading: Icon(
                        Icons.perm_identity,
                        color: const Color(0xFF3b7584),
                        size: 30,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyStorePage()));
                      },
                      title: Text("Cửa hàng của tôi", style: AppTheme.body1),
                      leading: Icon(
                        Icons.store,
                        color: const Color(0xFF3b7584),
                        size: 30,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderHistoryPage()));
                      },
                      title: Text("Lịch sử đặt hàng", style: AppTheme.body1),
                      leading: Icon(
                        Icons.history,
                        color: const Color(0xFF3b7584),
                        size: 30,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChangePassword()));
                      },
                      title: Text("Đổi mật khẩu", style: AppTheme.body1),
                      leading: Icon(
                        Icons.scanner,
                        color: const Color(0xFF3b7584),
                        size: 30,
                      ),
                    ),
                    Divider(),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => About()));
                      },
                      title: Text("Thông tin", style: AppTheme.body1),
                      leading: Icon(
                        Icons.info_outline,
                        color: const Color(0xFF3b7584),
                        size: 30,
                      ),
                    ),
                    Divider(),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: new BoxDecoration(
                        borderRadius:
                            new BorderRadius.all(Radius.circular(30.0)),
                      ),
                      child: ListTile(
                        title: new Text(
                          "Đăng xuất",
                          style: new TextStyle(
                            fontFamily: "WorkSans",
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            letterSpacing: -0.05,
                            color: Colors.red,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        leading: Icon(
                          Icons.power_settings_new,
                          color: Colors.red,
                        ),
                        onTap: () {
                          Provider.of<User>(context, listen: false).logOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new CircleAvatar(
        backgroundColor: Colors.red,
        radius: 14.0,
        child: new Icon(
          Icons.edit,
          color: Colors.white,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
        });
      },
    );
  }
}
