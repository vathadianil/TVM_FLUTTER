import 'package:get/get.dart';
import 'package:tsavaari/features/station_facilities/controllers/station_facilities_controller.dart';

class StationFacilitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=>StationFacilitiesController());
  }
}