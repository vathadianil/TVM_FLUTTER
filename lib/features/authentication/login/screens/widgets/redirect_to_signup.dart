import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/button/underlined_text_button.dart';
import 'package:tsavaari/features/authentication/login/controllers/login_controller.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class RedirectToSignUp extends StatelessWidget {
  const RedirectToSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          TTexts.signUpText,
          softWrap: true,
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        UnderLinedTextButton(
          btnText: TTexts.signUp, 
          onPressed: () {
            LoginController.instance.navigateToRegisterPage();
          }
        ),
      ],
    );
  }
}
