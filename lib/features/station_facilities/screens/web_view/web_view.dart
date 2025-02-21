import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/station_facilities/screens/web_view/controllers/web_view_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/size_config.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends GetView<WebScreenController> {
  const WebViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WebScreenController());
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: TColors.white,
      appBar: TAppBar(
        showBackArrow: true,
        title: Obx(
          () => Text(
            controller.title?.value ?? '',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: TColors.white),
          ),
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Obx(() {
      if (controller.contentUrl?.value == null ||
          controller.contentUrl!.value.isEmpty) {
        return Center(
          child: Text(
            'No information available for this station',
          ),
        );
      }

      return Stack(
        children: [
          WebViewWidget(
            controller: controller.webViewController,
          ),
          if (controller.isLoading.value)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      );
    });
  }
}
