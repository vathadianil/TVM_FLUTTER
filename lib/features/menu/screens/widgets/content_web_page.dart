// web_view_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/menu/controllers/content_web_view_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';

class ContentWebViewPage extends StatelessWidget {
  final String url;
  final String title;

  const ContentWebViewPage({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ContentWebViewController controller = Get.put(ContentWebViewController(url: url));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.white),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller.webViewController
          ),
          Obx(
            () => controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

