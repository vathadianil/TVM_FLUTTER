import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/common/widgets/images/rounded_corner_image.dart';
import 'package:tsavaari/common/widgets/shapes/circle_shape.dart';
import 'package:tsavaari/features/qr/book_qr/models/dummy_platform_info_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
// import 'package:tsavaari/utils/helpers/helper_functions.dart';

class DisplayRoute extends StatelessWidget {
  const DisplayRoute({
    super.key,
    required this.routeData,
  });

  final PlatformInfoModel routeData;

  @override
  Widget build(BuildContext context) {
    return TCircularContainer(
      width: double.infinity,
      radius: TSizes.sm,
      height: routeData.isInterChange ? 70 : 50,
      boxShadow: getBoxShadow(routeData.color),
      applyBoxShadow: true,
      child: ListTile(
        leading: routeData.isInterChange
            ? const RoundedCornerImage(
                imageUrl: TImages.interChangeIcon,
                isNetworkImage: false,
                width: 20,
                height: 20,
                // applyImageColor: true,
                padding: EdgeInsets.all(2),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    width: 2,
                  ),
                  CircleShape(
                    borderWidth: 2,
                    fillColor: getColor(routeData.color[0]),
                    darkModeBorderColor: getColor(routeData.color[0]),
                    lightModeBorderColor: getColor(routeData.color[0]),
                  ),
                ],
              ),
        title: Text(
          routeData.stationName ?? '',
          textScaler: TextScaleUtil.getScaledText(context, maxScale: 2.5),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.dark),
          maxLines: 1,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: routeData.isInterChange
            ? Text(
                TTexts.interchageText,
                textScaler: TextScaleUtil.getScaledText(context, maxScale: 2.5),
                style: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: TColors.dark),
              )
            : null,
        trailing: Text(
          routeData.platform,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: TColors.dark),
        ),
      ),
    );
  }

  List<BoxShadow> getBoxShadow(List<String> color) {
    if (color.length == 1) {
      if (color[0] == 'Blue') {
        return const [
          BoxShadow(
            color: TColors.primary,
            blurRadius: TSizes.sm,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ];
      } else if (color[0] == 'Red') {
        return const [
          BoxShadow(
            color: TColors.error,
            blurRadius: TSizes.sm,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ];
      } else if (color[0] == 'Green') {
        return const [
          BoxShadow(
            color: TColors.success,
            blurRadius: TSizes.sm,
            spreadRadius: 2,
            offset: Offset(0, 0),
          ),
        ];
      }
    } else {
      return [
        BoxShadow(
          color: color[0] == 'Blue'
              ? TColors.primary
              : color[0] == 'Red'
                  ? TColors.error
                  : TColors.success,
          blurRadius: TSizes.sm,
          offset: const Offset(-3, -3),
        ),
        BoxShadow(
          color: color[1] == 'Blue'
              ? TColors.primary
              : color[1] == 'Red'
                  ? TColors.error
                  : TColors.success,
          blurRadius: TSizes.sm,
          offset: const Offset(2, 2),
        ),
      ];
    }
    return const [
      BoxShadow(
        color: TColors.primary,
        blurRadius: TSizes.sm,
        offset: Offset(0, 0),
      ),
    ];
  }

  Color getColor(String color) {
    if (color == 'Red') {
      return TColors.error;
    } else if (color == 'Blue') {
      return TColors.primary;
    } else if (color == 'Green') {
      return TColors.success;
    }
    return Colors.transparent;
  }
}
