import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/bezierContainer.dart';
import 'LoginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../animation/FadeAnimation.dart';
import '../model/UserConstructer.dart';
import '../helper/UserHelper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  DateTime selectedDate = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repassword = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  TextEditingController birthday = new TextEditingController();
  int selectedRadio = 1;

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

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
            'Tạo tài khoản',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onTap: () {
            _register();
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
            'Bạn đã có tài khoản ?',
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

  Widget _selectSex() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 10,
        ),
        Text('Giới tính',
            style: GoogleFonts.asar(
              textStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              fontSize: 15,
            )),
        Container(
          color: Colors.pink[50],
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

  Widget _emailPasswordWidget() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _entryField("Tên đăng nhập", username, TextInputType.text, 3),
          _entryField("Mật khẩu", password, TextInputType.text, 5,
              isPassword: true),
          _entryField("Nhập lại mật khẩu", repassword, TextInputType.text, 5,
              isPassword: true),
          _selectSex(),
          _selectDatePicker("Ngày sinh", birthday, TextInputType.datetime),
          _entryField("Email", email, TextInputType.emailAddress, 5),
          _entryField("Điện thoại", phone, TextInputType.phone, 9),
          _entryField("Địa chỉ", address, TextInputType.text, 6),
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
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) => RegisterPage()));
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

  _register() async {
    if(_formKey.currentState.validate()){
      if(password.text==repassword.text){
        showLoadingProgress();
        int dem=0;
        for (int i = 0; i < users.length; i++) {
          if(users[i].username==username.text){
            dem++;
          }
        }
        print(dem);
        if(dem==0){
          UserHelper.sendRegister(
              _formKey,
              context,
              username.text,
              password.text,
              email.text,
              address.text,
              phone.text,
              birthday.text,
              selectedRadio.toString());
        }else{
          showAlert('Thông báo ', 'Tài khoản đã tồn tại!');
        }
      }else{
        showAlert('Thông báo', 'Mật khẩu lỗi định dạng!');
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
