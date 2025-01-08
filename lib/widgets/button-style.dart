import 'package:flutter/material.dart';

import '../theme/app-colors.dart';


ButtonStyle customElevatedButtonStyle({required double height, required double width,}) {
  return ElevatedButton.styleFrom(
    backgroundColor: AppColors.blue, // Background color
    elevation: 0.5,
    minimumSize: Size(width, height),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
ButtonStyle customElevatedButtonStyleWhite({required double height, required double width,}) {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.grey[300], // Background color
    elevation: 0.5,
    minimumSize: Size(width, height),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );
}


ButtonStyle customElevatedButtonStyleTransparent({
  required double height,
  required double width,
}) {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent, // Transparent background
    elevation: 0.5, // Slight shadow
    minimumSize: Size(width, height), // Button size
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: AppColors.blue, width: 2), // Blue border
    ),
  );
}

