import 'package:get/get.dart';
import 'package:tsavaari/features/station_facilities/models/station_facilities_services_model.dart';

class NeighbourhoodController extends GetxController {
  final selectedGate = 0.obs;
  final title = ''.obs;
  final totalNeighoodPlaces = [].obs;
  final totalArms = <String>[].obs;
  final isActive = 0.obs;

  @override
  void onInit() {
    super.onInit();
    title.value = Get.arguments['facilityName'] ?? '';
    List<Facility> neightbourhoodPleaces = Get.arguments['neighbourhood'] ?? [];
    isActive.value = Get.arguments['isActive'] ?? 0;

    for (var neighbourhood in neightbourhoodPleaces) {
      totalArms.addIf(
          isActive.value == 1, 'Arm ${neighbourhood.isGateAvailable}');
      totalNeighoodPlaces.addIf(
          isActive.value == 1, neighbourhood.facilityContent);
      // totalArms.addIf(
      //     neighbourhood.isActive == 1, 'Arm ${neighbourhood.isGateAvailable}');
      // totalNeighoodPlaces.addIf(
      //     neighbourhood.isActive == 1, neighbourhood.facilityContent);
    }
  }

  // Method to update the selected gate
  void updateGate(int gate) {
    selectedGate.value = gate;
  }
}
