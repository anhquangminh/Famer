import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../animation/FadeAnimation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmer/helper/UserHelper.dart';
import 'package:farmer/provider/UserProvider.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  UserInf userInf;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController newpassword = new TextEditingController();
  TextEditingController repassword = new TextEditingController();

  initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  _changepassword(String iduser) async {
    if (_formKey.currentState.validate()) {
      if (newpassword.text == repassword.text) {
        showLoadingProgress();
        print(iduser+',' +username.text+','+password.text+','+newpassword.text);
        UserHelper.sendChangePassword(_formKey, context, iduser, username.text,
            password.text, newpassword.text);
      } else {
        showAlert('Thông báo', 'Mật khẩu mới không hợp lệ');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    userInf = Provider.of<User>(context).getUserInf();
    String id = userInf.iduser.toString();
    return Scaffold(
      appBar: new AppBar(
        title: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Đổi mật khẩu',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: new Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromRGBO(154, 233, 178, 1),
            Color.fromRGBO(173, 187, 238, 1),
          ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Center(
                child: new Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fill,
                  width: 120.0,
                  height: 120.0,
                ),
              ),
              Center(child: FadeAnimation(1, _logoText())),
              // Center(
              //     child: FadeAnimation(
              //         1.3,
              //         Text(
              //           "Đổi mật khẩu",
              //           style: GoogleFonts.asar(
              //             textStyle: TextStyle(
              //                 color: Colors.white, fontWeight: FontWeight.bold),
              //             fontSize: 23,
              //           ),
              //         ))),
              Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _entryField("Tên đăng nhập ", username, TextInputType.text, 3),
                      _entryField("Mật khẩu", password, TextInputType.text, 5,
                          isPassword: true),
                      _entryField(
                          "Mật khẩu mới", newpassword, TextInputType.text, 5,
                          isPassword: true),
                      _entryField("Nhập lại mật khẩu mới", repassword,
                          TextInputType.text, 5,
                          isPassword: true),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: const Color(0xFFd2b4d7),
                          offset: Offset(2, 2),
                          blurRadius: 5,
                          spreadRadius: 2)
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF4eaec6), Color(0xfff7892b)])),
                child: InkWell(
                  child: Text(
                    'Đổi mật khẩu',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  onTap: () {
                    _changepassword(id);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _logoText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'Fa',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 60,
            fontWeight: FontWeight.w700,
          ),
          children: [
            TextSpan(
              text: 'r',
              style: TextStyle(color: Colors.black, fontSize: 42),
            ),
            TextSpan(
              text: 'me',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 48),
            ),
            TextSpan(
              text: 'r',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 60),
            ),
          ]),
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
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(5.0),
                  ),
                ),
                fillColor: Color(0xfff3f3f4),
                filled: true),
            validator: (value) {
              //check if the username is not less than two characters
              if (value.length < limit) {
                return '$value Chiều dài không đủ';
              } else {
                return null;
              }
            },
          ),
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
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => ChangePassword()));
                },
              )
            ],
          );
        });
  }
}
