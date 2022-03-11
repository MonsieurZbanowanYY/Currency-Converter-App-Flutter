import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'package:sobgog_currency_converter/data/currencies.dart';
import 'package:sobgog_currency_converter/data/default_values.dart';

Center selectableList(String value, bool isFrom,
    Function(bool, String) changeCurr, ThemeData themeData) {
  return Center(
    child: Container(
      padding: paddingH1,
      decoration: BoxDecoration(
        borderRadius: borderRadius1,
        color: themeData.backgroundColor,
        border: Border.all(
          color: themeData.primaryColor,
        ),
      ),
      width: 35.w,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: const Text(
            'Select',
          ),
          menuMaxHeight: 40.h,
          dropdownColor: themeData.backgroundColor,
          borderRadius: BorderRadius.circular(10),
          style: GoogleFonts.poppins(color: themeData.primaryColor),
          value: value,
          items: currencies.map(
            (String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: GoogleFonts.lato(
                    color: themeData.primaryColor,
                    fontSize: 12.sp,
                  ),
                ),
              );
            },
          ).toList(),
          onChanged: (String? value) {
            changeCurr(isFrom, value.toString());
          },
        ),
      ),
    ),
  );
}
