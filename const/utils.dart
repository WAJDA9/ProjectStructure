import 'package:flutter/widgets.dart';

class ScreenSizeUtil {
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  static double getWidthPercentage(double percentage) {
    return screenWidth * percentage / 100;
  }

  static double getHeightPercentage(double percentage) {
    return screenHeight * percentage / 100;
  }
}
