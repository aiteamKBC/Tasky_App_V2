import 'package:flutter/material.dart';

ThemeData lighttheme = ThemeData(
  scaffoldBackgroundColor: Color(0XFFF6F7F9),
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primaryContainer: Color(0XFFFFFFFF),
    secondary: Color(0xff161F1B),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0XFFF6F7F9),
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xff161F1B)),
  ),
  switchTheme: SwitchThemeData(
    trackColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0XFF15B86C);
      }
      return Colors.white;
    }),
    thumbColor: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Color(0XFFFFFCFC);
      }
      return Color(0xff9E9E9E);
    }),
    trackOutlineColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return Colors.transparent;
      }
      return Color(0xff9E9E9E);
    }),
    trackOutlineWidth: WidgetStateProperty.resolveWith((states) {
      if (states.contains(WidgetState.selected)) {
        return 0;
      }
      return 2;
    }),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Color((0xff15B86C))),
      foregroundColor: WidgetStateProperty.all(Color(0XFFFFFCFC)),
      textStyle: WidgetStateProperty.all(
        TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          decoration: TextDecoration.none,
        ),
      ),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: const Color(0XFF15B86C),
    foregroundColor: const Color(0XFFFFFCFC),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    extendedTextStyle: TextStyle(decoration: TextDecoration.none),
  ),
  textTheme: TextTheme(
    displaySmall: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0xff161F1B),
      fontWeight: FontWeight.w400,
    ),
    titleSmall: TextStyle(
      color: Color(0xff3A4640),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xff161F1B),
    ),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
    labelLarge: TextStyle(
      color: Color(0xff6A6A6A),

      decoration: TextDecoration.lineThrough,
      overflow: TextOverflow.ellipsis,

      decorationColor: const Color(0xff49454F),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0XFFFFFFFF),
    hintStyle: TextStyle(
      fontSize: 16,
      color: Color(0xff9E9E9E),
      fontWeight: FontWeight.w400,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: .5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Color(0xffD1DAD6)),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: Color(0xffD1DAD6), width: 2),
  ),
  iconTheme: IconThemeData(color: Color(0xff161F1B)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0xff161F1B),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(thickness: 1, color: Color(0xffD1DAD6)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: const Color.fromARGB(255, 73, 138, 75),
    selectionHandleColor: Colors.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xffF6F7F9),
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xff3A4640),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
);
