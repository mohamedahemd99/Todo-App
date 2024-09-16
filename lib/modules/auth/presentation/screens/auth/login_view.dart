import 'package:flutter/material.dart';
import 'package:todo_app/modules/auth/presentation/component/login_component.dart';

import '../../../../../helpers/app_image_paths.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Expanded(
              child: Image.asset(
            AppImages.art,
            width: double.infinity,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.info_outline),
          )),
          const LoginComponent()
        ],
      ),
    ));
  }
}
