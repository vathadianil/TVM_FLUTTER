import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/common/widgets/images/rounded_corner_image.dart';
import 'package:tsavaari/features/qr/book_qr/models/dummy_platform_info_model.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class PlatformInfoContainer extends StatelessWidget {
  const PlatformInfoContainer(
      {super.key, required this.tickets, required this.stationList});

  final List<TicketsListModel> tickets;
  final List<StationListModel> stationList;

  @override
  Widget build(BuildContext context) {
    final screenHeight = TDeviceUtils.getScreenHeight();
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final platformInfoData = tickets[0].platFormNo!.split(',');
    var platFormInfo = [];

    StationListModel fromStationData;
    StationListModel toStationData;
    if (tickets[0].fromStation != null) {
      fromStationData = THelperFunctions.getStationFromStationName(
          tickets[0].fromStation!, stationList);
    } else {
      fromStationData = THelperFunctions.getStationFromStationId(
          tickets[0].fromStationId!, stationList);
    }

    if (tickets[0].toStation != null) {
      toStationData = THelperFunctions.getStationFromStationName(
          tickets[0].toStation!, stationList);
    } else {
      toStationData = THelperFunctions.getStationFromStationId(
          tickets[0].toStationId!, stationList);
    }
    if (platformInfoData.length == 3) {
      platFormInfo = [
        PlatformInfoModel(
            stationName: fromStationData.name,
            color: [fromStationData.corridorColor ?? ''],
            platform: 'P${platformInfoData[0].trim()}',
            isInterChange: false),
        PlatformInfoModel(
            stationName: platformInfoData[1],
            color: [
              fromStationData.corridorColor ?? '',
              toStationData.corridorColor ?? ''
            ],
            platform: 'P${platformInfoData[2].trim()}',
            isInterChange: true),
        PlatformInfoModel(
            stationName: toStationData.name,
            color: [toStationData.corridorColor ?? ''],
            platform: '',
            isInterChange: false)
      ];
    } else {
      platFormInfo = [
        PlatformInfoModel(
            stationName: fromStationData.name,
            color: [fromStationData.corridorColor ?? ''],
            platform: 'P${platformInfoData[0]}',
            isInterChange: false),
        PlatformInfoModel(
            stationName: toStationData.name,
            color: [toStationData.corridorColor ?? ''],
            platform: '',
            isInterChange: false)
      ];
    }
    return SizedBox(
      height: screenHeight * .095,
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: screenWidth * .02,
                ),
                TCircularContainer(
                  applyBoxShadow: true,
                  boxShadow: getBoxShadow(platFormInfo[index].color),
                  width: screenWidth * .07,
                  height: screenWidth * .07,
                  radius: screenWidth * .07,
                  child: Center(
                    child: platFormInfo[index].isInterChange
                        ? RoundedCornerImage(
                            imageUrl: TImages.interChangeIcon,
                            isNetworkImage: false,
                            width: screenWidth * .05,
                            height: screenWidth * .05,
                            padding: const EdgeInsets.all(2),
                          )
                        : Icon(
                            Iconsax.location_tick5,
                            size: screenWidth * .04,
                            color: getColor(
                              platFormInfo[index].color[0],
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: screenWidth * .02,
                ),
                Text(
                  platFormInfo[index]
                          .stationName
                          .trim()
                          .replaceFirst(' ', '\n') ??
                      '',
                  textAlign: TextAlign.center,
                  textScaler:
                      TextScaleUtil.getScaledText(context, maxScale: 2.5),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: TColors.dark),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Column(
              children: [
                Text(
                  platFormInfo[index].platform,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: platFormInfo[index].platform == 'P1'
                          ? TColors.thickYellow
                          : platFormInfo[index].platform == 'P2'
                              ? TColors.megenta
                              : TColors.dark,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                    width: platFormInfo.length > 2
                        ? screenWidth * 0.1
                        : screenWidth * 0.2,
                    child: Icon(
                      Iconsax.arrow_right_14,
                      size: screenWidth * 0.06,
                      color: getColor(
                        platFormInfo[index + 1].color[0],
                      ),
                    )),
              ],
            );
          },
          itemCount: platFormInfo.length),
    );
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
}
