import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/station_facilities/screens/4_bus_stop/widgets/gate_selector_botton.dart';
import 'package:tsavaari/features/station_facilities/screens/8_neighbourhood_area/controller/neighbourhood_controller.dart';
import 'package:tsavaari/features/station_facilities/screens/widgets/dashed_line.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/size_config.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NeighbourhoodAreasScreen extends StatelessWidget {
  NeighbourhoodAreasScreen({super.key});
  final _controller = Get.put(NeighbourhoodController());
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      // backgroundColor: AppColors.whiteColor,
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          _controller.title.value,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.white),
        ),
      ),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.blockSizeHorizontal * 5,
        vertical: SizeConfig.blockSizeVertical * 2,
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(_controller.title.value,
            //     style: AppTextStyle.commonTextStyle4()
            //         .copyWith(color: AppColors.tertiaryColor)),
            _buildGateSelector(),
            const DashedLine(
                length: double.infinity,
                isVertical: false,
                thickness: 1.5,
                horizontalDashWidth: 4),
            _buildAreasList(
                _controller.totalNeighoodPlaces[_controller.selectedGate.value]
                    .split(','),
                context),
          ],
        ),
      ),
    );
  }


  Widget _buildAreasList(List<String> neighbourhoodArea, context) {
    return Expanded(
      child: ListView.separated(
        itemCount: neighbourhoodArea.length,
        separatorBuilder: (_, __) => const DashedLine(
            length: double.infinity,
            isVertical: false,
            thickness: 1.5,
            horizontalDashWidth: 4),
        itemBuilder: (_, index) {
          final location = neighbourhoodArea[index];
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.blockSizeVertical * 1.5),
            child: Row(
              children: [
                Text(
                  '${index + 1}. ',
                  style: Theme.of(context).textTheme.bodyLarge,
                  // style: AppTextStyle.commonTextStyle10()
                  //     .copyWith(color: AppColors.greyColor),
                ),
                SizedBox(
                  width: TDeviceUtils.getScreenWidth(context) * .8,
                  child: Text(
                    location,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGateSelector() {
    return Obx(() => GateSelector(
          gates: _controller.totalArms,
          selectedGate: _controller.selectedGate.value,
          onGateSelected: (gate) {
            _controller.updateGate(gate);
          },
        ));
  }
}
