import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double sWidth;
  static late double sHeight;
  static late double defaultSize;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    sWidth = _mediaQueryData.size.width;
    sHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}
