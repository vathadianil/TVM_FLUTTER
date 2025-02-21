import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/size_config.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class NearByFacilityCard extends StatelessWidget {
  const NearByFacilityCard({
    super.key,
    required this.icon,
    required this.label,
    this.color,
    required this.onTap,
  });

  final String icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: SizeConfig.blockSizeVertical * 6,
            width: SizeConfig.blockSizeVertical * 6,
            decoration: BoxDecoration(
              color: TColors.white,
              borderRadius:
                  BorderRadius.circular(SizeConfig.blockSizeVertical * 6),
              boxShadow: [
                BoxShadow(
                  color: isDark ? TColors.info : TColors.accent,
                  blurRadius: TSizes.md,
                  offset: const Offset(0, TSizes.sm),
                ),
              ],
            ),
            padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 1.5),
            child: Image.network(
              icon,
              height: SizeConfig.blockSizeVertical * 3,
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1.2),
          SizedBox(
            width: SizeConfig.blockSizeVertical *
                9, // Set width to control wrapping
            child: Text(
              label,
              maxLines: 2, // Allows up to two lines
              overflow: TextOverflow
                  .ellipsis, // Adds ellipsis if text exceeds max lines
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
