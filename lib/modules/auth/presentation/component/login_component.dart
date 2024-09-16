import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_phone_validator/country_phone_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/helpers/custom_colors.dart';
import 'package:todo_app/helpers/navigator.dart';
import 'package:todo_app/helpers/size_extension.dart';
import 'package:todo_app/modules/auth/presentation/controller/auth_provider.dart';
import 'package:todo_app/modules/auth/presentation/screens/auth/register_view.dart';
import 'package:todo_app/widgets/app_main_button.dart';
import 'package:todo_app/widgets/app_size_boxes.dart';
import 'package:todo_app/widgets/form_fields/app_input_text_field.dart';
import 'package:todo_app/widgets/form_fields/app_password_input_field.dart';

class LoginComponent extends StatelessWidget {
  const LoginComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Form(
        key: AuthProvider.of(context).loginFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Login",
                textAlign: TextAlign.center,
                style: Theme.of(context).primaryTextTheme.headlineLarge),
            24.heightBox,
            AppTextInputField(
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
            20.heightBox,
            AppPasswordInputField(
              controller: AuthProvider.of(context).passwordCtrl,
              hintText: "password",
              validator: (value) {
                if (value!.isNotEmpty) {
                  return null;
                } else {
                  return "please fill the field";
                }
              },
            ),
            24.heightBox,
            AppMainButton(
              onTap: () {
                if (AuthProvider.of(context, isListen: false)
                    .loginFormKey
                    .currentState!
                    .validate()) {
                  AuthProvider.of(context, isListen: false).loginUser(
                      phone:
                          "${AuthProvider.of(context, isListen: false).countryCode}${AuthProvider.of(context, isListen: false).phoneCtrl!.text}",
                      password: AuthProvider.of(context, isListen: false)
                          .passwordCtrl!
                          .text);
                }
              },
              translation: "Sign In",
            ),
            24.heightBox,
            InkWell(
              onTap: () => pushView(context, const RegisterView()),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Didn’t have any account?',
                    style: Theme.of(context).primaryTextTheme.displaySmall!,
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Sign Up here!',
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
