import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle headline(BuildContext context) {
    return GoogleFonts.outfit(
      textStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).textTheme.titleLarge?.color, // Use dynamic theme color
      ),
    );
  }

  static TextStyle body(BuildContext context) {
    return GoogleFonts.outfit(
      textStyle: TextStyle(
        fontSize: 14,
        color: Theme.of(context).textTheme.bodyLarge?.color, // Use dynamic theme color
      ),
    );
  }


  static TextStyle textStyle(BuildContext context,double? fontSize,FontWeight fontWeight,Color color) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color, // Use dynamic theme color
      ),
    );
  }

  static TextStyle markerText(double? fontSize,FontWeight fontWeight,Color color) {
    return GoogleFonts.outfit(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color, // Use dynamic theme color
      ),
    );
  }

  static TextStyle button(BuildContext context,Color color) {
    return GoogleFonts.outfit(
      textStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color:color, // Use labelLarge for button text color
      ),
    );
  }
}
