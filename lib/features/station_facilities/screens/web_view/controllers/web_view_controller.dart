// metro_timings_controller.dart
import 'dart:ui';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebScreenController extends GetxController {
  final RxString? contentUrl = RxString('');
  final RxString? title = RxString('');
  //final RxString? facilityIconPath = RxString('');
  final RxBool isLoading = true.obs;
  late final WebViewController webViewController;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, String?>) {
      final Map<String, String?> args = Get.arguments as Map<String, String?>;
      contentUrl?.value = args['contentUrl'] ?? '';
      title?.value = args['facilityName'] ?? '';
      //facilityIconPath?.value = args['facilityIconPath'] ?? '';
      initWebView();
    }
  }

  void initWebView() {
    if (contentUrl?.value != null && contentUrl!.value.isNotEmpty) {
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageFinished: (String url) {
              isLoading.value = false;
            },
            onWebResourceError: (WebResourceError error) {
              isLoading.value = false;
              Get.snackbar(
                'Error',
                'Failed to load content: ${error.description}',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        )
        ..loadRequest(Uri.parse(contentUrl!.value));
    }
  }
}
