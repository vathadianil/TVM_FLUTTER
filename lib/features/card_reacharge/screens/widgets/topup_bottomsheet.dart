import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/features/card_reacharge/models/nebula_card_validation_model.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/confirm_topup.dart';
import 'package:tsavaari/features/card_reacharge/screens/widgets/topup_bottom_sheet_main_page.dart';
import 'package:tsavaari/features/qr/display_qr/controllers/bottom_sheet_pageview_controller.dart';
// import 'package:tsavaari/features/reward_points/controllers/reward_points_controller.dart';
import 'package:tsavaari/utils/constants/sizes.dart';

class TopupBottomSheet extends StatelessWidget {
  const TopupBottomSheet({super.key, required this.cardData});

  final NebulaCardValidationModel cardData;

  @override
  Widget build(BuildContext context) {
    final bottomSheetContoller = Get.put(BottomSheetPageViewController());
    // Get.put(RewardPointsController());

    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace),
      child: SizedBox(
        child: PageView(
          controller: bottomSheetContoller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            TopupMainPage(cardData: cardData),
            ConfirmTopup(
              cardDetails: cardData,
            ),
          ],
        ),
      ),
    );
  }
}
