import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContentWebViewController extends GetxController {
  final String url;
  final isLoading = true.obs;
  late final WebViewController webViewController;

  ContentWebViewController({required this.url});

  @override
  void onInit() {
    super.onInit();
    initializeWebView();
  }

  void initializeWebView() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            handleError(error);
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }

  void handleError(WebResourceError error) {
    // Handle web resource errors here
    Get.snackbar(
      'Error',
      'Failed to load page: ${error.description}',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    // Clean up resources if needed
    super.onClose();
  }
}
