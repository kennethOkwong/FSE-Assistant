import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color? color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      fontWeight: fontWeight,
      color: color);
}

TextStyle getLightStyle(
    // TODO: add const color for all, you can easily add scalling for fonts here too on the fontSize
    {double fontSize = FontSize.s12,
    Color? color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.light, color);
}

TextStyle getRegularStyle({double fontSize = FontSize.s14, Color? color}) {
  return _getTextStyle(
      fontSize.sp, FontConstants.fontFamily, FontWeightManager.regular, color);
}

TextStyle getMediumStyle({double fontSize = FontSize.s12, Color? color}) {
  return _getTextStyle(
      fontSize.sp, FontConstants.fontFamily, FontWeightManager.medium, color);
}

TextStyle getSemiBoldStyle({double fontSize = FontSize.s12, Color? color}) {
  return _getTextStyle(
      fontSize.sp, FontConstants.fontFamily, FontWeightManager.semiBold, color);
}

TextStyle getBoldStyle({double fontSize = FontSize.s12, Color? color}) {
  return _getTextStyle(
      fontSize.sp, FontConstants.fontFamily, FontWeightManager.bold, color);
}

TextStyle getExtraBoldStyle({double fontSize = FontSize.s12, Color? color}) {
  return _getTextStyle(fontSize.sp, FontConstants.fontFamily,
      FontWeightManager.extraBold, color);
}

TextStyle getThickStyle({double fontSize = FontSize.s12, Color? color}) {
  return _getTextStyle(
      fontSize.sp, FontConstants.fontFamily, FontWeightManager.thick, color);
}
