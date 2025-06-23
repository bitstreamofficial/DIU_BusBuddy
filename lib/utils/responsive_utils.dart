import 'package:flutter/material.dart';

/// Utility class for responsive design and MediaQuery helpers
class ResponsiveUtils {
  /// Screen size breakpoints
  static const double tabletBreakpoint = 600.0;
  static const double landscapeTabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;

  /// Get screen size information
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Check if device is tablet
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > tabletBreakpoint;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > size.height;
  }

  /// Check if device is a landscape tablet
  static bool isLandscapeTablet(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return size.width > landscapeTabletBreakpoint && isLandscape(context);
  }

  /// Check if device is desktop
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > desktopBreakpoint;
  }

  /// Get responsive horizontal padding
  static double getHorizontalPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (isDesktop(context)) {
      return screenWidth * 0.2;
    } else if (isTablet(context)) {
      return screenWidth * 0.15;
    } else {
      return screenWidth * 0.08;
    }
  }

  /// Get responsive vertical padding
  static double getVerticalPadding(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    if (isTablet(context)) {
      return screenHeight * 0.04;
    } else {
      return screenHeight * 0.03;
    }
  }

  /// Get responsive font size for titles
  static double getTitleFontSize(
    BuildContext context, {
    double baseSize = 24.0,
  }) {
    if (isDesktop(context)) {
      return baseSize * 1.3;
    } else if (isTablet(context)) {
      return baseSize * 1.1;
    } else if (isLandscape(context)) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }

  /// Get responsive font size for subtitles
  static double getSubtitleFontSize(
    BuildContext context, {
    double baseSize = 16.0,
  }) {
    if (isDesktop(context)) {
      return baseSize * 1.2;
    } else if (isTablet(context)) {
      return baseSize * 1.1;
    } else if (isLandscape(context)) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }

  /// Get responsive font size for body text
  static double getBodyFontSize(
    BuildContext context, {
    double baseSize = 14.0,
  }) {
    if (isDesktop(context)) {
      return baseSize * 1.2;
    } else if (isTablet(context)) {
      return baseSize * 1.1;
    } else if (isLandscape(context)) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }

  /// Get responsive icon size
  static double getIconSize(BuildContext context, {double baseSize = 24.0}) {
    if (isDesktop(context)) {
      return baseSize * 1.3;
    } else if (isTablet(context)) {
      return baseSize * 1.2;
    } else if (isLandscape(context)) {
      return baseSize * 0.9;
    } else {
      return baseSize;
    }
  }

  /// Get responsive button height
  static double getButtonHeight(
    BuildContext context, {
    double baseHeight = 48.0,
  }) {
    if (isDesktop(context)) {
      return baseHeight * 1.3;
    } else if (isTablet(context)) {
      return baseHeight * 1.2;
    } else if (isLandscape(context)) {
      return baseHeight * 0.9;
    } else {
      return baseHeight;
    }
  }

  /// Get responsive spacing
  static double getSpacing(BuildContext context, {double baseSpacing = 16.0}) {
    if (isDesktop(context)) {
      return baseSpacing * 1.5;
    } else if (isTablet(context)) {
      return baseSpacing * 1.2;
    } else if (isLandscape(context)) {
      return baseSpacing * 0.8;
    } else {
      return baseSpacing;
    }
  }

  /// Get responsive border radius
  static double getBorderRadius(
    BuildContext context, {
    double baseRadius = 8.0,
  }) {
    if (isDesktop(context)) {
      return baseRadius * 1.5;
    } else if (isTablet(context)) {
      return baseRadius * 1.2;
    } else {
      return baseRadius;
    }
  }

  /// Get responsive elevation
  static double getElevation(
    BuildContext context, {
    double baseElevation = 4.0,
  }) {
    if (isDesktop(context)) {
      return baseElevation * 1.5;
    } else if (isTablet(context)) {
      return baseElevation * 1.2;
    } else {
      return baseElevation;
    }
  }

  /// Get screen width percentage
  static double getWidthPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.width * (percentage / 100);
  }

  /// Get screen height percentage
  static double getHeightPercentage(BuildContext context, double percentage) {
    return MediaQuery.of(context).size.height * (percentage / 100);
  }

  /// Get responsive card padding
  static EdgeInsets getCardPadding(BuildContext context) {
    final spacing = getSpacing(context, baseSpacing: 16.0);
    return EdgeInsets.all(spacing);
  }

  /// Get responsive button padding
  static EdgeInsets getButtonPadding(BuildContext context) {
    final horizontal = getSpacing(context, baseSpacing: 20.0);
    final vertical = getSpacing(context, baseSpacing: 16.0);
    return EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  }

  /// Get responsive container constraints
  static BoxConstraints getContainerConstraints(
    BuildContext context, {
    double? maxWidth,
    double? maxHeight,
  }) {
    final screenSize = getScreenSize(context);
    return BoxConstraints(
      maxWidth: maxWidth ?? screenSize.width * 0.9,
      maxHeight: maxHeight ?? screenSize.height * 0.8,
    );
  }

  /// Get adaptive text style
  static TextStyle getAdaptiveTextStyle(
    BuildContext context, {
    required double baseFontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: getTitleFontSize(context, baseSize: baseFontSize),
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? Colors.black,
      letterSpacing: letterSpacing,
    );
  }

  /// Get responsive logo size
  static double getLogoSize(BuildContext context, {double baseSize = 120.0}) {
    if (isDesktop(context)) {
      return baseSize * 1.3;
    } else if (isTablet(context)) {
      return baseSize * 1.16; // 140/120 = 1.16
    } else if (isLandscape(context)) {
      return baseSize * 0.83; // 100/120 = 0.83
    } else {
      return baseSize;
    }
  }

  /// Get responsive app bar height
  static double getAppBarHeight(BuildContext context) {
    if (isTablet(context)) {
      return 64.0;
    } else {
      return 56.0;
    }
  }

  /// Get safe area padding
  static EdgeInsets getSafeAreaPadding(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Get keyboard height
  static double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Check if keyboard is visible
  static bool isKeyboardVisible(BuildContext context) {
    return getKeyboardHeight(context) > 0;
  }
}

/// Extension on BuildContext for easier access to responsive utilities
extension ResponsiveContext on BuildContext {
  /// Get screen size
  Size get screenSize => ResponsiveUtils.getScreenSize(this);

  /// Get screen width
  double get screenWidth => ResponsiveUtils.getScreenSize(this).width;

  /// Get screen height
  double get screenHeight => ResponsiveUtils.getScreenSize(this).height;

  /// Check device types
  bool get isTablet => ResponsiveUtils.isTablet(this);
  bool get isLandscape => ResponsiveUtils.isLandscape(this);
  bool get isDesktop => ResponsiveUtils.isDesktop(this);
  bool get isLandscapeTablet => ResponsiveUtils.isLandscapeTablet(this);

  /// Get responsive values
  double get horizontalPadding => ResponsiveUtils.getHorizontalPadding(this);
  double get verticalPadding => ResponsiveUtils.getVerticalPadding(this);

  /// Get percentage-based dimensions
  double widthPercent(double percentage) =>
      ResponsiveUtils.getWidthPercentage(this, percentage);
  double heightPercent(double percentage) =>
      ResponsiveUtils.getHeightPercentage(this, percentage);

  /// Get responsive sizing
  double responsiveFont(double baseSize) =>
      ResponsiveUtils.getTitleFontSize(this, baseSize: baseSize);
  double responsiveIcon(double baseSize) =>
      ResponsiveUtils.getIconSize(this, baseSize: baseSize);
  double responsiveSpacing(double baseSpacing) =>
      ResponsiveUtils.getSpacing(this, baseSpacing: baseSpacing);
  double responsiveRadius(double baseRadius) =>
      ResponsiveUtils.getBorderRadius(this, baseRadius: baseRadius);
}
