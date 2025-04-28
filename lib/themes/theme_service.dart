import 'package:flutter/material.dart';
import 'package:tambong/themes/color_schemes/dark_theme.dart';
import 'package:tambong/themes/color_schemes/light_theme.dart';
import 'package:tambong/themes/core/app_theme.dart';

class ThemeService {
  static final List<Function(String)> _changeListeners = [];

  static AppColorScheme _currentColorScheme = LightThemeColurScheme();

  static AppColorScheme get currentColorScheme => _currentColorScheme;

  static switchTheme() {
    if (_currentColorScheme.name == 'light') {
      _currentColorScheme = DarkThemeColurScheme();
    } else {
      _currentColorScheme = LightThemeColurScheme();
    }
    _notifyListeners();
  }

  static const TextStyle _normalText = TextStyle(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w100,
  );
  static TextStyle _normalTextLight =
      _normalText.copyWith(color: _currentColorScheme.whiteColor);

  static TextStyle get normalText => _normalText.copyWith(
        color: _currentColorScheme.blackColor,
      );
  static TextStyle get normalTextLight => _normalTextLight;

  static const TextStyle _smallText = TextStyle(
    fontSize: 12,
  );

  static TextStyle get smallText => _smallText.copyWith(
        color: _currentColorScheme.blackColor,
      );

  static const TextStyle _headLine = TextStyle(
    fontSize: 21,
  );

  static TextStyle get headLine => _headLine.copyWith(
        color: _currentColorScheme.blackColor,
      );

  static _notifyListeners() {
    for (Function(String) listener in _changeListeners) {
      listener(_currentColorScheme.name);
    }
  }

  static subscribe(Function(String) listener) => _changeListeners.add(listener);
  static unsubscribe(Function(String) listener) =>
      _changeListeners.remove(listener);
}
