import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const primaryClr = bluishClr;

class Themes {
  static final light = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: Colors.white,
    brightness: Brightness.light,
    canvasColor: Colors.white,
    primaryIconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.dark,
      color: Colors.white60,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.grey[500],
      ),
      actionsIconTheme: IconThemeData(color: Colors.grey[900]),
    ),
    // textTheme: TextTheme(
    //   headline1: TextStyle(
    //       fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey[400]),
    // ),
  );

  static final dark = ThemeData(
    primarySwatch: Colors.blue,
    backgroundColor: Colors.black,
    brightness: Brightness.dark,
    canvasColor: Colors.black,
    primaryIconTheme: const IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      color: Colors.grey[900],
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      actionsIconTheme: IconThemeData(color: Colors.grey[900]),
    ),
  );
}

//* public method
//* this can call inside the theme class if styles need to change according to theme
TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
    ),
  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
    ),
  );
}

