import 'package:get/get.dart';
import 'package:tsavaari/data/repositories/menu/menu_repository.dart';
import 'package:tsavaari/features/menu/models/menu_content_model.dart';

class MenuContentController extends GetxController {
  static MenuContentController get instance => Get.find();

  //Variables
  final _menuRepository = Get.put(MenuRepository());
  final isLoading = false.obs;
  final RxList<Content> contentList = <Content>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   fetchMenuContent();
  // }

  // Fetch Notifications
  Future<void> fetchMenuContent() async {
    try {
      isLoading.value = true;

      final contentData = await _menuRepository.getMenuContent();

      if (contentData.data!.success == true) {
        contentList.assignAll(contentData.data!.content!);
      } else {
        print("Failed to load Contents");
      }
      
    } catch (e) {
      print(e.toString());
      //TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
