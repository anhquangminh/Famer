import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../animation/FadeAnimation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  initState() {
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Thông tin',
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
          padding: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Color.fromRGBO(154, 233, 178, 1),
            Color.fromRGBO(173, 187, 238, 1),
          ])),
          child: Column(
            children: <Widget>[
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
                    Center(
                        child: FadeAnimation(
                            1.3,
                            Text(
                              "Ứng dụng giới thiệu và kinh doanh nông sản sạch ",
                              style: GoogleFonts.asar(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                fontSize: 16,
                              ),
                            ))),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: FadeAnimation(
                          1.2,
                          Text(
                              'Cuộc sống ngày càng được nâng cao cả về chất lượng, cho nên nhu cầu tìm hiểu nguồn gốc, xuất xứ, chất lượng hàng hóa thực phẩm của người tiêu dùng ngày càng khắt khe hơn. Hiện nay hình thức “đi chợ online” đang được nhiều người tìm đến. Ưu điểm của hình thức này là tiết kiệm được thời gian đi lại, nhanh chóng và tiện lợi.',
                              style: GoogleFonts.lato(fontSize: 15))),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: FadeAnimation(
                          1.2,
                          Text(
                              '- Tiết kiệm chi phí một cách tối đa mà lại có thể tư vấn trao đổi thông tin cho khách hàng một cách chi tiết và tỉ mỉ nhất.',
                              style: GoogleFonts.lato(fontSize: 15))),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: FadeAnimation(
                          1.2,
                          Text(
                              '- Có thêm nhiều khách hàng mới, làm thỏa mãn cả những khách hàng khó tính nhất.',
                              style: GoogleFonts.lato(fontSize: 15))),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: FadeAnimation(
                          1.2,
                          Text(
                              '- Tạo ra hình ảnh nông sản hộ gia đình được tổ chức khoa học và hiệu quả.',
                              style: GoogleFonts.lato(fontSize: 15))),
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      child: FadeAnimation(
                          1.2,
                          Text(
                              '- Giải quyết được bài toán được mùa mất giá cho người nông dân.',
                              style: GoogleFonts.lato(fontSize: 15))),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: FadeAnimation(
                          1.2,
                          Text(
                              '- Giúp cho nông sản được tiêu thụ nội địa dễ dàng hơn.',
                              style: GoogleFonts.lato(fontSize: 15))),
                    ),
                    Center(child: FadeAnimation(1.2, Text('Degin by Hien Nguyen', style: GoogleFonts.lato()))),
                    Center(child: FadeAnimation(1.2, Text('Hotline: 0976235813', style: GoogleFonts.lato()))),
                  ],
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
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
          children: [
            TextSpan(
              text: 'r',
              style: TextStyle(color: Colors.black, fontSize: 32),
            ),
            TextSpan(
              text: 'me',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 38),
            ),
            TextSpan(
              text: 'r',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }
}
