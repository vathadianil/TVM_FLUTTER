import 'package:flutter/material.dart';

class OneDirectionScrollPhysics extends ScrollPhysics {
  final bool allowLeftToRight; // Set true to allow left-to-right swipe only

  const OneDirectionScrollPhysics(
      {this.allowLeftToRight = false, super.parent});

  @override
  OneDirectionScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return OneDirectionScrollPhysics(
      allowLeftToRight: allowLeftToRight,
      parent: buildParent(ancestor),
    );
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    if ((allowLeftToRight && offset < 0) || (!allowLeftToRight && offset > 0)) {
      return 0; // Prevent movement in the disallowed direction
    }
    return offset;
  }
}
