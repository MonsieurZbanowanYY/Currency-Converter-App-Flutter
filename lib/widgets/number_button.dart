import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:sobgog_currency_converter/data/default_values.dart';

Center numberButton(
    String str, Function(String) changeValue, ThemeData themeData) {
  return Center(
    child: GestureDetector(
      onTap: () => changeValue(str),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: themeData.secondaryHeaderColor,
        ),
        width: 20.w,
        child: Center(
          child: Padding(
            padding: paddingAll2,
            child: Text(
              str,
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
