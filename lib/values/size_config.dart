import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'
    show BuildContext, MediaQuery, MediaQueryData;

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Calculates the height as a percentage of the entire screen height
double getAdjustedHeight(double percentage) {
  double screenHeight = SizeConfig.screenHeight;
  if (percentage == 0) {
    return 0;
  }
  return screenHeight * (percentage / 100);
}

// Calculates the width as a percentage of the entire screen width
double getAdjustedWidth(double percentage) {
  double screenWidth = SizeConfig.screenWidth;
  if (percentage == 0) {
    return 0;
  }
  return screenWidth * (percentage / 100);
}
