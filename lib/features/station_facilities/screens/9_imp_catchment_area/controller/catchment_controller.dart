import 'package:get/get.dart';
import 'package:tsavaari/features/station_facilities/models/station_facilities_services_model.dart';

class CatchmentController extends GetxController {
  final selectedGate = 0.obs;
  final title = ''.obs;
  final totalCatchmentPlaces = [].obs;
  final totalArms = <String>[].obs;
  final isActive = 0.obs;

  @override
  void onInit() {
    super.onInit();
    title.value = Get.arguments['facilityName'] ?? '';
    List<Facility> cathcmentPlaces = Get.arguments['catchment'] ?? [];
    isActive.value = Get.arguments['isActive'] ?? 0;

    for (var catchmentPlace in cathcmentPlaces) {
      totalArms.addIf(isActive.value == 1,
          'Arm ${catchmentPlace.isGateAvailable}');
      totalCatchmentPlaces.addIf(
          isActive.value == 1, catchmentPlace.facilityContent);
      // totalArms.addIf(catchmentPlace.isActive == 1,
      //     'Arm ${catchmentPlace.isGateAvailable}');
      // totalCatchmentPlaces.addIf(
      //     catchmentPlace.isActive == 1, catchmentPlace.facilityContent);
    }
  }

  // Method to update the selected gate
  void updateGate(int gate) {
    selectedGate.value = gate;
  }
}
