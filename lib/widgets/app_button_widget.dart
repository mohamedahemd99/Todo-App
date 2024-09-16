import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? backgroundColor, textColor, borderColor;
  final String? name;
  final bool isRadius;
  final TextStyle? textstyle;

  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    this.textColor,
    required this.name,
    this.isRadius = true,
    this.textstyle,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsetsDirectional.symmetric(horizontal: 2),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isRadius ? 2 : 0,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
          border:
              Border.all(color: borderColor ?? Theme.of(context).primaryColor)),
      child: TextButton(
        onPressed: onPressed,
        child: FittedBox(
          child: Text(name!,
              style: textstyle ??
                  Theme.of(context)
                      .primaryTextTheme
                      .displayMedium!
                      .copyWith(color: textColor, fontWeight: FontWeight.w400)),
        ),
      ),
    );
  }
}
