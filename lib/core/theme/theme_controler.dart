import 'package:flutter/material.dart';
import 'package:taskyapp/core/services/preferences_manger.dart';

class ThemeControler {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(
    ThemeMode.dark,
  );
  init() {
    bool result = PreferencesManger().getBool("theme") ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManger().setBool("theme", false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManger().setBool("theme", true);
    }
  }

 static bool isDark() => themeNotifier.value == ThemeMode.dark;
}
