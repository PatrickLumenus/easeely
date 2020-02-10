/// ===================================
/// Device
/// ===================================
///
/// Gives device information.
///
/// ====================================

import "package:flutter/material.dart";

class Device with ChangeNotifier {
  Device() {
    //
  }

  Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  double heightFromPercentage(BuildContext context, double percentage,
      {double appBarHeight}) {
    double res = 0.0;

    if (percentage > 1.0) {
      // just assume they mean 100 percent.
      percentage = 1.0;
    }

    if (appBarHeight == null) {
      appBarHeight = 0.0;
    }

    if (percentage > 0.0) {
      double deviceHeight = this.screenSize(context).height;

      res = (deviceHeight - appBarHeight - this.padding(context).top) *
          percentage;
    }

    return res;
  }

  double widthFromPercentage(BuildContext context, double percentage) {
    double res = 0.0;

    if (percentage > 1.0) {
      // just assume they mean 100 percent.
      percentage = 1.0;
    }

    if (percentage > 0.0) {
      double deviceWidth = this.screenSize(context).width;
      res = deviceWidth * percentage;
    }

    return res;
  }

  EdgeInsets padding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// determines if the user has enabled accessible navigation, like VoiceOver.
  bool enabledAccessibleNavigation(BuildContext context) {
    return MediaQuery.of(context).accessibleNavigation;
  }

  /// determine if you should use 24-hour when formatting time.
  bool enabled24HourTimeFormat(BuildContext context) {
    return MediaQuery.of(context).alwaysUse24HourFormat;
  }

  /// determines if the platform is requesting all text be bold font. 
  bool enabledBoldText(BuildContext context) {
    return MediaQuery.of(context).boldText;
  }

  /// gets the device pixel ratio
  double pixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// determines if the device has requested all animations be disabled.
  
  bool animationsDisabled(BuildContext context) {
    return MediaQuery.of(context).disableAnimations;
  }

  /// determine if the device has inverted colors.
  bool colorsInverted(BuildContext context) {
    return MediaQuery.of(context).invertColors;
  }

  /// gets the device orientation.
  Orientation orientation(BuildContext context) {
    return MediaQuery.of(context).orientation;
  }

  /// get the maimum elevation the device allows
  
  double physicalDepth(BuildContext context) {
    return MediaQuery.of(context).physicalDepth;
  }

  /// gets the device brightness
  Brightness brightness(BuildContext context) {
    return MediaQuery.of(context).platformBrightness;
  }

  /// gets the device text scale factor
  
  double textScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }
}