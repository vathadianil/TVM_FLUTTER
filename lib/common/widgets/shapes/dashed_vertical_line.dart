import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';

class DashedLineVerticalPainter extends CustomPainter {
  const DashedLineVerticalPainter({this.color = TColors.grey});
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 8, dashSpace = 4, startY = 0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
