import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/common/widgets/images/rounded_corner_image.dart';
import 'package:tsavaari/features/home/screens/widgets/banner_image_slider.dart';
import 'package:tsavaari/utils/constants/banner_page_type.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';

class NetworkMapScreen extends StatefulWidget {
  const NetworkMapScreen({super.key});

  @override
  State<NetworkMapScreen> createState() => _NetworkMapScreenState();
}

class _NetworkMapScreenState extends State<NetworkMapScreen> {
  final TransformationController _transformationController = TransformationController();
  TapDownDetails? _doubleTapDetails;
  static const double _zoomFactor = 4.0; // Increased from 2.0 to 4.0

  void _handleDoubleTapDown(TapDownDetails details) {
    _doubleTapDetails = details;
  }

  void _handleDoubleTap() {
    if (_doubleTapDetails == null) {
      return;
    }

    final position = _doubleTapDetails!.localPosition;
    final double scale = _transformationController.value.getMaxScaleOnAxis();

    // If we're already zoomed in, zoom out
    if (scale >= _zoomFactor) {
      _transformationController.value = Matrix4.identity();
    } else {
      // Zoom in to the tapped position with higher zoom factor
      final x = -position.dx * _zoomFactor + MediaQuery.of(context).size.width / 2;
      final y = -position.dy * _zoomFactor + MediaQuery.of(context).size.height / 2;

      final zoomed = Matrix4.identity()
        ..translate(x, y)
        ..scale(_zoomFactor);
      _transformationController.value = zoomed;
    }
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text(
          'Metro Network Map',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: TColors.white,
              ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onDoubleTapDown: _handleDoubleTapDown,
              onDoubleTap: _handleDoubleTap,
              child: InteractiveViewer(
                transformationController: _transformationController,
                maxScale: 8,
                child: RoundedCornerImage(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  height: TDeviceUtils.getScreenHeight() * .9,
                  isNetworkImage: false,
                  imageUrl: TImages.metroNetworkMap,
                ),
              ),
            ),
          ),
          // Display Google Ads Or Banners
          BannerImageSlider(
            autoPlay: true,
            pageType: BannerPageType.metroNetworkMap
          ),
          const SizedBox(
            height: TSizes.lg,
          )
        ],
      ),
    );
  }
}