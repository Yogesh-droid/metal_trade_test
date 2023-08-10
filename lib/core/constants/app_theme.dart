import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'color_scheme.dart';

class AppTheme extends Cubit<ThemeData> {
  AppTheme(super.initialState);

  void getAppTheme(Brightness brightness) {
    brightness == Brightness.light ? emit(lightTheme) : emit(lightTheme);
  }
}

ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    fontFamily: 'Roboto',
    //  For App Bar  /////
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData().copyWith(),
        backgroundColor: const Color(0xFFFEFDFF),
        surfaceTintColor: const Color(0xFFFEFDFF),
        titleTextStyle: secMed14.copyWith(
            color: const Color(0xFF6750A4),
            fontFamily: "Roboto",
            fontWeight: FontWeight.w500)),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xFFFEFDFF),
      surfaceTintColor: Color(0xFFFEFDFF),
      shadowColor: Color(0xFFFEFDFF),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      surfaceTintColor: Color(0xFFFEFDFF),
      shadowColor: Color(0xFF000000),
      backgroundColor: Color(0xFFFEFDFF),
    ));

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
    );