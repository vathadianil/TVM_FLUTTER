import 'dart:convert';
import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/book_qr/station_list_repository.dart';
import 'package:tsavaari/features/authentication/login/screens/login.dart';
import 'package:tsavaari/features/qr/book_qr/models/station_list_model.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class StationListController extends GetxController {
  static StationListController get instance => Get.find();

//Variables
  final isLoading = true.obs;
  final stationListRepository = Get.put(StationListRepository());

  RxList<StationListModel> stationList = <StationListModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getStationList();
  }

  Future<void> getStationList() async {
    //Show loader while loading categories
    isLoading.value = true;

    //Retrive station list Fetched Date
    final stationListFetchedDate =
        await TLocalStorage().readData('stationListFetchedDate') ?? '';

    // Retrieve station list from local storage
    final storedData = await TLocalStorage().readData('stationList') ?? '';

    List<StationListModel> storedStationList = [];

    if (stationListFetchedDate != '' &&
        stationListFetchedDate ==
            THelperFunctions.getFormattedDate(DateTime.now()) &&
        storedData != '') {
      try {
        storedStationList = (storedData as List)
            .map((item) => StationListModel.fromJson(jsonDecode(item)))
            .toList();
        if (storedStationList.isNotEmpty) {
          stationList.assignAll(storedStationList);
          isLoading.value = false;
        }
      } catch (e) {
        fetchStationList();
      }
    } else {
      fetchStationList();
    }
  }

  fetchStationList() async {
    try {
      final token = await TLocalStorage().readData('token') ?? '';
      if (token != '') {
        final stationsData =
            await stationListRepository.fetchStationList(token);
        stationList
            .assignAll(stationsData.stations as Iterable<StationListModel>);

        // Save fetched data to local storage
        await TLocalStorage().saveData(
          'stationList',
          stationsData.stations!
              .map((item) => jsonEncode(item.toJson()))
              .toList(),
        );
        await TLocalStorage().saveData('stationListFetchedDate',
            THelperFunctions.getFormattedDate(DateTime.now()));
      } else {
        TLoaders.errorSnackBar(
            title: 'Oh Snap!',
            message: 'Your Session has expired!. Please Login Again.');
        Get.offAll(
          () => const LoginScreen(),
        );
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }
}
