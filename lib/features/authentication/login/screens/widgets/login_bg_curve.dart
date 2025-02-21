import 'package:flutter/material.dart';

class LoginBgCurve extends CustomClipper<Path> {
  LoginBgCurve({required this.top, required this.middle, required this.end});

  final double top;
  final double middle;
  final double end;
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.width + top, 0);
    var firstStart = Offset(middle, size.height / 4);
    var firstEnd = Offset(end, size.height);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
