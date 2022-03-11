import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

PreferredSize appbarWidget(ThemeData themeData) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(40.0), //appbar size
    child: AppBar(
      bottomOpacity: 0.0,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      backgroundColor: themeData.backgroundColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Image.asset(
        themeData.brightness == Brightness.light
            ? 'assets/sobGOGdark.png'
            : 'assets/sobGOGlight.png',
        height: 3.5.h,
      ),
      centerTitle: true,
    ),
  );
}
