import 'package:flutter/material.dart';

import '../helpers/custom_colors.dart';

class CustomDropdownField<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedValue;
  final String Function(T) displayItem; // Function to display items as text
  final String? Function(T?)? validator; // Optional validator function
  final String hint;
  final void Function(T?)? onChanged;

  // Customizable styles
  final Color borderColor;
  final Color fillColor;
  final Color textColor;
  final Color errorBorderColor;
  final Color iconColor;
  final double borderRadius;
  final EdgeInsetsGeometry contentPadding;
  final double fontSize;
  final bool isPriority;

  const CustomDropdownField({
    Key? key,
    required this.items,
    required this.selectedValue,
    required this.displayItem,
    required this.hint,
    this.validator,
    this.onChanged,
    this.borderColor = Colors.transparent,
    this.fillColor = CustomColors.lighterPrimaryColor,
    this.textColor = CustomColors.primaryColor,
    this.errorBorderColor = Colors.red,
    this.iconColor = CustomColors.primaryColor,
    this.borderRadius = 8.0,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.fontSize = 14.0,
    this.isPriority = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Borders for normal and error states
    final OutlineInputBorder inputBorder = OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
      borderRadius: BorderRadius.circular(borderRadius),
    );

    final OutlineInputBorder inputErrorBorder = OutlineInputBorder(
      borderSide: BorderSide(color: errorBorderColor),
      borderRadius: BorderRadius.circular(borderRadius),
    );

    return DropdownButtonFormField<T>(
      value: selectedValue,
      validator: validator,
      hint: Text(hint,
          style: Theme.of(context)
              .primaryTextTheme
              .headlineLarge!
              .copyWith(color: textColor, fontSize: fontSize)),
      decoration: InputDecoration(
        prefix: isPriority
            ? Icon(
                Icons.flag_outlined,
                color: textColor,
                size: 20,
              )
            : null,
        contentPadding: contentPadding,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        errorBorder: inputErrorBorder,
        filled: true,
        fillColor: fillColor,
      ),
      dropdownColor: fillColor,
      iconEnabledColor: iconColor,
      items: items.map((T item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Text("${displayItem(item)} ${isPriority ? "Priority" : ""}",
              style: Theme.of(context)
                  .primaryTextTheme
                  .headlineLarge!
                  .copyWith(color: textColor, fontSize: fontSize)),
        );
      }).toList(),
      // Don't show items when disabled
      onChanged: onChanged,
    );
  }
}
