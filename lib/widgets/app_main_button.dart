// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_app/helpers/size_extension.dart';
import 'package:todo_app/widgets/app_size_boxes.dart';

import '../helpers/app_text_styles.dart';
import '../helpers/custom_colors.dart';

class AppMainButton extends StatelessWidget {
  AppMainButton({
    this.translation,
    this.color = CustomColors.primaryColor,
    this.onTap,
    this.fontSize = 15,
    this.imageSize = 25,
    this.image,
    this.fontWeight = FontWeight.normal,
    this.fontFamily,
    this.textDecoration,
    this.border,
    this.padding,
    this.style,
    this.child,
    this.decoration,
    this.margin = 0.0,
    this.imageColor,
    this.elevation = 0.0,
    this.borderColor,
  });

  final String? translation;
  final double fontSize;
  final double imageSize;
  final double margin;
  final FontWeight fontWeight;
  final String? fontFamily;
  final String? image;
  final TextDecoration? textDecoration;
  final BoxDecoration? decoration;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  Color? color;
  Color? imageColor;
  final double elevation;
  Color? borderColor;
  TextStyle? style;
  GestureTapCallback? onTap;
  BorderRadiusGeometry? border;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: margin.w),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        elevation: elevation,
        child: Container(
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
          decoration: decoration ??
              BoxDecoration(
                  color: color,
                  borderRadius: border ?? AppCorners.lgBorder,
                  border: Border.all(color: borderColor ?? color!)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              child ??
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(translation!,
                          maxLines: 1,
                          style: style ??
                              Theme.of(context).textTheme.headlineSmall)),

              if (image != null) 10.widthBox,
              if (image != null) Image.asset(image!)
              //16.widthBox,
            ],
          ),
        ),
      ),
    );
  }
}
