import 'package:flutter/material.dart';
import 'package:todo_app/helpers/app_image_paths.dart';
import 'package:todo_app/helpers/preferences/pref_manager.dart';
import 'package:todo_app/widgets/app_main_button.dart';
import 'package:todo_app/widgets/app_size_boxes.dart';

import '../../../../../helpers/custom_colors.dart';
import '../../../../../helpers/navigator.dart';
import '../auth/login_view.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
              child: Image.asset(
            AppImages.art,
            width: double.infinity,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.info_outline),
          )),
          Text("Task Management &\nTo-Do List",
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.headlineLarge),
          16.heightBox,
          Text(
              "This productive tool is designed to help\nyou better manage your task \nproject-wise conveniently!",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .primaryTextTheme
                  .displaySmall!
                  .copyWith(color: CustomColors.subTitleColor, height: 2)),
          32.heightBox,
          AppMainButton(
            onTap: () {
              PrefManager.setIsFirstTime(true);
              popALlAndPushPage(context, const LoginView());
            },
            margin: 20,
            translation: "Let’s Start",
            image: AppImages.arrowRight,
          ),
          60.heightBox,
        ],
      ),
    ));
  }
}
