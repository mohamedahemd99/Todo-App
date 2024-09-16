import 'package:flutter/material.dart';

import '../helpers/app_text_styles.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    this.translation,
    this.color = Colors.transparent,
    this.textColor = Colors.white,
    this.onTap,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
    this.textDecoration,
    this.border,
    this.padding,
    this.child,
    this.decoration,
    this.iconData,
    this.borderColor,
  });

  final String? translation;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final String? fontFamily;
  final TextDecoration? textDecoration;
  final BoxDecoration? decoration;
  final Widget? child;
  final String? iconData;
  final EdgeInsetsGeometry? padding;
  Color? color;
  Color? borderColor;
  TextStyle? style;
  GestureTapCallback? onTap;
  BorderRadiusGeometry? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        decoration: decoration ??
            BoxDecoration(
                color: color,
                borderRadius: border ?? AppCorners.lgBorder,
                border: Border.all(color: borderColor ?? color!)),
        child: child ??
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  translation!,
                  style: style ??
                      AppTextStyles.title1.copyWith(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize,
                      ),
                ),
                Icon(
                  Icons.arrow_forward,
                  size: 35,
                  color: textColor,
                )
              ],
            ),
      ),
    );
  }
}
