import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_phone_validator/country_phone_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/helpers/custom_colors.dart';
import 'package:todo_app/helpers/size_extension.dart';
import 'package:todo_app/modules/auth/presentation/component/level_drop_down.dart';
import 'package:todo_app/modules/auth/presentation/controller/auth_provider.dart';
import 'package:todo_app/widgets/app_main_button.dart';
import 'package:todo_app/widgets/app_size_boxes.dart';
import 'package:todo_app/widgets/form_fields/app_input_text_field.dart';
import 'package:todo_app/widgets/form_fields/app_password_input_field.dart';

class RegisterComponent extends StatelessWidget {
  const RegisterComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Form(
        key: AuthProvider.of(context).registerFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Register",
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.headlineLarge),
            24.heightBox,
            AppTextInputField(
              controller: AuthProvider.of(context).nameCtrl,
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return "The Name is Required.";
                }
              },
              hintText: "Name...",
            ),
            15.heightBox,
            AppTextInputField(
              keyboardType: TextInputType.phone,
              controller: AuthProvider.of(context).phoneCtrl,
              prefix: CountryCodePicker(
                onChanged: (value) => AuthProvider.of(context, isListen: false)
                    .setCountryCode(value.dialCode),
                initialSelection: 'EG',
                favorite: const ['+20', 'EG'],
                showCountryOnly: false,
                showOnlyCountryWhenClosed: false,
                alignLeft: false,
              ),
              validator: (value) {
                bool isValid = CountryUtils.validatePhoneNumber(
                    AuthProvider.of(context, isListen: false).phoneCtrl!.text,
                    AuthProvider.of(context, isListen: false).countryCode);
                if (isValid) {
                  return null;
                } else {
                  return "The phone number is invalid.";
                }
              },
              hintText: "123 456-7890",
            ),
            15.heightBox,
            AppTextInputField(
              keyboardType: TextInputType.number,
              controller: AuthProvider.of(context).yearsOfExperienceCtrl,
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return "The Years of experience is Required.";
                }
              },
              hintText: "Years of experience...",
            ),
            15.heightBox,
            ExperienceDropdownField(),
            15.heightBox,
            AppTextInputField(
              controller: AuthProvider.of(context).addressCtrl,
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return "The Address is Required.";
                }
              },
              hintText: "Address...",
            ),
            15.heightBox,
            AppPasswordInputField(
              controller: AuthProvider.of(context).passwordCtrl,
              hintText: "password",
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return "The Password is Required.";
                }
              },
            ),
            24.heightBox,
            AppMainButton(
              onTap: () {
                if (AuthProvider.of(context, isListen: false)
                        .registerFormKey
                        .currentState!
                        .validate() &&
                    AuthProvider.of(context, isListen: false).selectedLevel !=
                        null) {
                  AuthProvider.of(context, isListen: false).register(
                      displayName: AuthProvider.of(context, isListen: false)
                          .nameCtrl!
                          .text,
                      address: AuthProvider.of(context, isListen: false)
                          .addressCtrl!
                          .text,
                      experienceYears: int.parse(
                          AuthProvider.of(context, isListen: false)
                              .yearsOfExperienceCtrl!
                              .text),
                      level: AuthProvider.of(context, isListen: false)
                          .selectedLevel!
                          .name,
                      phone:
                          "${AuthProvider.of(context, isListen: false).countryCode}${AuthProvider.of(context, isListen: false).phoneCtrl!.text}",
                      password: AuthProvider.of(context, isListen: false)
                          .passwordCtrl!
                          .text);
                }
              },
              translation: "Sign up",
            ),
            24.heightBox,
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have any account?',
                    style: Theme.of(context).primaryTextTheme.displaySmall!,
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Sign In here!',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .displaySmall!
                            .copyWith(color: CustomColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
