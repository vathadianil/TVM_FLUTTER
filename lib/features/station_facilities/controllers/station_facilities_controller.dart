import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tsavaari/data/repositories/station_facilities/station_facilities_repository.dart';
import 'package:tsavaari/features/station_facilities/models/station_list_lat_lng_model.dart';
import 'package:tsavaari/features/station_facilities/models/station_facilities_services_model.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class StationFacilitiesController extends GetxController {
  static StationFacilitiesController get instance => Get.find();

  //Variables
  final isLoading = true.obs;
  final isNearestStationLoading = false.obs;
  final stationFacilitiesRepository = Get.put(StationFacilitiesRepository());
  final RxList<Stnlist> stationList = <Stnlist>[].obs;
  final RxList<Facility> stationFacilities = <Facility>[].obs;
  final stadiumStationId = 46;
  final stadiumStationName = 'Stadium';

  Rxn<String> stationName = Rxn<String>();
  Rxn<Stnlist> nearestStation = Rxn<Stnlist>();

  @override
  void onInit() {
    super.onInit();
    _getStationListWithCoords();
    // _findNearestStation();
    getMetroStationFacilitiesServices(
        stadiumStationId); // Initialize with no specific station
    stationName.value = stadiumStationName;
  }

  Future<void> getMetroStationFacilitiesServices(int? stnId) async {
    if (stnId == null) return; // Ensure stnId is not null before proceeding
    try {
      isLoading.value = true;
      final stationsServicesData = await stationFacilitiesRepository
          .fetchMetroStationFacilitiesServices(stnId: stnId);

      stationFacilities.value = stationsServicesData.r.facilities;
      isLoading.value = false;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _getStationListWithCoords() async {
    try {
      isLoading.value = true;
      final stationsData =
          await stationFacilitiesRepository.fetchStationsWithCoordsList();

      stationList.value = stationsData.stnlist!;
      isLoading.value = false;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _findNearestStation() async {
    isNearestStationLoading.value = true;
    Position? userLocation = await _getUserLocation();
    if (userLocation == null) return;

    double shortestDistance = double.infinity;
    Stnlist? closestStation;

    for (var station in stationList) {
      double distance = Geolocator.distanceBetween(
        userLocation.latitude,
        userLocation.longitude,
        station.latitude!,
        station.longitude!,
      );

      if (distance < shortestDistance) {
        shortestDistance = distance;
        closestStation = station;
      }
    }

    if (closestStation != null) {
      stationName.value = closestStation.station;
      nearestStation.value = closestStation;
      getMetroStationFacilitiesServices(
          closestStation.stnId); // Load facilities for nearest station
    }
    isNearestStationLoading.value = false;
  }

  Future<Position?> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, so you may want to prompt the user to enable them
      return null;
    }

    // Check for permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied, handle this case in the UI
      return null;
    }

    // When permission is granted, get the position
    return await Geolocator.getCurrentPosition();
  }
}
