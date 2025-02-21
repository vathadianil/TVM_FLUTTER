import 'package:flutter/material.dart';

class TicketShapeClipper extends CustomClipper<Path> {
  final offset = 15;
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, (size.height / 2) - offset)
      ..quadraticBezierTo(
          size.width * 0.10, size.height / 2, 0, size.height / 2 + offset)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, size.height / 2 + offset)
      ..quadraticBezierTo(size.width * 0.90, size.height / 2, size.width,
          size.height / 2 - offset)
      ..lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
