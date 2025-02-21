import 'package:flutter/material.dart';
import 'package:tsavaari/utils/constants/api_constants.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/image_strings.dart';
import 'package:tsavaari/utils/popups/full_screen_loader.dart';
import 'package:tsavaari/utils/popups/loaders.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaController {
  late AnimationController animationController;
  final ValueNotifier<bool> isExpandedNotifier = ValueNotifier<bool>(false);

  final List<Map<String, dynamic>> socialIcons = [
    {'icon': TImages.facebook, 'color': TColors.grey, 'url': ApiEndPoint.facebookUrl},
    {'icon': TImages.twitter, 'color': TColors.grey, 'url': ApiEndPoint.twitterUrl},
    {'icon': TImages.instagram, 'color': Colors.purple, 'url': ApiEndPoint.instagramUrl},
    {'icon': TImages.youtube, 'color': TColors.grey, 'url': ApiEndPoint.youtubeUrl},
    {'icon': TImages.linkedin, 'color': TColors.grey, 'url': ApiEndPoint.linkedInUrl},
  ];

  SocialMediaController(TickerProvider vsync) {
    animationController = AnimationController(
      vsync: vsync,
      duration: const Duration(milliseconds: 400),
    );
  }

  void dispose() {
    animationController.dispose();
    isExpandedNotifier.dispose();
  }

  void handleMediaTap() {
    isExpandedNotifier.value = !isExpandedNotifier.value;
    if (isExpandedNotifier.value) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  Future<void> launchSocialMedia(String staticUrl, {String mode = 'web'}) async {
    try {
      TFullScreenLoader.openLoadingDialog('Opening Website', TImages.trainAnimation);
      final Uri url = Uri.parse(staticUrl);
      if (mode == 'web') {
        await launchUrl(url);
      } else {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error Occurred', message: 'Could not launch website');
    } finally {
      TFullScreenLoader.stopLoading();
    }
  }

  Animation<Offset> getSlideAnimation(int index) {
    return Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        index / socialIcons.length,
        (index + 1) / socialIcons.length,
        curve: Curves.easeOut,
      ),
    ));
  }
}