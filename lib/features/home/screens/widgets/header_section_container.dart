import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/containers/curved_edge_widget.dart';
import 'package:tsavaari/utils/constants/colors.dart';

class HeaderSectionContainer extends StatelessWidget {
  const HeaderSectionContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      child: Container(
        color: TColors.primary,
        padding: const EdgeInsets.all(0),
        child: child,
      ),
    );
  }
}
