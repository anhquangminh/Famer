import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:farmer/provider/UserProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farmer/widgets/uploadimage.dart';
import 'package:intl/intl.dart';
import 'package:farmer/helper/UserHelper.dart';
import 'package:farmer/model/UserConstructer.dart';

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  var user = new List<UserConstructer>();

  bool _status = true;
  UserInf getUserInfo;

  String iduser =getIdUser.getid() ;
  String username;
  String address;
  String phone;
  String email;
  String birthday;
  int sex;
  String image;

  TextEditingController addresscontroller = new TextEditingController();
  TextEditingController phonecontroller = new TextEditingController();
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController birthdaycontroller = new TextEditingController();

  DateTime selectedDate = DateTime.now();

  int selectedRadio = 1;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  final FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
//  Future _getInfor() async {
//    var response;
//    try {
//      response = await http.post(
//          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getuserbyid.php",
//          body: {
//            "iduser": iduser.trim(),
//          });
//      if (response.statusCode == 200) {
//        // if every things are right decode the response and insertInf then return true
//        Iterable list = await json.decode(response.body);
//        setState(() {
//          user = list.map((model) => UserConstructer.fromJson(model)).toList();
//        });
//      }
//    } catch (e) {
//      print(e); // else print the error then return false
//    }
//  }

  _update(String iduser) async {
    if (addresscontroller != null &&
        phonecontroller != null &&
        emailcontroller != null) {
      showLoadingProgress();
      print(iduser +
          ',' +
          addresscontroller.text +
          ',' +
          phonecontroller.text +
          ',' +
          emailcontroller.text +
          ',' +
          birthdaycontroller.text +
          ',' +
          selectedRadio.toString());
      UserHelper.sendInforUser(
        context,
        iduser,
        addresscontroller.text,
        phonecontroller.text,
        emailcontroller.text,
        birthdaycontroller.text,
        selectedRadio.toString(),
      );
    } else {
      showAlert('Warring', 'Not be empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserInfo = Provider.of<User>(context).getUserInf();
    username=getUserInfo.username;
    addresscontroller.text = address = getUserInfo.address;
    phonecontroller.text = phone = getUserInfo.phone;
    birthdaycontroller.text = birthday = getUserInfo.birthday;
    emailcontroller.text = email = getUserInfo.email;
    image = getUserInfo.image;
    sex = int.parse(getUserInfo.sex);

    return new Scaffold(
      appBar: new AppBar(
        title: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Cập nhật thông tin',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                new Container(
                  height: 180.0,
                  color: Colors.white,
                  child: new Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child:
                            new Stack(fit: StackFit.loose, children: <Widget>[
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
                          Padding(
                              padding: EdgeInsets.only(top: 95.0, right: 100.0),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UploadImage()));
                                    },
                                    child: new CircleAvatar(
                                      backgroundColor: Colors.cyan,
                                      radius: 25.0,
                                      child: new Icon(
                                        Icons.camera_alt,
                                        color: Colors.yellowAccent,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ]),
                      )
                    ],
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  color: Color(0xffFFFFFF),
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Thông tin cá nhân',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
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
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 10.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Tên',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    new Text(
                                      username.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 2.0),
                          child: Divider(),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 5.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Gới tính ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: _selectSex()),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 10.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Địa chỉ ',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: addresscontroller,
                                    keyboardType: TextInputType.text,
                                    enabled: !_status,
                                    autofocus: !_status,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 10.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Điên thoại',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: phonecontroller,
                                    keyboardType: TextInputType.number,
                                    enabled: !_status,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 10.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Email',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: emailcontroller,
                                    keyboardType: TextInputType.emailAddress,
                                    enabled: !_status,
                                    autofocus: !_status,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 10.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    new Text(
                                      'Ngày sinh',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: new Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                new Flexible(
                                  child: new TextField(
                                    controller: birthdaycontroller,
                                    keyboardType: TextInputType.datetime,
                                    enabled: !_status,
                                    onTap: () {
                                      DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(1997, 1, 1),
                                          maxTime: DateTime.now(),
                                          onChanged: (date) {
                                        print('change $date');
                                      }, onConfirm: (date) {
                                        String newdate =
                                            new DateFormat("yyyy-MM-dd")
                                                .format(date);
                                        birthdaycontroller.text = newdate;
                                      },
                                          currentTime: DateTime(2000, 01, 01),
                                          locale: LocaleType.vi);
                                    },
                                  ),
                                ),
                              ],
                            )),
                        !_status ? _getActionButtons(iduser) : new Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _selectSex() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                activeColor: Colors.green,
                groupValue: selectedRadio,
                value: 1,
                onChanged: (val) {
                  print(val);
                  setSelectedRadio(val);
                },
              ),
              Text('Nam',
                  style: GoogleFonts.asar(
                    textStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    fontSize: 15,
                  )),
              SizedBox(
                width: 40.0,
              ),
              Radio(
                activeColor: Colors.green,
                groupValue: selectedRadio,
                value: 2,
                onChanged: (val) {
                  print(val);
                  setSelectedRadio(val);
                },
              ),
              Text('Nữ',
                  style: GoogleFonts.asar(
                    textStyle: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                    fontSize: 15,
                  )),
            ],
          ),
        )
      ],
    );
  }

  Widget _getActionButtons(String id) {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 30.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Lưu"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () {
                  setState(() {
                    _update(id);
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Hủy bỏ"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
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
          _status = false;
        });
      },
    );
  }

  showAlert(String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              FlatButton(
                child: Text("Đồng ý"),
                onPressed: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => ProfilePage()));
                },
              )
            ],
          );
        });
  }

  showLoadingProgress() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
                alignment: Alignment.center,
                height: 100,
                width: 100,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                )),
          );
        });
  }
}
