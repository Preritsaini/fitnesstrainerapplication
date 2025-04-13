import 'package:flutter/material.dart';

class ThemeProvider {
  ValueNotifier<bool> isDarkMode = ValueNotifier(false);

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
  }
}