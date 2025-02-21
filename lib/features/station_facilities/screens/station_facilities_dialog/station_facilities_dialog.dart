// custom_dialog_helper.dart
import 'package:flutter/material.dart';
import 'package:tsavaari/features/station_facilities/models/station_facilities_services_model.dart';
import 'package:tsavaari/features/station_facilities/screens/station_facilities_dialog/widgets/station_facility_dialog_widget.dart';

class StationFacilitiesDialog {
  static void showCustomDialog(BuildContext context, Facility facility) {
    showDialog(
      context: context,
      builder: (context) {
        return StationFacilityDialogWidget(
          icon: facility.facilityIconPath!,
          title: facility.facilityName!,
          content: facility.facilityContent!,
        );
      },
    );
  }
}
