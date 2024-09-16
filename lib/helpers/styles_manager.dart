import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _style(double fontSize, String fontFamily, Color color,
    FontWeight fontWeight, double lineHeight) {
  return TextStyle(
      height: lineHeight,
      fontSize: fontSize,
      color: color,
      fontFamily: fontFamily,
      fontWeight: fontWeight);
}

// regular style
TextStyle getRegularStyle({
  double fontSize = FontSize.s12,
  double lineHeight = 1.5,
  Color color = Colors.white,
}) {
  return _style(fontSize, FontConstants.fontFamily, color,
      FontWeightManager.regular, lineHeight);
}

// light style
TextStyle getLightStyle({
  double fontSize = FontSize.s12,
  Color color = Colors.white,
  double lineHeight = 1.5,
}) {
  return _style(fontSize, FontConstants.fontFamily, color,
      FontWeightManager.light, lineHeight);
}

// medium style
TextStyle getMediumStyle({
  double fontSize = FontSize.s12,
  Color color = Colors.white,
  double lineHeight = 1.5,
}) {
  return _style(fontSize, FontConstants.fontFamily, color,
      FontWeightManager.medium, lineHeight);
}

// semi bold style
TextStyle getSemiBoldStyle({
  double fontSize = FontSize.s12,
  double lineHeight = 1.5,
  Color color = Colors.white,
}) {
  return _style(fontSize, FontConstants.fontFamily, color,
      FontWeightManager.semiBold, lineHeight);
}

// bold style
TextStyle getBoldStyle({
  double fontSize = FontSize.s12,
  double lineHeight = 1.5,
  Color color = Colors.white,
}) {
  return _style(fontSize, FontConstants.fontFamily, color,
      FontWeightManager.bold, lineHeight);
}

// title style
TextStyle getMainTitleStyle({
  double fontSize = FontSize.s35,
  double lineHeight = 1.5,
  Color color = Colors.white,
}) {
  return _style(fontSize, FontConstants.fontFamily, color,
      FontWeightManager.medium, lineHeight);
}

// sub title style
TextStyle getSubTitleStyle({
  double fontSize = FontSize.s16,
  Color color = Colors.white,
  double lineHeight = 1.5,
}) {
  return _style(fontSize, FontConstants.fontFamily, color,
      FontWeightManager.light, lineHeight);
}

// label style
TextStyle getLableStyle({
  double fontSize = FontSize.s21,
  Color color = Colors.white,
  double lineHeight = 1.5,
}) {
  return _style(fontSize, FontConstants.fontFamily, color,
      FontWeightManager.medium, lineHeight);
}

// button style
TextStyle getButtonStyle({
  double fontSize = FontSize.s20,
  Color color = Colors.white,
  double lineHeight = 1.5,
}) {
  return _style(fontSize, FontConstants.fontFamily, color,
      FontWeightManager.medium, lineHeight);
}
