import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/size_config.dart';

class GateSelector extends StatelessWidget {
  final List<String> gates;
  final int selectedGate;
  final ValueChanged<int> onGateSelected;

  const GateSelector({
    super.key,
    required this.gates,
    required this.selectedGate,
    required this.onGateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding:
            EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 3),
        child: Row(
          children: gates.asMap().entries.map((gate) {
            bool isSelected = selectedGate == gate.key;
            return Padding(
              padding:
                  EdgeInsets.only(right: SizeConfig.blockSizeHorizontal * 5),
              child: InkWell(
                onTap: () => onGateSelected(gate.key),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.blockSizeHorizontal * 5,
                    vertical: SizeConfig.blockSizeVertical * 0.8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? TColors.primary
                        : TColors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? TColors.primary
                          : TColors.grey,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    gate.value,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: isSelected
                          ? TColors.white
                          : TColors.dark,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
