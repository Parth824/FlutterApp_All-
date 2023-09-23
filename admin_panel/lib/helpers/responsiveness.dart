import 'package:flutter/material.dart';

const int laragScreenSize = 1366;
const int mediumScreenSize = 768;
const int smallScreenSize = 360;
const int customScrennSize = 1100;

class ResponsivenessWidget extends StatelessWidget {
  final Widget largeScreen;
  Widget? mediumScreen;
  Widget? samllScreen;

  ResponsivenessWidget({
    super.key,
    required this.largeScreen,
    this.mediumScreen,
    this.samllScreen,
  });
  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < smallScreenSize;
  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width < laragScreenSize;
  static bool isLaergScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= laragScreenSize;
  static bool isCostemScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= mediumScreenSize &&
      MediaQuery.of(context).size.width <= customScrennSize;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;

      if (width >= laragScreenSize) {
        return largeScreen;
      } else if (width > mediumScreenSize && width < laragScreenSize) {
        return mediumScreen ?? largeScreen;
      } else {
        return samllScreen ?? largeScreen;
      }
    });
  }
}
