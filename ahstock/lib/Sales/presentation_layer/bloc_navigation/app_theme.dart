import 'package:flutter/material.dart';

enum Mode { Light, Mid, Dark }

class AppTheme extends InheritedWidget {
  // ThemeData currentTheme = light();
  // ModelTheme modelTheme = lightModel;

  const AppTheme({super.key, required super.child});

  static AppTheme of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppTheme>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
