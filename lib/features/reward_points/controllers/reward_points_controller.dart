import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/loyalty_points/loyalty_points_repository.dart';
import 'package:tsavaari/features/reward_points/models/loyalty_points_history_model.dart';
import 'package:tsavaari/utils/local_storage/storage_utility.dart';
import 'package:tsavaari/utils/popups/loaders.dart';

class RewardPointsController extends GetxController {
  static RewardPointsController get instance => Get.find();

  //Variables
  final _loyaltyPointsRepository = Get.put(LoyaltyPointsRepository());
  final isLoadingPointsSummary = false.obs;
  final isLoadingPointsHistory = false.obs;

  final RxInt loyaltyProgramKey  = 0.obs;
  final RxInt activePoints  = 0.obs;
  final RxInt maxRedemptionPoints = 0.obs;
  final RxDouble maxRedemptionAmount = 0.0.obs;
  final RxInt minRedemptionPoints = 0.obs;

  final RxList<LoyaltyPointsHistoryModel> loyaltyPointsHistory = <LoyaltyPointsHistoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserPointsSummary();
    fetchLoyaltyPointsHistory();
  }

  // Fetch User Points Summary
  Future<void> fetchUserPointsSummary() async {
    try {
      isLoadingPointsSummary.value = true;

      final uid = TLocalStorage().readData('uid') ?? '';

      final data = await _loyaltyPointsRepository.getUserPointsSummary(uid: uid);
      
      loyaltyProgramKey.value = data.totalSummary!.loyaltyProgramKey ?? 0;
      activePoints.value = data.totalSummary!.activePoints ?? 0;
      maxRedemptionPoints.value = data.totalSummary!.maxRedemptionPoints ?? 0;
      maxRedemptionAmount.value = data.totalSummary!.maxRedemptionAmount ?? 0;
      minRedemptionPoints.value = data.totalSummary!.minRedemptionPoints ?? 0;

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoadingPointsSummary.value = false;
    }
  }

  // Fetch Loyalty Points History
  Future<void> fetchLoyaltyPointsHistory() async {
    try {
      isLoadingPointsHistory.value = true;

      final uid = TLocalStorage().readData('uid') ?? '';

      final payload = {
        "user_id": uid.toString()
      };

      final data = await _loyaltyPointsRepository.getLoyaltyPointsHistory(payload);
      
      // Clear existing history before adding new items
      loyaltyPointsHistory.clear();
      
      // Check if response contains a list of history items
      if (data.response != null && data.response is List) {
        final historyItems = (data.response as List).map((item) => 
          LoyaltyPointsHistoryModel.fromJson(item as Map<String, dynamic>)
        ).toList();
        
        loyaltyPointsHistory.addAll(historyItems);
      }

    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoadingPointsHistory.value = false;
    }
  }

}
