import 'package:flutter/material.dart';

import '../core/app_theme.dart';

class DarkThemeColurScheme implements AppColorScheme {
  final MaterialColor _primaryColor = const MaterialColor(0xFF12585E, {
    100: Color(0xFF48B1BA),
    200: Color(0xFF28929B),
    300: Color(0xFF03383C),
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

  final MaterialColor _warningColor =
      const MaterialColor(0xFFD7B53D, {100: Color(0xFFFFF5D2)});

  @override
  MaterialColor get warningColor => _warningColor;

  final MaterialColor _infoColor =
      const MaterialColor(0xFF264797, {100: Color(0xFFEFF4FF)});

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
  });

  @override
  MaterialColor get backgroundColor => _backgroundColor;

  final MaterialColor _primaryBlue = const MaterialColor(0xFF1881C5, {
    100: Color(0xFF1881C5),
  });

  @override
  MaterialColor get primaryBlue => _primaryBlue;

  final MaterialColor _primaryOrange = const MaterialColor(0xFFD47F11, {
    100: Color(0xFF1881C5),
  });

  @override
  MaterialColor get primaryOrange => _primaryOrange;

  final MaterialColor _secondaryColor = const MaterialColor(0xFF6C757D, {
    100: Color(0xFFD6D8DB),
    200: Color(0xFFADB5BD),
    300: Color(0xFF6C757D),
  });

  @override
  MaterialColor get secondaryColor => _secondaryColor;

  @override
  String get name => 'dark';
}
