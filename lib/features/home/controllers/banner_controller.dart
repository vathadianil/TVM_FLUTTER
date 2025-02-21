import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/banner/banner_repository.dart';
import 'package:tsavaari/features/home/models/banner_model.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  //Variables
  final _bannerRepository = Get.put(BannerRepository());
  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<Banner> bannersList = <Banner>[].obs;
  final Rx<AdsSettings?> adsSettings = Rx<AdsSettings?>(null);

  //Update page navigation dots
  void updatePageIndicator(index) {
    carouselCurrentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  //Fetch banners
  Future<void> fetchBanners() async {
    try {
      //Show loader while loading categories
      isLoading.value = true;

      final banners = await _bannerRepository.getAllBanners();
      
      // Store banners and ad settings
      if (banners.data != null) {
        bannersList.assignAll(banners.data!.banners ?? []);
        adsSettings.value = banners.data!.adsSettings;
      }

    } catch (e) {
      print(e.toString());
      //TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //Remove loader
      isLoading.value = false;
    }
  }
}
