import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/dropdown/t_dropdown.dart';
import 'package:tsavaari/features/station_facilities/controllers/station_facilities_controller.dart';
import 'package:tsavaari/utils/constants/size_config.dart';
import 'package:tsavaari/utils/loaders/shimmer_effect.dart';

class StationSelectionDropDown extends StatelessWidget {
  const StationSelectionDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final stationFacilitiesController = StationFacilitiesController.instance;

    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeHorizontal * 5,
          right: SizeConfig.blockSizeHorizontal * 5,
          left: SizeConfig.blockSizeHorizontal * 5,
          bottom: SizeConfig.blockSizeHorizontal * 2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Station',
              style: Theme.of(Get.context!)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 1),
            if (stationFacilitiesController.isLoading.value)
              const ShimmerEffect(
                width: double.infinity,
                height: 50,
              )
            else
              TDropdown(
                items: stationFacilitiesController.stationList
                    .map((item) => item.station!)
                    .toSet()
                    .toList()
                  ..sort(),
                labelText:
                    stationFacilitiesController.isNearestStationLoading.value
                        ? 'Finding nearest station...'
                        : 'Select Station',
                value: stationFacilitiesController.stationName.value,
                onChanged: (String? newValue) {
                  // Set the selected station name
                  stationFacilitiesController.stationName.value = newValue;

                  // Find the selected station object by name and retrieve its stnId
                  final selectedStation =
                      stationFacilitiesController.stationList.firstWhereOrNull(
                          (station) => station.station == newValue);

                  // Call getMetroStationFacilitiesServices() with the selected station's stnId
                  if (selectedStation != null) {
                    stationFacilitiesController
                        .getMetroStationFacilitiesServices(
                            selectedStation.stnId);
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^[a-zA-Z0-9\s]*$')), // Allow letters, numbers, and spaces
                ],
                enabled:
                    !stationFacilitiesController.isNearestStationLoading.value,
              ),
          ],
        ),
      ),
    );
  }
}
