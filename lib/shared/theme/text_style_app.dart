import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_app.dart';

abstract class ITextStyleApp {
  TextStyle get title;
  TextStyle get subtitle;
  TextStyle get label;
  TextStyle get input;
  TextStyle get hint;
  TextStyle get buttonBackgroundColor;
  TextStyle get buttonBoldTextColor;
  TextStyle get buttonTextColor;
}

class TextStyleApp implements ITextStyleApp {
  @override
  TextStyle get buttonBackgroundColor => GoogleFonts.inter(
        fontSize: 14,
        color: ThemeApp.colors.background,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get buttonBoldTextColor => GoogleFonts.inter(
        fontSize: 14,
        color: ThemeApp.colors.textColor,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get buttonTextColor => GoogleFonts.inter(
        fontSize: 14,
        color: ThemeApp.colors.textColor,
        fontWeight: FontWeight.normal,
      );

  @override
  TextStyle get hint => GoogleFonts.inter(
        fontSize: 14,
        color: ThemeApp.colors.inputNormal,
        fontWeight: FontWeight.normal,
      );

  @override
  TextStyle get input => GoogleFonts.inter(
        fontSize: 16,
        color: ThemeApp.colors.inputNormal,
        fontWeight: FontWeight.normal,
      );

  @override
  TextStyle get label => GoogleFonts.inter(
        fontSize: 16,
        color: ThemeApp.colors.textColor,
        fontWeight: FontWeight.bold,
      );

  @override
  TextStyle get subtitle => GoogleFonts.inter(
      fontSize: 14,
      color: ThemeApp.colors.inputNormal,
      fontWeight: FontWeight.w600);

  @override
  TextStyle get title => GoogleFonts.inter(
      fontSize: 22, color: ThemeApp.colors.title, fontWeight: FontWeight.bold);
}
