import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tsavaari/common/components/custom_drop_down.dart';
import 'package:tsavaari/common/controllers/checkbox_controller.dart';
import 'package:tsavaari/common/widgets/appbar/t_appbar.dart';
import 'package:tsavaari/features/authentication/login/screens/widgets/form_divider.dart';
import 'package:tsavaari/features/authentication/register/controllers/registration_controller.dart';
import 'package:tsavaari/features/authentication/register/screens/widgets/date_of_birth_field.dart';
import 'package:tsavaari/features/authentication/register/screens/widgets/gender_selection_button.dart';
import 'package:tsavaari/features/authentication/register/screens/widgets/person_disabilities_button.dart';
import 'package:tsavaari/features/authentication/register/screens/widgets/redirect_to_signin.dart';
import 'package:tsavaari/features/authentication/register/screens/widgets/register_button.dart';
import 'package:tsavaari/features/authentication/register/screens/widgets/terms_and_conditions.dart';
import 'package:tsavaari/utils/constants/colors.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/constants/text_size.dart';
import 'package:tsavaari/utils/constants/text_strings.dart';
import 'package:tsavaari/utils/validators/validation.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({super.key});
  final RegistrationController controller = Get.put(RegistrationController());
  final CheckBoxController checkBoxController = Get.put(CheckBoxController());

  @override
  Widget build(BuildContext context) {
    final textScaler = TextScaleUtil.getScaledText(context);

    return Scaffold(
      appBar: TAppBar(
        showBackArrow: false,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  controller.navigateToLoginPage();
                },
                icon: const Icon(
                  Iconsax.arrow_left,
                  color: Colors.white,
                )),
            Text(
              'Register Your Profile',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // _buildHeaderSection(context),
          _buildRegistrationForm(context, textScaler, controller),
        ],
      ),
    );
  }

  // Widget _buildHeaderSection(context) {
  //   return HeaderSectionContainer(
  //     child: Container(
  //       color: TColors.primary,
  //       width: double.infinity,
  //       height: SizeConfig.blockSizeVertical * 20,
  //       padding: EdgeInsets.symmetric(
  //         horizontal: SizeConfig.blockSizeHorizontal * 8,
  //         vertical: SizeConfig.blockSizeVertical * 6,
  //       ),
  //       child: Row(
  //         children: [
  //           IconButton(
  //               onPressed: () {
  //                 controller.navigateToLoginPage();
  //               },
  //               icon: const Icon(
  //                 Iconsax.arrow_left,
  //                 color: Colors.white,
  //               )),
  //           Text(
  //             'Register\nYour Profile',
  //             // style: AppTextStyle.loginTextStyle(),
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .headlineMedium!
  //                 .copyWith(color: Colors.white),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildRegistrationForm(
      context, textScaler, RegistrationController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: TSizes.spaceBtwSections),
        child: Form(
          key: controller.formKey,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: TSizes.spaceBtwInputFields),
              TextFormField(
                keyboardType: TextInputType.text,
                onChanged: (value) => controller.fullName.value = value,
                validator: controller.validateFullName,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^[a-zA-Z\s]*$')),
                ],
                decoration: InputDecoration(
                  label: Text(
                    "Full Name",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textScaler: textScaler,
                  ),
                  prefixIcon: const Icon(
                    Icons.person_outline_outlined,
                    color: TColors.primary,
                  ),
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                keyboardType: TextInputType.phone,
                onChanged: (value) => controller.mobileNumber.value = value,
                maxLength: 10,
                validator: TValidator.validatePhoneNumber,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  label: Text(
                    TTexts.phoneNo,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textScaler: textScaler,
                  ),
                  prefixIcon: const Icon(
                    Icons.call,
                    color: TColors.primary,
                  ),
                  counterText: "",
                ),
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => controller.emailId.value = value,
                // validator: (value) {
                //   if (value == null ||
                //       value.trim().isEmpty ||
                //       !value.contains('@') ||
                //       !value.contains('.com')) {
                //     return 'Please enter valid email address';
                //   }
                //   return null;
                // },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
                ],
                decoration: InputDecoration(
                  label: Text(
                    TTexts.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textScaler: textScaler,
                  ),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: TColors.primary,
                  ),
                ),
              ),
              
              const SizedBox(height: TSizes.spaceBtwItems),
              Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomDropdown(
                      labelText: 'Occupation ',
                      labelStyle: Theme.of(context).textTheme.bodyMedium,
                      prefixIcon: const Icon(
                        Icons.work_outline_outlined,
                        color: TColors.primary,
                        size: 22,
                      ),
                      value: controller.selectedOccupation.value.isEmpty ? null : controller.selectedOccupation.value,
                      items: const [
                        DropdownMenuItem(value: "Armed Force", child: Text("Armed Force")),
                        DropdownMenuItem(value: "Business", child: Text("Business")),
                        DropdownMenuItem(value: "Govt. Employee", child: Text("Govt. Employee")),
                        DropdownMenuItem(value: "Homemaker", child: Text("Homemaker")),
                        DropdownMenuItem(value: "IT Employee", child: Text("IT Employee")),
                        DropdownMenuItem(value: "Non-IT Employee", child: Text("Non-IT Employee")),
                        DropdownMenuItem(value: "Private Employee", child: Text("Private Employee")),
                        DropdownMenuItem(value: "Student", child: Text("Student")),
                        DropdownMenuItem(value: "Teacher", child: Text("Teacher")),
                        DropdownMenuItem(value: "Others", child: Text("Others")),
                      ],
                      onChanged: (value) {
                        controller.selectedOccupation.value = value ?? '';
                        // Reset other profession text field when changing the dropdown value
                        if (value != "Others") {
                          controller.otherOccupationController.clear();
                        }
                      },
                      isDense: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select your occupation';
                        }
                        // if (value == 'Others' && controller.otherOccupationController.text.isEmpty) {
                        //   return 'Please specify your occupation';
                        // }
                        return null;
                      },
                    ),
                    // Show the TextField if "Others" is selected
                    if (controller.selectedOccupation.value == "Others")
                      Padding(
                        padding: const EdgeInsets.only(top:  TSizes.spaceBtwItems),
                        child: TextFormField(
                          controller: controller.otherOccupationController,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(
                                r'^[a-zA-Z\s]*$')),
                          ],
                          decoration: InputDecoration(
                            label: Text(
                              'Specify your occupation',
                              style: Theme.of(context).textTheme.bodyMedium,
                              textScaler: textScaler,
                            ),
                            prefixIcon: const Icon(
                              Icons.workspaces_outline,
                              color: TColors.primary,
                            ),
                          ),
                          validator: (value) {
                            if (controller.selectedOccupation.value == "Others" && 
                                (value == null || value.isEmpty)) {
                              return 'Please specify your occupation';
                            }
                            return null;
                          },
                        ),
                      ),
                  ],
                );
              }),
              // Obx(() => CustomDropdown(
              //   labelText: 'Profession',
              //   labelStyle: Theme.of(context).textTheme.bodyMedium,
              //   prefixIcon: const Icon(
              //     Icons.work_outline_outlined,
              //     color: TColors.primary,
              //     size: 22,
              //   ),
              //   value: controller.selectedProfession.value.isEmpty ? null : controller.selectedProfession.value,
              //   items: const [
              //     DropdownMenuItem(value: "Govt. Employee", child: Text("Govt. Employee")),
              //     DropdownMenuItem(value: "IT Employee", child: Text("IT Employee")),
              //     DropdownMenuItem(value: "Non IT Employee", child: Text("Non IT Employee")),
              //     DropdownMenuItem(value: "Bussiness", child: Text("Bussiness")),
              //     DropdownMenuItem(value: "Student", child: Text("Student")),
              //     DropdownMenuItem(value: "House Wife", child: Text("House Wife")),
              //   ],
              //   onChanged: (value) {
              //     controller.selectedProfession.value = value ?? '';
              //   },
              //   isDense: true,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please select your profession';
              //     }
              //     return null;
              //   },
              // )),

              const SizedBox(height: TSizes.spaceBtwItems),
              const DateOfBirthField(),

              const SizedBox(height: TSizes.spaceBtwItems),
              const PersonWithDisabilitiesSelectionButton(),

              const SizedBox(height: TSizes.spaceBtwItems),
              const GenderSelectionButton(),

              const SizedBox(height: TSizes.spaceBtwSections),
              const TermsAndConditions(),

              const SizedBox(height: TSizes.xs),
              const RegisterButton(),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              const FormDivider(dividerText: TTexts.dividerText),

              //Sign Up Redirect
              const RedirectToSignIn(),
            ],
          ),
        ),
      ),
    );
  }

}
