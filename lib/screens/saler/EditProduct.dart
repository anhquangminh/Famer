import 'package:farmer/model/ProductModel.dart';
import 'package:farmer/widgets/bezierContainer.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import '../../animation/FadeAnimation.dart';
import 'MyStorePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:farmer/model/GroupConstructer.dart';
import 'package:farmer/helper/ProductHelper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:farmer/model/UserConstructer.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  final String title;

  EditProduct({Key key, this.title, this.product}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productname = new TextEditingController();
  TextEditingController price = new TextEditingController();
  TextEditingController sum = new TextEditingController();
  TextEditingController sale = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController image = new TextEditingController();

  String idgroup = '6';
  String iduser = getIdUser.getid();

  initState() {
    super.initState();
    _getGroup();
  }
  dispose() {
    super.dispose();
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyStorePage()));
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
      TextInputType keyboardType,String hint,
      {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            onTap: () {},
            obscureText: isPassword,
            controller: controller,
            keyboardType: keyboardType,
            maxLines: null,
            decoration: InputDecoration(
                hintText: hint,
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    color: Colors.blue, //this has no effect
                  ),
                ),
                fillColor: Color(0xfff3f3f4),
                filled: true),
            validator: (value) {
              //check if the username is not less than two characters
              if (value.isEmpty) {
                return 'Vui lòng nhập vào';
              } else {
                return null;
              }
            },
          ),
        ],
      ),
    );
  }


  _editing() async {
    if (_formKey.currentState.validate()) {
      showLoadingProgress();
      print(productname.text+price.text+idgroup);
      ProductHelper.sendEditProduct(
          _formKey,
          context,
          widget.product.idproduct,
          productname.text,
          idgroup.toString(),
          price.text,
          sum.text,
          sale.text,
          description.text,
      );
    } else {
      showAlert('Warring !!', 'Please check it again');
    }
  }
  Widget _submitButton() {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
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
            'Cập nhật',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          onTap: () {
            _editing();
          },
        ));
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

  Widget _inputWidget() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _entryField("Tên sản phẩm", productname, TextInputType.text,widget.product.productname),
          _selectGroup(),
          _entryField("Giá", price, TextInputType.number,widget.product.price),
          _entryField("Số lượng ", sum, TextInputType.number,widget.product.sum),
          _entryField("Giảm giá ", sale, TextInputType.number,widget.product.sale),
          _entryField("Mô tả", description, TextInputType.text,widget.product.discription),
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
                  Navigator.pop(context, true);
                },
              )
            ],
          );
        });
  }

  var group = new List<Grourp>();
  Grourp gr;
  _getGroup() {
    var url = http.get(
        "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getproductgroup.php");
    url.then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        group = list.map((model) => Grourp.fromJson(model)).toList();
      });
    });
  }

  _selectGroup() {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            'Nhóm sản phẩm',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 20,
            padding:
            EdgeInsets.only(left: 10, right: 10, top: 5.0, bottom: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0) //         <--- border radius here
              ),
              border: Border.all(
                width: 1.0,
                color: Colors.teal,
              ),
              color: const Color(0xfff3f3f4),
            ),
            child: DropdownButton<Grourp>(
              hint: Text("Chọn nhóm"),
              value: gr,
              onChanged: (Grourp Value) {
                setState(() {
                  gr = Value;
                  idgroup = gr.idgroup;
                });
              },
              items: group.map((Grourp item) {
                return DropdownMenuItem<Grourp>(
                  value: item,
                  child: Row(
                    children: <Widget>[
                      Text(item.idgroup, style: TextStyle(color: Colors.black)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        item.namegroup,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
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
                    padding: EdgeInsets.symmetric(horizontal: 20 ),
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
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  'Cập nhât sản phẩm',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 6,
                          child: Form(key: _formKey, child: _inputWidget()),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: <Widget>[
                              _submitButton(),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(top: 40, left: 0, child: _backButton()),
                  Positioned(
                      top: -MediaQuery.of(context).size.height * .25,
                      right: -MediaQuery.of(context).size.width * .4,
                      child: BezierContainer())
                ],
              ),
            )),
      ),
    );
  }
}
