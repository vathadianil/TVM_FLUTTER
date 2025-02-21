import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class DottedBorderButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DottedBorderButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);

    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: TSizes.productImageSize / 2.4,
        child: CustomPaint(
          painter: DottedBorderPainter(),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  TImages.cameraIcon,
                  height: screenWidth * .045, 
                  color: TColors.primary
                ),
                const SizedBox(width: TSizes.sm),
                Text(
                  'Add Attachment', 
                  style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: TColors.primary)
                ),
              ],
            ),
        ),
      ),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = TColors.primary
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final double radius = 8.0; // Border radius for rounded corners
    final Path path = Path();

    // Define the rectangle with rounded corners
    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    ));

    // Draw dotted border
    const double dashWidth = 4;
    const double dashSpace = 1;
    double distance = 0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final bool isDash = (distance / (dashWidth + dashSpace)).floor() % 2 == 0;
        if (isDash) {
          canvas.drawPath(
            pathMetric.extractPath(distance, distance + dashWidth),
            paint,
          );
        }
        distance += dashWidth + dashSpace;
      }
      distance = 0; // Reset distance for next side
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
