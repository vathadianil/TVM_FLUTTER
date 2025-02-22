import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/validators/validation.dart';

class AddOrEditCardDetailsPopup extends StatelessWidget {
  const AddOrEditCardDetailsPopup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardController = MetroCardController.instance;
    final isDark = THelperFunctions.isDarkMode(context);

    return Dialog(
      backgroundColor:
          THelperFunctions.isDarkMode(context) ? TColors.dark : TColors.white,
      child: SingleChildScrollView(
        child: Form(
          key: cardController.cardAddOrUpdateFormKey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Enter Your Card Number',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                TextFormField(
                  controller: cardController.cardNumber,
                  keyboardType: TextInputType.number,
                  maxLength: 14,
                  validator: (value) => TValidator.validateCardNumber(value),
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: TSizes.md,
                    ),
                    suffixIcon: Icon(
                      Iconsax.card,
                      color: isDark ? TColors.accent : TColors.primary,
                    ),
                    // labelText: 'Card Number',

                    label: Text(
                      'Card Number',
                      style: Theme.of(context)
                          .inputDecorationTheme
                          .labelStyle!
                          .copyWith(
                              color: isDark ? TColors.light : TColors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: TSizes.xs,
                          horizontal: TSizes.lg,
                        ),
                      ),
                      onPressed: () {
                        cardController.addOrUpdateCardDetailsByUser();
                      },
                      child: Text(
                        'Search',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: TColors.white),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
