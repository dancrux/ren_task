import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart'
    show BuildContext, MediaQuery, MediaQueryData;

class _SizeConfig {
  static late MediaQueryData _mediaQueryData;
  _SizeConfig(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }

  double get width {
    return _mediaQueryData.size.shortestSide;
  }

  double get height {
    return _mediaQueryData.size.longestSide;
  }

// Calculates the height as a percentage of the entire screen height
  double setAdjustedHeight(double percentage) {
    if (percentage == 0) {
      return 0;
    }
    return height * (percentage / 100);
  }

// Calculates the width as a percentage of the entire screen width
  double setAdjustedWidth(double percentage) {
    if (percentage == 0) {
      return 0;
    }
    return width * (percentage / 100);
  }
}

// This class handles creating font sizes as percentage of screen size
class _FontSizer {
  late num _scale;
  _FontSizer(BuildContext context) {
    _scale = (MediaQuery.of(context).size.longestSide +
            MediaQuery.of(context).size.shortestSide) /
        4;
  }

  double sp(double? percentage) {
    return (_scale * ((percentage ?? 35.0) / (1000 - 50))).toDouble();
  }
}

class ScaleUtil {
  final BuildContext context;

  ScaleUtil(this.context);

  _SizeConfig get sizer => _SizeConfig(context);
  _FontSizer get fontSizer => _FontSizer(context);
}
