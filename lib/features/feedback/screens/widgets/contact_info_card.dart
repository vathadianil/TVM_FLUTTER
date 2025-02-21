import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tsavaari/common/widgets/containers/t_circular_container.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    await _launchUrl(uri.toString());
  }

  Future<void> _sendEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    await _launchUrl(uri.toString());
  }

  Future<void> _openWebsite(String website) async {
    if (!website.startsWith('http')) {
      website = 'https://$website';
    }
    await _launchUrl(website);
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final textScaler = TextScaleUtil.getScaledText(context);
    
    return TCircularContainer(
      width: screenWidth,
      padding: TSizes.md,
      applyBoxShadow: true,
      backgroundColor: dark ? TColors.dark : TColors.white,
      boxShadowColor:
          dark ? TColors.accent.withOpacity(.3) : TColors.accent,
      radius: TSizes.borderRadiusMd,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Contact Information', 
            textScaler: textScaler,
            style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500),
          ),
          SizedBox(height: screenWidth * .04),
          _buildContactRow(
            context,
            'Phone', 
            '040-2333-2555', 
            Icons.phone_outlined,
            onTap: () => _makePhoneCall('04023332555'),
          ),
          _buildContactRow(
            context,
            'Email', 
            'customerservice@ltmetro.com', 
            Icons.email_outlined,
            onTap: () => _sendEmail('customerservice@ltmetro.com'),
          ),
          _buildContactRow(
            context,
            'Website', 
            'www.ltmetro.com', 
            Icons.work_outline_outlined,
            onTap: () => _openWebsite('www.ltmetro.com'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(BuildContext context, String label, String value, IconData? icon, {VoidCallback? onTap}) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
    final dark = THelperFunctions.isDarkMode(context);
    final textScaler = TextScaleUtil.getScaledText(context);
    
    return Padding(
      padding: EdgeInsets.only(bottom: screenWidth * .03),
      child: InkWell(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: TColors.primary,
              size: screenWidth * .055,
            ),
            SizedBox(width: screenWidth * .02),
            SizedBox(
              width: screenWidth * .15,
              child: Text(
                label,
                textScaler: textScaler,
                style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: TColors.darkGrey),
              ),
            ),
            Text(' :   ', 
              textScaler: textScaler,
              style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(color: TColors.grey),
            ),
            Expanded(
              child: Text(
                value,
                textScaler: textScaler,
                style: Theme.of(Get.context!).textTheme.labelLarge!.copyWith(
                    color: dark ? TColors.accent : TColors.primary,
                    decoration: onTap != null ? TextDecoration.underline : null,
                    decorationColor: dark ? TColors.accent : TColors.primary,
                    decorationThickness: 1, 
                    height: 2, 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}