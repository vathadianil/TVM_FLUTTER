import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tsavaari/common/components/date_picker_helper.dart.dart';
import 'package:tsavaari/common/components/custom_drop_down.dart';
import 'package:tsavaari/common/components/custom_text_form_field.dart';
import 'package:tsavaari/features/profile/controllers/profile_controller.dart';
import 'package:tsavaari/utils/constants/colors.dart';
//import 'package:tsavaari/utils/constants/size_config.dart';
import 'package:tsavaari/utils/constants/sizes.dart';
import 'package:tsavaari/utils/device/device_utility.dart';
import 'package:tsavaari/utils/helpers/helper_functions.dart';
import 'package:tsavaari/common/widgets/button/custom_elevated_btn.dart';


class ProfileDetailsForm extends StatelessWidget {
  ProfileDetailsForm({super.key});

  final profileController = ProfileController.instance;
  final screenHeight = TDeviceUtils.getScreenHeight();
  final screenWidth = TDeviceUtils.getScreenWidth(Get.context!);

  @override
  Widget build(BuildContext context) {
    THelperFunctions.isDarkMode(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: TSizes.lg * 2,
        vertical: TSizes.spaceBtwItems,
      ),
      child: Form(
        key: profileController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFullNameField(),
            const SizedBox(height: TSizes.spaceBtwItems), 
            _buildMobileNumberField(context),
            const SizedBox(height: TSizes.spaceBtwItems), 
            _buildOccupationDropdown(),
            const SizedBox(height: TSizes.spaceBtwItems), 
            _buildDateOfBirthField(),
            const SizedBox(height: TSizes.spaceBtwItems), 
            _buildEmailField(),
            const SizedBox(height: TSizes.spaceBtwItems), 
            _buildPersonWithDisabilitiesDropdown(),
            const SizedBox(height: TSizes.spaceBtwItems), 
            _buildGenderDropdown(),
            const SizedBox(height: TSizes.xl * 2), 
            _buildEditOrSubmitButton(),
            const SizedBox(height: TSizes.spaceBtwItems), 
          ],
        ),
      ),
    );
  }

  Widget _buildFullNameField() {
    return Obx(() => CustomTextFormField(
      labelText: 'Full Name',
      keyboardType: TextInputType.text,
      controller: profileController.fullNameController,
      onChanged: (value) => profileController.fullNameController.text = value,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your full name';
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'^[a-zA-Z\s]*$')), // Allow only letters and spaces
      ],
      enabled: profileController.isEditable.value, // Disable/Enable based on state
    ));
  }

  Widget _buildEmailField() {
    return Obx(() => CustomTextFormField(
      labelText: 'Email',
      keyboardType: TextInputType.emailAddress,
      controller: profileController.emailController,
      onChanged: (value) => profileController.emailController.text = value,
      validator: (value) {
        if (value == null ||
            value.trim().isEmpty ||
            !value.contains('@') ||
            !value.contains('.com')) {
          return 'Please enter valid email address';
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@._-]')),
      ],
      enabled: profileController.isEditable.value, // Disable/Enable based on state
    ));
  }

  Widget _buildMobileNumberField(BuildContext context) {
    return Obx(
      () => CustomTextFormField(
        labelText: 'Mobile Number',
        keyboardType: TextInputType.number,
        controller: profileController.mobileNumberController,
        enabled: profileController.isEditable.value, // Enable only when editable
        maxLength: 10,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your mobile number';
          } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
            return 'Mobile number must be 10 digits';
          }
          return null;
        },
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      ),
    );
  }

  Widget _buildOccupationDropdown() {
    return Obx(() => Column(
      children: [
        CustomDropdown(
          labelText: 'Occupation ',
          value: profileController.selectedOccupation.value.isEmpty 
            ? null 
            : profileController.selectedOccupation.value,
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
          contentPadding: EdgeInsets.symmetric(
            vertical: screenHeight * .017,
            horizontal:screenWidth * .04,
          ),
          enabled: profileController.isEditable.value,
          onChanged: profileController.isEditable.value 
              ? (value) {
                  if (value != null) {
                    profileController.selectedOccupation.value = value;
                    // Clear the other occupation text field if not selecting "Others"
                    if (value != "Others") {
                      profileController.otherOccupationController.clear();
                    }
                  }
                }
              : null,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select your Occupation';
            }
            return null;
          },
        ),
        // Show the TextField if "Others" is selected
        if (profileController.selectedOccupation.value == "Others")
          Padding(
            padding: const  EdgeInsets.only(top: TSizes.spaceBtwItems),
            child: CustomTextFormField(
              labelText: 'Specify your occupation',
              keyboardType: TextInputType.text,
              controller: profileController.otherOccupationController,
              onChanged: (value) => profileController.otherOccupationController.text = value,
              validator: (value) {
                if (profileController.selectedOccupation.value == "Others" && 
                    (value == null || value.isEmpty)) {
                  return 'Please specify your occupation';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^[a-zA-Z\s]*$')),
              ],
              enabled: profileController.isEditable.value, 
            ),
          ),
      ],
    ));
  }

  Widget _buildDateOfBirthField() {
    return Obx(
       () => GestureDetector(
        onTap: profileController.isEditable.value // Only allow date picker when editable
          ? () {
              DatePickerHelper.showDatePicker(
                context: Get.context!,
                initialDate: profileController.selectedDate.value,
                onDateSelected: profileController.setDate,
                onPressedSave: () {
                  profileController.dobController.text =
                      "${profileController.selectedDate.value.day.toString().padLeft(2, '0')}-${profileController.selectedDate.value.month.toString().padLeft(2, '0')}-${profileController.selectedDate.value.year}";
                  Get.back();
                },
              );
            }
            : null,
        child: AbsorbPointer(
          child: Obx(() => CustomTextFormField(
            labelText: 'Date Of Birth',
            suffixIcon: Icon(Icons.arrow_drop_down,
                size: TDeviceUtils.getScreenWidth(Get.context!) * .05,),
            keyboardType: TextInputType.datetime,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter your date of birth'
                : null,
            controller: profileController.dobController,
            enabled: profileController.isEditable.value, // Disable/Enable based on state
          )),
        )),
    );
  }

  Widget _buildGenderDropdown() {
    return Obx(() => CustomDropdown(
      labelText: 'Gender',
      value: profileController.selectedGender.value,
      items: const [
        DropdownMenuItem(value: "Male", child: Text("Male")),
        DropdownMenuItem(value: "Female", child: Text("Female")),
      ],
       contentPadding: EdgeInsets.symmetric(
        vertical: screenHeight * .017,
        horizontal:screenWidth * .04,
      ),
      enabled: profileController.isEditable.value,
      onChanged: profileController.isEditable.value 
      ? (value) => profileController.selectedGender.value = value!
      : null,  // Set to null when not editable
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your gender';
        }
        return null;
      },
    ));
  }

  Widget _buildPersonWithDisabilitiesDropdown() {
    return Obx(() => CustomDropdown(
      labelText: 'Person with Disabilities',
      value: profileController.selectedPersonWithDisabilities.value,
      items: const [
        DropdownMenuItem(value: "Yes", child: Text("Yes")),
        DropdownMenuItem(value: "No", child: Text("No")),
      ],
       contentPadding: EdgeInsets.symmetric(
        vertical: screenHeight * .017,
        horizontal:screenWidth * .04,
      ),
      enabled: profileController.isEditable.value,
      onChanged: profileController.isEditable.value 
      ? (value) => profileController.selectedPersonWithDisabilities.value = value!
      : null,  // Set to null when not editable
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select your option';
        }
        return null;
      },
    ));
  }

  Widget _buildEditOrSubmitButton() {
    return Align(
      child: Obx(() => Padding(
       padding: const EdgeInsets.symmetric(horizontal: TSizes.xl),
        child: CustomElevatedBtn(
          onPressed: profileController.handleEditSubmitButton,
          child: profileController.isLoading.value
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
                profileController.isEditable.value ? 'Submit' : 'Edit',
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodySmall!
                    .copyWith(
                        color: TColors.white,
                        fontWeight: FontWeight.bold),
              ),
        ),
      )),
    );
  }
}
