import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'color_scheme.dart';

class AppTheme extends Cubit<ThemeData> {
  AppTheme(super.initialState);

  void getAppTheme(Brightness brightness) {
    brightness == Brightness.light
        ? emit(ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
          ))
        : emit(ThemeData(useMaterial3: true, colorScheme: lightColorScheme));
  }
}



/* import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'text_tyles.dart';

class AppTheme {
  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF432575),
        fontFamily: 'Inter',

        ///  below code is for ElevatedButton  ////
        /// You can define your custom theme if you need by applying .copyWith method
        ///
        ///

        iconTheme: const IconThemeData(color: primaryContainer),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xFF432575)),
                textStyle: MaterialStateProperty.all<TextStyle>(
                    const TextStyle()
                        .copyWith(foreground: Paint()..color = white)),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))))),

        /// Icon button theme  ////
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) =>
                    states.contains(MaterialState.pressed) ? grey5 : transparent),
                iconColor: const MaterialStatePropertyAll(Color(0xFF432575)),
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 0, vertical: 14)))),

        ///  below code is for TextButton  ////
        /// You can define your custom theme if you need by applying .copyWith method
        ///
        ///
        textButtonTheme: TextButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.pressed) ? grey5 : transparent), textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle().copyWith(foreground: Paint()..color = primaryContainer)), padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 0, vertical: 14)), overlayColor: MaterialStateProperty.all(grey5))),

        /// below is code for outlined button ////
        ///

        outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle(overlayColor: MaterialStateProperty.all<Color>(hover), side: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.pressed) ? const BorderSide(color: hover) : const BorderSide(color: black)), backgroundColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.pressed) ? hover : black), textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle().copyWith(foreground: Paint()..color = white, fontSize: 15, fontWeight: FontWeight.w400)), padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15, horizontal: 20)))),

        //  For App Bar  /////
        appBarTheme: AppBarTheme(iconTheme: const IconThemeData().copyWith(color: black), titleTextStyle: secMed15.copyWith(fontFamily: "Inter-Regular", fontSize: 18, fontWeight: FontWeight.w500)));
  }
}
 */