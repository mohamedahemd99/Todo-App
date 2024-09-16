import 'package:flutter/material.dart';

import '../../../../../helpers/app_image_paths.dart';
import '../../component/register_component.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Image.asset(
            height: MediaQuery.of(context).size.height * 0.3,
            AppImages.art,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.info_outline),
          ),
          const RegisterComponent()
        ],
      ),
    ));
  }
}
