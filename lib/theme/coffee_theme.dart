import 'package:fav_coffee/theme/theme.dart';
import 'package:flutter/material.dart';

class CoffeeTheme {
  const CoffeeTheme();

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      navigationRailTheme: const NavigationRailThemeData(
        labelType: NavigationRailLabelType.none,
        selectedIconTheme: IconThemeData(color: Colors.red),
        unselectedIconTheme: IconThemeData(color: Colors.black),
        groupAlignment: 0,
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: CoffeeColors.primary,
        onPrimary: CoffeeColors.onPrimary,
        secondary: CoffeeColors.secondary,
        onSecondary: CoffeeColors.onSecondary,
        error: CoffeeColors.error,
        onError: CoffeeColors.onError,
        surface: CoffeeColors.surface,
        onSurface: CoffeeColors.onSurface,
      ),
    );
  }
}
