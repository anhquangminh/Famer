import 'dart:async';
import 'package:flutter/material.dart';
import 'package:farmer/widgets/customRaisedButton.dart';
import 'onboarding1.dart';
import 'onboarding3.dart';

class Onboarding2 extends StatefulWidget {
  @override
  _Onboarding2State createState() => _Onboarding2State();
}

class _Onboarding2State extends State<Onboarding2>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  Animation<double> topbg;
  Animation<double> title;
  Animation<double> desc;
  Animation<double> bottomBgDx, bottomBgDy, btndy, btndy2;
  Animation<double> indicator1, indicator2, indicator3;

  void keOnboarding3() {
    animationController.reverse();
    Timer(
      Duration(milliseconds: 500),
      () => Navigator.of(context).pushReplacement(new PageRouteBuilder(
          pageBuilder: (BuildContext context, _, __) {
        return new Onboarding3();
      }, transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
        return new FadeTransition(opacity: animation, child: child);
      })),
    );
  }

  void keOnboarding1() {
    animationController.reverse();
    Timer(
      Duration(milliseconds: 500),
      () => Navigator.of(context).pushReplacement(new PageRouteBuilder(
          pageBuilder: (BuildContext context, _, __) {
        return new Onboarding1();
      }, transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
        return new FadeTransition(opacity: animation, child: child);
      })),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() => setState(() {}));

    animation = Tween<double>(
      begin: 0.0,
      end: 300.0,
    ).animate((CurvedAnimation(
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController)));

    title = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    desc = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.9, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    bottomBgDx = Tween<double>(
      begin: -150.0,
      end: -50.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.3, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    bottomBgDy = Tween<double>(
      begin: 100.0,
      end: 10.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.3, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    btndy = Tween<double>(
      begin: 100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    btndy2 = Tween<double>(
      begin: 100.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    topbg = Tween<double>(
      begin: -250.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    indicator1 = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    indicator2 = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    indicator3 = Tween<double>(
      begin: 50.0,
      end: 0.0,
    ).animate(CurvedAnimation(
        curve: Interval(0.6, 1.0, curve: Curves.fastOutSlowIn),
        parent: animationController));

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          //framebottom
          Positioned(
              bottom: 0,
              child: Transform.translate(
                offset: Offset(this.bottomBgDx.value, this.bottomBgDy.value),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  color: Colors.transparent,
                  child: Image.asset("assets/bottombg2.png"),
                ),
              )),

          //title    
          Positioned(
              top: 100,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.height / 24),
                width: MediaQuery.of(context).size.width,
                child: Center(
                    child: Text("Thanh toán trực tuyến dễ dàng",
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(
                                64, 74, 105, this.title.value)))),
              )),

          //indicator    
          Positioned(
            bottom: 40,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(0.0, this.indicator1.value),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(105, 133, 148, 1),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Transform.translate(
                    offset: Offset(0.0, this.indicator2.value),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(127, 71, 255, 1.0),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Transform.translate(
                    offset: Offset(0.0, this.indicator3.value),
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(105, 133, 148, 1),
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
            ),
          ),

          //button previus
          Positioned(
              bottom: 20,
              left: 20,
              child: Transform.translate(
                offset: Offset(0.0, this.btndy2.value),
                child: RaisedGradientButton(
                    radius: 55.0,
                    width: 55.0,
                    height: 55.0,
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 25,
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromRGBO(167, 133, 246, 1.0),
                        Color.fromRGBO(127, 71, 255, 1.0)
                      ],
                    ),
                    onPressed: () {
                      keOnboarding1();
                    }),
              )),
          
          //button next
          Positioned(
              bottom: 20,
              right: 20,
              child: Transform.translate(
                offset: Offset(0.0, this.btndy.value),
                child: RaisedGradientButton(
                    radius: 55.0,
                    width: 55.0,
                    height: 55.0,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 25,
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromRGBO(167, 133, 246, 1.0),
                        Color.fromRGBO(127, 71, 255, 1.0)
                      ],
                    ),
                    onPressed: () {
                      keOnboarding3();
                    }),
              )),

          //image center    
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                    width: this.animation.value,
                    height: this.animation.value,
                    child: Image.asset("assets/card.png")),
                SizedBox(height: 32),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height / 15),
                  child: Center(
                      child: Text(
                    "Thanh toán khi nhận hàng và kiểm tra chất lượng.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(105, 133, 148, this.desc.value)),
                  )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height / 12),
                  child: Center(
                      child: Text(
                        "Dễ dàng và thuận tiện",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(105, 133, 148, this.desc.value)),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),

      /*
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          keOnboarding3();
        },
        backgroundColor: Color.fromRGBO(127, 71, 255, 1.0),
        child: Text("Next"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      */
    );
  }
}
