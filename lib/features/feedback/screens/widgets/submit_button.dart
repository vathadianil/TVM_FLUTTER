import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';
import 'package:tsavaari/features/feedback/controllers/feedback_controller.dart';
import 'package:tsavaari/utils/constants/text_size.dart';

import '../../../../utils/constants/colors.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =  FeedbackController.instance;
    final textScaler = TextScaleUtil.getScaledText(context);
    
    return Align(
      alignment: Alignment.topCenter,
      child: Obx(
        ()=> CustomElevatedBtn(
          onPressed: controller.isLoading.value
            ? null
            : () => controller.submitFeedback(),
          child: controller.isLoading.value
              ? Transform.scale(
                  scale: .5,
                  child:
                      const CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(
                            TColors.primary),
                  ),
                )
              : Text(
                  'Submit',
                  textScaler: textScaler,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(
                          color: TColors.white,
                          fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}