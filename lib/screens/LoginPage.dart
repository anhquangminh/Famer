/* login page */
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../animation/FadeAnimation.dart';
import '../provider/UserProvider.dart';
import 'RegisterPage.dart';
import 'MainShoppPage.dart';
import 'package:farmer/model/UserConstructer.dart';
import 'Forgot_Password.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(); // the key for the form
  TextEditingController user =
      new TextEditingController(); // the controller for the usename that user will put in the text field
  TextEditingController pass =
      new TextEditingController(); // the controller for the password that user will put in the text field

// show alert function we will use if the user entered a wrong user name or password
  showAlert(String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

// we will use CircularProgressIndicator while logging in
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

  // login function
  _login() async {
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      showAlert('Không có kết nối mạng', "Vui lòng kết nối mạng");
    } else if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      if (_formKey.currentState.validate()) {
        // check if all the conditionsthe we put on validators are right
        showLoadingProgress(); // show CircularProgressIndicator
        // login using user provider

        Provider.of<User>(context, listen: false)
            .loginUserAndGetInf(user.text, pass.text)
            .then((state) {
          // pass username and password that user entered
          UserInf userInf;
          userInf = Provider.of<User>(context, listen: false).getUserInf();
          String iduser = userInf.iduser;
          getIdUser.setid(iduser);
          if (state) {
            // if the function returned true
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainShop()));
            // go to the Mainshop page
          } else {
            showAlert('Error',
                'Bạn đã nhập sai tên đăng nhập hoặc mật khẩu'); // otherwise show an Alert
          }
        });
      }
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromRGBO(154, 233, 178, 1),
          Color.fromRGBO(173, 187, 238, 1),
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: ((MediaQuery.of(context).size.height) / 10),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.fill,
                    width: 120.0,
                    height: 120.0,
                  ),
                  Center(child: FadeAnimation(1, _logoText())),
                  SizedBox(
                    height: 5,
                  ),
                  // Center(
                  //     child: FadeAnimation(
                  //         1.3,
                  //         Text(
                  //           "Xin chào",
                  //           style: GoogleFonts.asar(
                  //             textStyle: TextStyle(
                  //                 color: Colors.white,
                  //                 fontWeight: FontWeight.bold),
                  //             fontSize: 20,
                  //           ),
                  //         ))),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
//                    gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
//                      Color.fromRGBO(178, 212, 187, 1),
//                      Color.fromRGBO(247, 251, 248, 1),
//                    ])
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, top: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 35,
                        ),
                        FadeAnimation(
                            1.5,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: user,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.person),
                                            hintText: "Tên đăng nhập ",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          //check if the username is not less than two characters
                                          if (value.length < 2) {
                                            return '$value Chiều dài không đủ dài';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        controller: pass,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                            icon: Icon(Icons.vpn_key),
                                            hintText: "Mật khẩu ",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        validator: (value) {
                                          //check if the username is not less than two characters
                                          if (value.length < 6) {
                                            return 'Chiều dài không đủ dài';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerRight,
                                        padding: EdgeInsets.all(15),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey[200]))),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ForgotPassword()));
                                          },
                                          child: Text('Quên mật khẩu ?',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.w500)),
                                        )),
                                  ],
                                ),
                              ),
                            )),
                        FadeAnimation(
                          1.5,
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: _createAccountLabel(),
                          ),
                        ),
                        FadeAnimation(
                            1.5,
                            Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1, color: const Color(0xFFe2fbfb)),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color.fromRGBO(154, 235, 178, 1)),
                              child: Center(
                                child: FlatButton(
                                    child: Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    onPressed: () {
                                      // when we press this button excute login function
                                      _login();
                                    }),
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Không có tài khoản',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterPage()));
            },
            child: Text(
              'Tạo tài khoản',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
