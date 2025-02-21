import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/features/card_reacharge/controllers/metro_card_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/utils/validators/validation.dart';

class AddOrEditCardDetailsPopup extends StatelessWidget {
  const AddOrEditCardDetailsPopup({
    super.key,
    required this.type,
  });

  final String type;

  @override
  Widget build(BuildContext context) {
    final screenWidth = TDeviceUtils.getScreenWidth(context);
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
                          type == 'add' ? 'Add New Card' : 'Edit Existing Card',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          type == 'add'
                              ? 'Enter the Card Details'
                              : 'Edit the Card Details',
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      icon: const Icon(Iconsax.close_circle),
                    ),
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
                TextFormField(
                  controller: cardController.cardNumber,
                  enabled: type == 'add',
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
                      color: type == 'add'
                          ? isDark
                              ? TColors.accent
                              : TColors.primary
                          : TColors.darkGrey,
                    ),
                    // labelText: 'Card Number',

                    label: Text(
                      'Card Number',
                      style: Theme.of(context)
                          .inputDecorationTheme
                          .labelStyle!
                          .copyWith(
                              color: type == 'add'
                                  ? isDark
                                      ? TColors.light
                                      : TColors.black
                                  : TColors.darkGrey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
                TextFormField(
                  controller: cardController.cardHolderName,
                  validator: (value) =>
                      TValidator.validateEmptyText('Card Holder Name', value),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: TSizes.md,
                    ),
                    suffixIcon: Icon(Iconsax.user),
                    labelText: 'Card Holder Name',
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
                        minimumSize: Size(screenWidth * .1, screenWidth * .06),
                        padding: const EdgeInsets.symmetric(
                          vertical: TSizes.xs,
                          horizontal: TSizes.lg,
                        ),
                      ),
                      onPressed: () {
                        cardController.addOrUpdateCardDetailsByUser(type);
                      },
                      child: Text(
                        'Save',
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
