import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';
import 'package:tsavaari/common/widgets/button/underlined_text_button.dart';
import 'package:tsavaari/features/qr/book_qr/screens/widgets/terms_and_conditions_popup.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class CustomBtnWithTermsDialog extends StatelessWidget {
  const CustomBtnWithTermsDialog({
    super.key,
    required this.btnText,
    required this.onPressed,
    this.isFullWidthBtn = false,
  });

  final String btnText;
  final Function()? onPressed;
  final bool isFullWidthBtn;

  @override
  Widget build(BuildContext context) {
    final checkBoxController = CheckBoxController.instance;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(
              () => Checkbox(
                value: checkBoxController.checkBoxState.value,
                onChanged: (value) => checkBoxController.checkBoxState.value =
                    !checkBoxController.checkBoxState.value,
              ),
            ),
            Row(
              children: [
                Text(
                  TTexts.iAgree,
                  textScaler: TextScaleUtil.getScaledText(context, maxScale: 1),
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                UnderLinedTextButton(
                  btnText: TTexts.termsConditions,
                  onPressed: () {
                    Get.dialog(const Dialog(
                      child: TermsandConditionsPopup(),
                    ));
                  },
                ),
              ],
            )
          ],
        ),
        Obx(
          () => SizedBox(
            width: isFullWidthBtn ? double.infinity : null,
            child: CustomElevatedBtn(
              onPressed:
                  checkBoxController.checkBoxState.value ? onPressed : null,
              backgroundColor: checkBoxController.checkBoxState.value
                  ? TColors.primary
                  : TColors.grey,
              child: Text(
                btnText,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: checkBoxController.checkBoxState.value
                          ? TColors.light
                          : TColors.darkGrey,
                    ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: TSizes.defaultSpace,
        )
      ],
    );
  }
}
