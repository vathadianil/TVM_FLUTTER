import 'package:flutter/material.dart';
import 'package:tsavaari/features/authentication/login/screens/widgets/login_bg_curve.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class TClipPath extends StatelessWidget {
  const TClipPath({
    super.key,
    required this.top,
    required this.middle,
    required this.end,
    required this.color,
  });
  final double top;
  final double middle;
  final double end;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: LoginBgCurve(top: top, middle: middle, end: end),
      child: Container(
        height: TDeviceUtils.getScreenHeight(),
        width: TDeviceUtils.getScreenWidth(context),
        color: color,
      ),
    );
  }
}
