import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tatwei/constants/colors.dart';

class FontStyles {
  static final boldText = GoogleFonts.roboto(
      color: ColorClass.textColor, fontWeight: FontWeight.bold, fontSize: 36);

  static final textFieldText = GoogleFonts.roboto(
      color: ColorClass.textColor, fontWeight: FontWeight.normal, fontSize: 12);

  static final normalText = GoogleFonts.roboto(
      color: ColorClass.textColor, fontWeight: FontWeight.normal, fontSize: 15);

  customText(fontSize, FontWeight fontWeight, Color color) {
    GoogleFonts.roboto(
        color: color, fontWeight: fontWeight, fontSize: fontSize);
  }
}
