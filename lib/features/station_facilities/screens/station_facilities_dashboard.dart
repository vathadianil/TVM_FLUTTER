import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/home/screens/widgets/header_section_container.dart';
import 'package:tsavaari/features/station_facilities/controllers/station_facilities_controller.dart';
import 'package:tsavaari/features/station_facilities/models/station_facilities_services_model.dart';
import 'package:tsavaari/features/station_facilities/screens/widgets/floating_action_btn.dart';
import 'package:tsavaari/features/station_facilities/screens/widgets/loader.dart';
import 'package:tsavaari/features/station_facilities/screens/widgets/near_by_facility_card.dart';
import 'package:tsavaari/features/station_facilities/screens/widgets/station_facility_card.dart';
import 'package:tsavaari/features/station_facilities/screens/widgets/station_selection.dart';
import 'package:tsavaari/routes/routes.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/size_config.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class StationFacilitiesScreen extends GetView<StationFacilitiesController> {
  final StationFacilitiesController controller = Get.put(StationFacilitiesController());
  
  StationFacilitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      body: _buildUI(context),
      floatingActionButton: const FloatingActionBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }

  Widget _buildUI(BuildContext context) {
    return Column(
      children: [
        const HeaderSectionContainer(
          child: Image(
            image: AssetImage(TImages.stationFaciliteisHeroImg),
          ),
        ),
        Obx(() {
          if (controller.isNearestStationLoading.value) {
            return const StationLoader();
          } else {
            return const StationSelectionDropDown();
          }
        }),

        _buildMetroStationFacilities(context),

        // Obx(() {
        //   if (controller.nearestStation.value != null ) { ///Issue here
        //     return _buildMetroStationFacilities(context);
        //   } else {
        //     return const SizedBox();
        //   }
        // }),
      ],
    );
  }

  Widget _buildMetroStationFacilities(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.stationFacilities.isEmpty) {
          return const Center(
            child: Text(''),
            //child: Text('No facilities available for the selected station.'),
          );
        }

        // Separate facilities by type
        final dialogFacilities = controller.stationFacilities
            .where((facility) => _isDialogFacility(facility))
            .toList();
        final screenFacilities = controller.stationFacilities
            .where((facility) => !_isDialogFacility(facility))
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Near by Facilities', context),
            _buildHorizontalList(screenFacilities, context),
            _buildSectionTitle('Station Facilities', context),
            Expanded(child: _buildVerticalList(dialogFacilities, context)),
          ],
        );
      }),
    );
  }

  Widget _buildHorizontalList(List<Facility> facilities, BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 16,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 5,
          vertical: SizeConfig.blockSizeHorizontal * 2,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: facilities.length,
        separatorBuilder: (_, __) =>
            SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
        itemBuilder: (context, index) {
          Facility facility = facilities[index];
          return NearByFacilityCard(
            // color: _getFacilityColor(facility.facilityCode!),
            icon: facility.facilityIconPath!,
            label: facility.facilityName!,
            onTap: () {
              _handleNavigation(facility, context);
            },
          );
        },
      ),
    );
  }

  // Define a method to map facility codes to colors
  // Color _getFacilityColor(String facilityCode) {
  //   // Define custom colors for specific facility codes
  //   final colorMap = {
  //     'SHUTTLE': AppColors.lightPurpleColor,
  //     'TIMINGS': AppColors.creamColor,
  //     'PARKING': AppColors.lightBlueColor,
  //     'PLATFORM': AppColors.lightPinkColor,
  //     'WIFI': AppColors.lightPurpleColor2,
  //     'LMC': AppColors.lightPinkColor,
  //     'BUSSTOP': AppColors.lightBeigeColor1,
  //     'NEIGHBOURHOOD': AppColors.darkBeigeColor,
  //     'CATCHMENT': AppColors.lightBeigeColor,
  //   };
  // // Default color if facilityCode is not in the map
  // const defaultColor = AppColors.lightBeige;
  // // Return the color for the given facilityCode or the default color
  // return colorMap[facilityCode] ?? defaultColor;
}

Widget _buildVerticalList(List<Facility> facilities, BuildContext context) {
  return ListView.separated(
    itemCount: facilities.length,
    padding: EdgeInsets.symmetric(
      horizontal: SizeConfig.blockSizeHorizontal * 5,
      vertical: SizeConfig.blockSizeHorizontal * 2,
    ),
    separatorBuilder: (_, __) =>
        SizedBox(height: SizeConfig.blockSizeVertical * 2),
    itemBuilder: (context, index) {
      Facility facility = facilities[index];
      return StationFacilityCard(
        icon: facility.facilityIconPath!,
        label: facility.facilityName!,
        content: facility.facilityContent!,
        // onTap: () {
        //   StationFacilitiesDialog.showCustomDialog(context, facility);
        // },
      );
    },
  );
}

bool _isDialogFacility(Facility facility) {
  const dialogCodes = [
    'LIFTS',
    'TOILET',
    'FIRSTAID',
    'WATER',
    'EMERGENCY',
    'ESCALATOR',
    'ATM',
    'EV CHARGING',
    'MMTS',
    'STAIR CASES',
  ];
  return dialogCodes.contains(facility.facilityCode);
}

void _handleNavigation(Facility facility, BuildContext context) {
  if (facility.facilityCode == 'SHUTTLE' ||
      facility.facilityCode == 'TIMINGS' ||
      facility.facilityCode == 'PARKING' ||
      facility.facilityCode == 'PLATFORM' ||
      facility.facilityCode == 'WIFI' ||
      facility.facilityCode == 'LMC') {
    Get.toNamed(
      Routes.webViewScreen,
      arguments: {
        'contentUrl': facility.facilityContentUrl,
        'facilityContent': facility.facilityContent,
        'facilityName': facility.facilityName,
      },
    );
  } else if (facility.facilityCode == 'BUSSTOP') {
    if (facility.busStop!.isNotEmpty) {
      Get.toNamed(
        Routes.busStopPage,
        arguments: {
          'facilityName': facility.facilityName,
          'busStops': facility.busStop,
          'isActive': facility.isActive,
        },
      );
    } else {
      TLoaders.warningSnackBar(title: '', message: 'No Data Available');
    }
  } else if (facility.facilityCode == 'NEIGHBOURHOOD') {
    if (facility.neighbourhood!.isNotEmpty) {
      Get.toNamed(
        Routes.neighbourhoodAreasPage,
        arguments: {
          'facilityName': facility.facilityName,
          'neighbourhood': facility.neighbourhood,
          'isActive': facility.isActive,
        },
      );
    } else {
      TLoaders.warningSnackBar(title: '', message: 'No Data Available');
    }
  } else if (facility.facilityCode == 'CATCHMENT') {
    if (facility.catchment!.isNotEmpty) {
      Get.toNamed(
        Routes.impCatchmentAreaPage,
        arguments: {
          'facilityName': facility.facilityName,
          'catchment': facility.catchment,
          'isActive': facility.isActive,
        },
      );
    } else {
      TLoaders.warningSnackBar(title: '', message: 'No Data Available');
    }
  }
}

Widget _buildSectionTitle(String title, context) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: SizeConfig.blockSizeVertical * 1,
      horizontal: SizeConfig.blockSizeHorizontal * 5,
    ),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    ),
  );
}
