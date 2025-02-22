import 'package:flutter/material.dart';
// import 'package:tsavaari/common/styles/app_style.dart';
// import 'package:tsavaari/utils/constants/color.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/size_config.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class StationFacilityCard extends StatelessWidget {
  final String icon;
  final String label;
  final String content;
  final VoidCallback? onTap;

  const StationFacilityCard({
    super.key,
    required this.icon,
    required this.label,
    required this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isDark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isDark ? TColors.dark : TColors.white,
            borderRadius: BorderRadius.circular(TSizes.md),
            boxShadow: [
              BoxShadow(
                  color: isDark ? TColors.darkGrey : TColors.grey,
                  blurRadius: TSizes.md)
            ]),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeHorizontal * 3),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: TColors.white,
            backgroundImage: NetworkImage(
              icon,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(
              bottom: TSizes.spaceBtwItems / 2,
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          dense: true,
          subtitle: Text(
            content,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
