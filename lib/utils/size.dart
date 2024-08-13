import 'package:flutter/material.dart';

class SizeConfig {
  static  MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double?  padding;
  static double? margin;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    padding = _mediaQueryData!.size.width;
    margin = _mediaQueryData!.size.width;
  }
}