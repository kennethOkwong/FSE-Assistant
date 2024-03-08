import 'package:flutter/material.dart';

Widget sizexBoxH(double value) {
  return SizedBox(height: value);
}

Widget sizexBoxW(double value) {
  return SizedBox(width: value);
}

double deviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double deviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

EdgeInsetsGeometry paddingH(double value) {
  return EdgeInsets.symmetric(horizontal: value);
}

EdgeInsetsGeometry paddingV(double value) {
  return EdgeInsets.symmetric(vertical: value);
}

EdgeInsetsGeometry paddingA(double value) {
  return EdgeInsets.all(value);
}
