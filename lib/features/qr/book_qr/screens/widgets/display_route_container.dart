import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/shapes/dashed_vertical_line.dart';
import 'package:tsavaari/common/widgets/text/t_section_heading.dart';
import 'package:tsavaari/features/qr/book_qr/models/dummy_platform_info_model.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/display_route.dart';
import 'package:tsavaari/features/qr/display_qr/models/qr_code_model.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class DisplayrouteContainer extends StatelessWidget {
  const DisplayrouteContainer(
      {super.key, required this.tickets, required this.stationList});

  final List<TicketsListModel> tickets;
  final List<StationListModel> stationList;

  @override
  Widget build(BuildContext context) {
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
            platform: 'P${platformInfoData[0]}',
            isInterChange: false),
        PlatformInfoModel(
            stationName: platformInfoData[1],
            color: [
              fromStationData.corridorColor ?? '',
              toStationData.corridorColor ?? ''
            ],
            platform: 'P${platformInfoData[2]}',
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

    return Container(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.md),
        border: Border.all(
          width: 1,
          color: TColors.grey,
        ),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(
                Icons.train_outlined,
                size: TSizes.iconMd,
                color: TColors.dark,
              ),
              TSectionHeading(
                title: TTexts.platformInfo,
                showActionBtn: false,
                textColor: TColors.dark,
                padding: EdgeInsets.only(left: TSizes.xs),
              ),
            ],
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Stack(
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: platFormInfo.length,
                itemBuilder: (context, index) {
                  return DisplayRoute(
                    routeData: platFormInfo[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: TSizes.spaceBtwSections * 1.3,
                  );
                },
              ),
              Positioned(
                top: 35,
                left: 26,
                child: CustomPaint(
                  size: const Size(3, 75),
                  painter: DashedLineVerticalPainter(
                      color: getColor(platFormInfo[0].color[0])),
                ),
              ),
              if (platFormInfo.length > 2)
                Positioned(
                  top: platFormInfo[1].isInterChange ? 140 : 125,
                  left: 26,
                  child: CustomPaint(
                    size: Size(3, platFormInfo[1].isInterChange ? 80 : 75),
                    painter: DashedLineVerticalPainter(
                        color: getColor(platFormInfo[2].color[0])),
                  ),
                ),
            ],
          ),
        ],
      ),
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

  String getPlatform(int index, List<String> platformArray) {
    var platformString = '';
    if (index == 0) {
      platformString = 'P${platformArray[0]}';
    } else if (index == 1) {
      platformString = 'P${platformArray[2]}';
    }
    return platformString;
  }
}
