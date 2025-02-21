import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';

class DashedLine extends StatelessWidget {
  final double length; // Length of the line
  final double thickness; // Thickness of the dashes
  final Color color;
  final double verticalDashHeight; // Dash height for vertical lines
  final double horizontalDashWidth; // Dash width for horizontal lines
  final double dashSpace; // Space between dashes
  final bool isVertical; // Orientation of the dashed line

  const DashedLine({
    super.key,
    required this.length,
    this.thickness = 2,
    this.color = TColors.grey,
    this.verticalDashHeight = 5,
    this.horizontalDashWidth = 5,
    this.dashSpace = 5,
    this.isVertical = true, // true for vertical, false for horizontal
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isVertical ? thickness : length,
      height: isVertical ? length : thickness,
      child: CustomPaint(
        painter: DashedLinePainter(
          dashHeight: isVertical ? verticalDashHeight : thickness,
          dashWidth: isVertical ? thickness : horizontalDashWidth,
          dashSpace: dashSpace,
          color: color,
          isVertical: isVertical,
        ),
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final double dashHeight;
  final double dashWidth;
  final double dashSpace;
  final Color color;
  final bool isVertical;

  DashedLinePainter({
    required this.dashHeight,
    required this.dashWidth,
    required this.dashSpace,
    required this.color,
    required this.isVertical,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    if (isVertical) {
      double startY = 0;

      while (startY < size.height) {
        canvas.drawRect(
          Rect.fromLTWH(0, startY, dashWidth, dashHeight),
          paint,
        );
        startY += dashHeight + dashSpace; // Move to the next dash position
      }
    } else {
      double startX = 0;

      while (startX < size.width) {
        canvas.drawRect(
          Rect.fromLTWH(startX, 0, dashWidth, dashHeight),
          paint,
        );
        startX += dashWidth + dashSpace; // Move to the next dash position
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

///Use Case...

// DashedLine(length: 200, thickness: 2, isVertical: true, verticalDashHeight: 10);

// DashedLine(length: 200, thickness: 2, isVertical: false, horizontalDashWidth: 15);
