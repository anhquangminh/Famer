import 'package:flutter/material.dart';

class RaisedGradientButton extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double width;
  final double height;
  final Function onPressed;
  final double border;
  final double radius;

  const RaisedGradientButton({
    Key key,
    @required this.child,
    this.gradient,
    this.width = double.infinity,
    this.height = 50.0,
    this.onPressed,
    this.border,
    this.radius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(
          width: border == null ? 0 : border,
          color: Color.fromRGBO(127, 71, 255, 1.0),
          ),
        borderRadius: BorderRadius.circular(radius == null ? 5.0 : radius),
        gradient: gradient, boxShadow: [
        
      ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius == null ? 5.0 : radius),
            onTap: onPressed,
            child: Center(
              child: child,
            )),
      ),
    );
  }
}