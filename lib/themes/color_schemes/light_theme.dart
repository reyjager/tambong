import 'package:flutter/material.dart';

import '../core/app_theme.dart';

class LightThemeColurScheme implements AppColorScheme {
  final MaterialColor _primaryColor =
      MaterialColor(const Color(0xFF03046A).value, const {
    50: Color.fromRGBO(3, 4, 106, .1),
    100: Color.fromRGBO(3, 4, 106, .2),
    200: Color.fromRGBO(3, 4, 106, .3),
    300: Color.fromRGBO(3, 4, 106, .4),
    400: Color.fromRGBO(3, 4, 106, .5),
    500: Color.fromRGBO(3, 4, 106, 0.6),
    600: Color.fromRGBO(3, 4, 106, .7),
    700: Color.fromRGBO(3, 4, 106, .8),
    800: Color.fromRGBO(3, 4, 106, .9),
    900: Color.fromRGBO(3, 4, 106, 1),
  });

  @override
  MaterialColor get primaryColor => _primaryColor;

  final MaterialColor _blackColor = const MaterialColor(0xFF000000, {});

  @override
  MaterialColor get blackColor => _blackColor;

  final MaterialColor _whiteColor = const MaterialColor(0xFFFFFFFF, {});

  @override
  MaterialColor get whiteColor => _whiteColor;

  final MaterialColor _dangerColor =
      const MaterialColor(0xFFAF3535, {100: Color(0xFFFFE8E8)});

  @override
  MaterialColor get dangerColor => _dangerColor;

  final MaterialColor _warningColor = const MaterialColor(0xFFECC64C, {
    100: Color(0xFFFFFFFF),
    200: Color(0xFFFFF5D2),
  });

  @override
  MaterialColor get warningColor => _warningColor;

  final MaterialColor _infoColor =
      const MaterialColor(0xFF4D95D6, {100: Color(0xFFC4DCF2)});

  @override
  MaterialColor get infoColor => _infoColor;

  final MaterialColor _successColor =
      const MaterialColor(0xFF22A478, {100: Color(0xFFC1F3E2)});

  @override
  MaterialColor get successColor => _successColor;

  final MaterialColor _backgroundColor = const MaterialColor(0xFFF2F2F2, {
    100: Color(0xFFF2F2F2),
    200: Color(0xFFDFDFDF),
    300: Color(0xFFC0C0C0),
    400: Color(0xFF6C6C6C),
    50: Color(0xFFE8F4F5),
  });

  @override
  MaterialColor get backgroundColor => _backgroundColor;

  final MaterialColor _primaryBlue = const MaterialColor(0xFF1881C5, {
    100: Color(0xFF1881C5),
    200: Color(0xFF0F3951),
  });

  @override
  MaterialColor get primaryBlue => _primaryBlue;

  final MaterialColor _primaryOrange = const MaterialColor(0xFFD47F11, {
    100: Color(0xFF1881C5),
  });

  @override
  MaterialColor get primaryOrange => _primaryOrange;

  final MaterialColor _secondaryColor = const MaterialColor(0xFF6A1B9A, {
    100: Color(0xFFF3E5F5),
    200: Color(0xFFCE93D8),
  });

  @override
  MaterialColor get secondaryColor => _secondaryColor;

  @override
  String get name => 'light';
}
