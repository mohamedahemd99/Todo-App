import 'package:flutter/material.dart';

import '../../helpers/app_palette.dart';
import 'index.dart';

class AppPasswordInputField extends StatefulWidget {
  const AppPasswordInputField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.prefix,
    this.validator,
    this.border,
    this.maxLength,
    this.labelText,
    this.onChanged,
    this.autofocus = false,
  });
  final String? labelText;

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final bool autofocus;
  final Widget? prefix;
  final int? maxLength;
  final FormFieldValidator<String>? validator;
  final OutlineInputBorder? border;
  final ValueChanged<String>? onChanged;

  @override
  _AppPasswordInputFieldState createState() => _AppPasswordInputFieldState();
}

class _AppPasswordInputFieldState extends State<AppPasswordInputField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return AppTextInputField(
      labelText: widget.labelText,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      prefix: widget.prefix,
      border: widget.border,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      maxLines: 1,
      hintText: widget.hintText,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: obscureText,
      suffixIcon: InkWell(
          onTap: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          child: Icon(
            Icons.visibility,
            color: obscureText
                ? AppPalette.textDisabledColor
                : AppPalette.textDarkColor,
          )),
    );
  }
}
