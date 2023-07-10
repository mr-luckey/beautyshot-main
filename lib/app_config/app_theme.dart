import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static Color upColor = const Color(0xff58A225);
  static Color lightGreen = const Color(0xff75E58B);
  static Color downColor = Colors.red;
  static Color primaryColor = const Color(0xff4b6dfc);
  static Color primaryColorLight = const Color(0xffC1BDB7);
  static Color primaryColorDark = const Color(0xff6B6B6B);
  static Color dividerColor = const Color(0xff71717D);
  static Color hintColor = const Color(0xff717D7D);

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    backgroundColor: const Color(0xff07090d),
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    cardColor: const Color(0xff2B2A3B),
    hintColor: hintColor,
    disabledColor: dividerColor,
    dividerColor: dividerColor,

    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(
      TextTheme(
        subtitle1: const TextStyle(),
        subtitle2: TextStyle(color: lightGreen),
        button: TextStyle(color: dividerColor),
        caption: TextStyle(color: dividerColor),
        headline5: const TextStyle(),
        headline6: const TextStyle(fontSize: 22),
        overline: const TextStyle(letterSpacing: 0),
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.grey.shade50,
    primaryColor: primaryColor,
    primaryColorLight: primaryColorLight,
    primaryColorDark: primaryColorDark,
    cardColor: Colors.grey.shade200,
    hintColor: hintColor,
    disabledColor: dividerColor,
    dividerColor: dividerColor,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      centerTitle: true,
      elevation: 0,
    ),
    textTheme: GoogleFonts.interTextTheme(
      TextTheme(
        subtitle1: const TextStyle(),
        subtitle2: TextStyle(color: lightGreen),
        button: TextStyle(color: dividerColor),
        caption: TextStyle(color: dividerColor),
        headline5: const TextStyle(),
        headline6: const TextStyle(fontSize: 22),
        overline: const TextStyle(letterSpacing: 0),
      ),
    ),
  );

  static ShaderCallback shaderCallback = (Rect bounds) => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[primaryColorLight, primaryColorDark],
        tileMode: TileMode.mirror,
      ).createShader(bounds);
}
