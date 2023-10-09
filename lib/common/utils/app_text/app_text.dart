import 'package:flutter/material.dart';
import 'package:weather_app/common/utils/app_color/app_color.dart';

class AppText {
  static const fontFamily = 'Poppins';
  static const defaultColor = AppColor.blackColor;

  static TextStyle text8 = TextStyle(
    fontSize: 8,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static TextStyle text10 = TextStyle(
    fontSize: 10,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static TextStyle text12 = TextStyle(
    fontSize: 12,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static TextStyle text14 = TextStyle(
    fontSize: 14,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static TextStyle text16 = TextStyle(
    fontSize: 16,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static TextStyle text18 = TextStyle(
    fontSize: 18,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static TextStyle text20 = TextStyle(
    fontSize: 20,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static TextStyle text24 = TextStyle(
    fontSize: 24,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static TextStyle text32 = TextStyle(
    fontSize: 32,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static TextStyle text48 = TextStyle(
    fontSize: 48,
    color: defaultColor,
    fontWeight: fontWeight['600'],
    fontFamily: fontFamily,
  );

  static Map<String, FontWeight> fontWeight = {
    '100': FontWeight.w100,
    '200': FontWeight.w200,
    '300': FontWeight.w300,
    '400': FontWeight.w400,
    '500': FontWeight.w500,
    '600': FontWeight.w600,
    '700': FontWeight.w700,
    '800': FontWeight.w800,
    '900': FontWeight.w900,
  };
}
