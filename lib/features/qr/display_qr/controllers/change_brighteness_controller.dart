import 'package:get/get.dart';
import 'package:screen_brightness/screen_brightness.dart';

class ChangeBrightnessController extends GetxController {
  static ChangeBrightnessController get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    changeBrightness();
  }

  @override
  void onClose() {
    super.onClose();
    resetScreenBrightness();
  }

  void changeBrightness() async {
    final brightness = await ScreenBrightness.instance.application;
    if (brightness < 1) {
      await ScreenBrightness.instance.setApplicationScreenBrightness(1);
    }
  }

  void resetScreenBrightness() async {
    await ScreenBrightness.instance.resetApplicationScreenBrightness();
  }
}
