import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/modules/todo/presentation/screens/home/home_view.dart';

import '../../../../../helpers/app_image_paths.dart';
import '../../../../../helpers/custom_colors.dart';
import '../../../../../helpers/preferences/pref_manager.dart';
import '../auth/login_view.dart';
import '../onboarding/onboarding_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 200,
        animationDuration: const Duration(seconds: 3),
        duration: 1200,
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: CustomColors.primaryColor,
        splash: AppImages.logo,
        nextScreen: !PrefManager.getFirstTimeLunch()!
            ? const OnboardingView()
            : PrefManager.getToken() == null
                ? const LoginView()
                : const HomeView()); //select language App
  }
}
