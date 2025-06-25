import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static const String _themePreferenceKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.light;
  bool _isSystemTheme = false;
  bool _isInitialized = false;

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isSystemTheme => _isSystemTheme;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedTheme = prefs.getString(_themePreferenceKey);

      if (savedTheme == 'system') {
        _isSystemTheme = true;
        _themeMode = ThemeMode.system;
      } else if (savedTheme == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light;
      }

      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      // Fallback to default light theme if there's any error
      _themeMode = ThemeMode.light;
      _isInitialized = true;
      debugPrint('Error loading theme preference: $e');
    }
  }

  Future<void> toggleTheme([ThemeMode? newMode]) async {
    if (newMode != null) {
      _themeMode = newMode;
      _isSystemTheme = newMode == ThemeMode.system;
    } else {
      // Cycle through light → dark → system → light
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.system;
        _isSystemTheme = true;
      } else {
        _themeMode = ThemeMode.light;
        _isSystemTheme = false;
      }
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _themePreferenceKey,
        _isSystemTheme ? 'system' : isDarkMode ? 'dark' : 'light',
      );
    } catch (e) {
      debugPrint('Error saving theme preference: $e');
      // Revert changes if save fails
      if (newMode != null) {
        _themeMode = newMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      } else {
        _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
      }
      // Don't notify listeners since we reverted
      return;
    }

    notifyListeners();
  }

  Future<void> setSystemThemeMode(bool useSystem) async {
    if (_isSystemTheme == useSystem) return;

    _isSystemTheme = useSystem;
    _themeMode = useSystem ? ThemeMode.system :
    isDarkMode ? ThemeMode.dark : ThemeMode.light;

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
        _themePreferenceKey,
        useSystem ? 'system' : isDarkMode ? 'dark' : 'light',
      );
    } catch (e) {
      debugPrint('Error saving system theme preference: $e');
      _isSystemTheme = !useSystem; // Revert change
      return;
    }

    notifyListeners();
  }
}