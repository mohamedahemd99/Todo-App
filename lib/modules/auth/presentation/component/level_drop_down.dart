import 'package:flutter/material.dart';

import '../../../../core/services/enums.dart';
import '../../../../helpers/app_palette.dart';
import '../../../../helpers/custom_colors.dart';
import '../controller/auth_provider.dart';

class ExperienceDropdownField extends StatelessWidget {
  final OutlineInputBorder inputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: CustomColors.greyAppColor),
    borderRadius: BorderRadius.circular(8),
  );

  final OutlineInputBorder inputErrorBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppPalette.errorColor,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  ExperienceDropdownField({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ExperienceLevel>(
      value: AuthProvider.of(context).selectedLevel,
      validator: (value) {
        if (value != null) {
          return null;
        } else {
          return "The experience Level is Required.";
        }
      },
      hint: Text("Choose experience Level",
          style: Theme.of(context)
              .primaryTextTheme
              .headlineMedium!
              .copyWith(fontSize: 14)),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        errorBorder: inputErrorBorder,
        filled: true,
        fillColor: CustomColors.greyAppColor.withOpacity(0.1),
      ),
      items: ExperienceLevel.values.map((ExperienceLevel level) {
        return DropdownMenuItem<ExperienceLevel>(
          value: level,
          child: Text(AuthProvider.of(context).getExperienceLevelString(level),
              style: Theme.of(context)
                  .primaryTextTheme
                  .headlineMedium!
                  .copyWith(fontSize: 14)),
        );
      }).toList(),
      onChanged: (ExperienceLevel? newValue) {
        AuthProvider.of(context, isListen: false).setLevel(newValue);
      },
    );
  }
}
