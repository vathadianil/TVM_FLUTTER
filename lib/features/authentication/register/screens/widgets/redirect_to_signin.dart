import 'package:flutter/material.dart';
import 'package:tsavaari/common/widgets/button/underlined_text_button.dart';
import 'package:tsavaari/features/authentication/register/controllers/registration_controller.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';

class RedirectToSignIn extends StatelessWidget {
  const RedirectToSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
         "Already have an account? ",
          softWrap: true,
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          style: Theme.of(context).textTheme.labelSmall,
        ),
        UnderLinedTextButton(
          btnText: TTexts.signIn, 
          onPressed: () {
            RegistrationController.instance.navigateToLoginPage();
          }
        ),
      ],
    );
  }
}
