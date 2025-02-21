import 'dart:math';
import 'package:flutter/material.dart';

class TextScaleUtil {
  static TextScaler getScaledText(BuildContext context, {double maxScale = 2}) {
    return TextScaler.linear(
      ScaleSize.textScaleFactor(context, maxTextScaleFactor: maxScale),
    );
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
