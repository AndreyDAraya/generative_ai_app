import 'package:flutter/material.dart';

class ColorSchemeProvider extends ChangeNotifier {
  ColorScheme _colorScheme;

  // Constructors
  ColorSchemeProvider({required ColorScheme initialColorScheme})
      : _colorScheme = initialColorScheme;

  // Accessors
  ColorScheme get colorScheme => _colorScheme;

  // Updaters
  void updateColorScheme(ColorScheme newColorScheme) {
    if (newColorScheme != _colorScheme) {
      _colorScheme = newColorScheme;
      notifyListeners();
    }
  }

  // Convenience methods for updating specific colors
  void updatePrimaryColor(Color newPrimary) {
    updateColorScheme(_colorScheme.copyWith(primary: newPrimary));
  }
}
