import 'package:campmart/utils/size.dart';
import 'package:flutter/material.dart';

const primaryColor = Color(0xff2C6236);
const Color secondaryColor = Color(0xFFFFFFFF);
const Color shadowColor = Color(0xFFD7D3D3);

const Color textFormColor = Color(0xFFD9D9D9);
const Color errorColor = Color(0xffDC3545);
const Color textColor = Color(0xff343A40);
const Color textSecondaryColor = Color(0xffA9B4BE);
const Color hintColor = Color(0xff6C757D);

ThemeData theme(BuildContext context) {
  return ThemeData(
    primaryColor: primaryColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: secondaryColor,
      centerTitle: true,
      foregroundColor: primaryColor,
      actionsIconTheme: IconThemeData(
        color: primaryColor,
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: primaryColor,
    ),
    // cardColor: primaryColor.withOpacity(0.1),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
        textStyle: Theme.of(context).textTheme.bodySmall,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      iconSize: SizeConfig.screenHeight,
      foregroundColor: secondaryColor,
    ),

    inputDecorationTheme: InputDecorationTheme(
      hintStyle:
          Theme.of(context).textTheme.bodyLarge!.copyWith(color: hintColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: SizeConfig.screenHeight! * 0.001,
          color: shadowColor,
        ),
        borderRadius: BorderRadius.circular(
          SizeConfig.screenHeight! * 0.01,
        ),
      ),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: SizeConfig.screenHeight! * 0.001,
            color: shadowColor,
          ),
          borderRadius: BorderRadius.circular(
            SizeConfig.screenHeight! * 0.01,
          )),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: SizeConfig.screenWidth! * 0.001,
          color: errorColor,
        ),
        borderRadius: BorderRadius.circular(
          SizeConfig.screenHeight! * 0.01,
        ),
      ),
    ),
  );
}
