import 'package:get/get.dart';
import 'package:tsavaari/features/station_facilities/models/station_facilities_services_model.dart';

class BusStopController extends GetxController {
  // Reactive variable for selected gate
  final selectedGate = 0.obs;
  final title = ''.obs;
  final totalBusStops = [].obs;
  final totalArms = <String>[].obs;
  final isActive = 0.obs;

  @override
  void onInit() {
    super.onInit();
    title.value = Get.arguments['facilityName'] ?? '';
    List<Facility> busStops = Get.arguments['busStops'] ?? [];
    isActive.value = Get.arguments['isActive'] ?? 0;

    for (var busStop in busStops) {
      totalArms.addIf(isActive.value == 1, 'Arm ${busStop.isGateAvailable}');
      totalBusStops.addIf(isActive.value == 1, busStop.facilityContent);
      // totalArms.addIf(busStop.isActive == 1, 'Arm ${busStop.isGateAvailable}');
      // totalBusStops.addIf(busStop.isActive == 1, busStop.facilityContent);
    }
  }

  // Method to update the selected gate
  void updateGate(int gate) {
    selectedGate.value = gate;
  }
}
