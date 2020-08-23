import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ZquareColors {
  static Color pinkBold = Color(0xFFF8A5B4);
  static Color pinkMedium = Color(0xFFFBC7CC);
  static Color pinkRegular = Color(0xFFFCD8DA);
  static Color pinkLight = Color(0xFFFEF3F3);
  static Color purple = Color(0xFFD7D1E5);
}

class ZquareTheme {
  static ThemeData light = ThemeData(
    cardColor: ZquareColors.pinkLight,
    backgroundColor: ZquareColors.pinkRegular,
    buttonColor: ZquareColors.pinkBold,
    textTheme: TextTheme(
      headline1: GoogleFonts.varela(
        color: Colors.black87,
        fontSize: 75,
      ),
      headline2: GoogleFonts.varela(
        color: ZquareColors.pinkBold,
        fontSize: 75,
      ),
      bodyText1: GoogleFonts.varela(
        color: Colors.amber[600],
        fontSize: 28,
      ),
      button: GoogleFonts.varela(
        fontSize: 30,
        color: ZquareColors.pinkLight,
      ),
    ),
    accentColor: Colors.red[300],
    primaryColor: ZquareColors.pinkMedium,
    hintColor: ZquareColors.pinkBold,
  );
  static ThemeData dark = ThemeData.dark().copyWith(
    buttonColor: Colors.yellow[800],
    textTheme: TextTheme(
      headline1: GoogleFonts.varela(
        color: Colors.white70,
        fontSize: 75,
      ),
      headline2: GoogleFonts.varela(
        color: Colors.black54,
        fontSize: 75,
      ),
      bodyText1: GoogleFonts.varela(
        color: Colors.amber[600],
        fontSize: 28,
      ),
      button: GoogleFonts.varela(
        fontSize: 30,
        color: Colors.white,
      ),
    ),
    accentColor: Colors.yellow[800],
    primaryColor: Colors.white38,
    hintColor: Colors.black54,
  );
}
