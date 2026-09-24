import 'package:flutter/material.dart';

ThemeData darktheme = ThemeData(
  scaffoldBackgroundColor: Color(0XFF181818),
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primaryContainer: Color(0xFF282828),
    secondary: Color(0xffC6C6C6),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0XFF181818),
    titleTextStyle: TextStyle(
      color: Color(0xffFFFCFC),
      fontWeight: FontWeight.w400,
      fontSize: 20,
    ),
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
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
      color: Color(0XFFFFFCFC),
      fontSize: 24,
      fontWeight: FontWeight.w400,
    ),

    titleSmall: TextStyle(
      color: Color(0xffC6C6C6),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      color: Color(0XFFFFFFFF),
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(
      color: Color(0xffFFFCFC),
      fontSize: 32,
      fontWeight: FontWeight.w400,
    ),

    titleMedium: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xfffffcfc),
    ),
    labelMedium: TextStyle(color: Colors.white, fontSize: 16),
    labelLarge: TextStyle(
      color: Color(0xffFFFCFC),
      decoration: TextDecoration.lineThrough,
      overflow: TextOverflow.ellipsis,
      decorationColor: const Color(0xffA0A0A0),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0XFF282828),
    hintStyle: TextStyle(
      fontSize: 16,
      color: Color(0xff6D6D6D),
      fontWeight: FontWeight.w400,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: Colors.red, width: .5),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    side: BorderSide(color: Color(0xff6E6E6E), width: 2),
  ),
  iconTheme: IconThemeData(color: Color(0xffFFFCFC)),
  listTileTheme: ListTileThemeData(
    titleTextStyle: TextStyle(
      color: Color(0XFFFFFCFC),
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  ),
  dividerTheme: DividerThemeData(thickness: 1, color: Color(0xff6E6E6E)),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.white,
    selectionColor: const Color.fromARGB(255, 73, 138, 75),
    selectionHandleColor: Colors.white,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Color(0xff181818),
    selectedItemColor: Color(0xff15B86C),
    unselectedItemColor: Color(0xffC6C6C6),
    type: BottomNavigationBarType.fixed,
  ),
  splashFactory: NoSplash.splashFactory,
);
