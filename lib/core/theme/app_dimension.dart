import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppDimension {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late bool isTablet;
  static late bool isTabletLandscape;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;

    // Check if device is a tablet based on diagonal
    final bool isTabletDevice = _isTablet(context);

    // Check orientation
    final bool isLandscape =
        _mediaQueryData.orientation == Orientation.portrait;

    // A tablet in landscape mode should be treated as a phone for UI sizing
    isTabletLandscape = isTabletDevice && isLandscape;
    isTablet = isTabletDevice && !isLandscape;
  }

  // Determine if device is a tablet based on screen diagonal
  static bool _isTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final diagonal = math.sqrt(
      size.width * size.width + size.height * size.height,
    );
    return diagonal > 1200; // roughly distinguishes tablet from phone
  }

  // Helper method to get the appropriate size based on device type and orientation
  static T _getSize<T>({required T phone, required T tablet}) {
    return isTablet ? tablet : phone;
  }

  // daily forecast card Dimention
  static double get forecastCardHigh => _getSize(phone: 150.0, tablet: 200.0);
  static double get forecastCardWidth => _getSize(phone: 55.0, tablet: 70.0);

  // card svg size
  static double get cardSvgSize => _getSize(phone: 25.0, tablet: 50.0);

  // icon size
  static double get cardTitleIconSize => _getSize(phone: 18.0, tablet: 24.0);

  // card title font size
  static double get cardContentLarge => _getSize(phone: 44.0, tablet: 65.0);
  static double get cardContentMedium => _getSize(phone: 22.0, tablet: 30.0);
  static double get cardContentSmall => _getSize(phone: 14.0, tablet: 20.0);

  // card padding
  static EdgeInsetsGeometry get cardPadding =>
      _getSize(phone: EdgeInsets.all(15), tablet: EdgeInsets.all(25));

  // card margin
  static EdgeInsetsGeometry get cardMargin =>
      _getSize(phone: EdgeInsets.all(10), tablet: EdgeInsets.all(15));

  // sunrise sunset Dimention
  static double get nightHight => _getSize(phone: 70.0, tablet: 110.0);

  // wind Dimention
  static double get windArrowSvgSize => _getSize(phone: 125.0, tablet: 200.0);

  // air quality Dimention
  static double get airQualityBarHight => _getSize(phone: 7.0, tablet: 13.0);
  static double get indicatorHight => _getSize(phone: 18.0, tablet: 30.0);

  // uv index Dimention
  static double get uvIndexCircleSize => _getSize(phone: 13.0, tablet: 23.0);
  static double get uvIndexColumnSize => _getSize(phone: 45.0, tablet: 110.0);
}
