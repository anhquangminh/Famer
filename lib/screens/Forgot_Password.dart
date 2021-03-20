import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../widgets/bezierContainer.dart';
import 'LoginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../animation/FadeAnimation.dart';
import '../model/UserConstructer.dart';
import '../helper/UserHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  DateTime selectedDate = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController phone = new TextEditingController();
  TextEditingController birthday = new TextEditingController();
  TextEditingController email = new TextEditingController();


  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Trở về',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,
      TextInputType keyboardType, int limit,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onTap: () {},
            obscureText: isPassword,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            validator: (value) {
              //check if the username is not less than two characters
              if (value.length < limit) {
                return '$value length not long enough';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _selectDatePicker(String title, TextEditingController controller,
      TextInputType keyboardType,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: isPassword,
            controller: controller,
            keyboardType: keyboardType,
//            initialValue: ("${selectedDate.toLocal()}".split(' ')[0]),
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true),
            onTap: () {
              _selectDate(context);
            },
          )
        ],
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        birthday.text = ("${selectedDate.toLocal()}".split(' ')[0]);
      });
    }
  }

  Widget _submitButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: InkWell(
          child: Text(
            'Lấy lại mật khẩu',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onTap: () {
            _forgot();
          },
        ));
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Đã có tài khoản ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
            child: Text(
              'Đăng nhập',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }

  Widget _logoText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Far',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
//            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'm',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'er',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }


  Widget _emailPasswordWidget() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _entryField("Số điện thoại", phone, TextInputType.phone, 9),
          _entryField("Email", email, TextInputType.emailAddress, 5),
//          Padding(
//              padding: EdgeInsets.only(right: 25.0, top: 10.0,bottom: 10.0),
//              child: new Row(
//                mainAxisSize: MainAxisSize.max,
//                children: <Widget>[
//                  new Column(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    mainAxisSize: MainAxisSize.min,
//                    children: <Widget>[
//                      new Text(
//                        'Birthday',
//                        style: TextStyle(
//                            fontSize: 16.0,
//                            fontWeight: FontWeight.bold),
//                      ),
//                    ],
//                  ),
//                ],
//              )),
//          new TextField(
//            controller: birthday,
//            keyboardType: TextInputType.datetime,
//            decoration: InputDecoration(
//                border: InputBorder.none,
//                fillColor: Color(0xfff3f3f4),
//                filled: true),
//            onTap: () {
//              DatePicker.showDatePicker(context,
//                  showTitleActions: true,
//                  minTime: DateTime(1997, 1, 1),
//                  maxTime: DateTime.now(),
//                  onChanged: (date) {
//                    print('change $date');
//                  }, onConfirm: (date) {
//                    String newdate =
//                    new DateFormat("yyyy-MM-dd")
//                        .format(date);
//                    birthday.text = newdate;
//                  },
//                  currentTime: DateTime(2000, 01, 01),
//                  locale: LocaleType.vi);
//            },
//          ),
        ],
      ),
    );
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
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  var users = new List<UserConstructer>();

  _getUsers() {
    var url = http.get(
        "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getlistuser.php");
    url.then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => UserConstructer.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  _forgot() async {
    if(_formKey.currentState.validate()){
        //showLoadingProgress();
      int dem=0;
        for(int i=0;i<users.length;i++){
          String phone0="0"+users[i].phone;
          print(phone0);
          if(phone0==phone.text && users[i].email==email.text ){
            dem++;
            showAlert('Mật khẩu ', users[i].password);
            break;
          }
        }
       if(dem==0){
         showAlert('Warring', 'Không hợp lệ');
       }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FadeAnimation(
            1.4,
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        ),
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: <Widget>[
                              new Image.asset(
                                'assets/images/logo.png',
                                fit: BoxFit.fill,
                                width: 70.0,
                                height: 70.0,
                              ),
                              _logoText(),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Form(
                              key: _formKey, child: _emailPasswordWidget()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _submitButton(),
                        Expanded(
                          flex: 1,
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _loginAccountLabel(),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton()),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .20,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer())
                ],
              ),
            )),
      ),
    );
  }
}
