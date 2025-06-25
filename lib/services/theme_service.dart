import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeService {
  Future<bool> saveThemeMode(ThemeMode mode);
  Future<ThemeMode> loadThemeMode();
}

class ThemeServiceImplementation implements ThemeService {
  static const String _themeModeKey = 'app_theme_mode';
  final SharedPreferences _prefs;
  final CrashLogger _logger;

  ThemeServiceImplementation({
    required SharedPreferences prefs,
    CrashLogger? logger,
  })  : _prefs = prefs,
        _logger = logger ?? const ProductionCrashLogger();

  @override
  Future<bool> saveThemeMode(ThemeMode mode) async {
    try {
      final value = _convertThemeModeToString(mode);
      return await _prefs.setString(_themeModeKey, value);
    } catch (e, stackTrace) {
      _logger.logError(
        'Failed to save theme mode',
        error: e,
        stackTrace: stackTrace,
      );
      return false;
    }
  }

  @override
  Future<ThemeMode> loadThemeMode() async {
    try {
      final value = _prefs.getString(_themeModeKey);
      return _convertStringToThemeMode(value);
    } catch (e, stackTrace) {
      _logger.logError(
        'Failed to load theme mode',
        error: e,
        stackTrace: stackTrace,
      );
      return ThemeMode.light;
    }
  }

  String _convertThemeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }

  ThemeMode _convertStringToThemeMode(String? value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return ThemeMode.light;
    }
  }
}

// Crash Logger implementation
abstract class CrashLogger {
  const CrashLogger();
  void logError(String message, {dynamic error, StackTrace? stackTrace});
}

class ProductionCrashLogger extends CrashLogger {
  const ProductionCrashLogger();

  @override
  void logError(String message, {dynamic error, StackTrace? stackTrace}) {
    debugPrint('Error: $message');
    if (error != null) debugPrint('Error details: $error');
    if (stackTrace != null) debugPrint('Stack trace: $stackTrace');
    // Add actual crash reporting here (Sentry/Crashlytics)
  }
}

// Factory for dependency injection
class ThemeServiceFactory {
  static Future<ThemeService> create() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return ThemeServiceImplementation(prefs: prefs);
    } catch (e, stackTrace) {
      debugPrint('Failed to initialize SharedPreferences: $e\n$stackTrace');
      return _FallbackThemeService();
    }
  }
}

// Fallback service when SharedPreferences fails
class _FallbackThemeService implements ThemeService {
  ThemeMode _currentMode = ThemeMode.light;

  @override
  Future<bool> saveThemeMode(ThemeMode mode) async {
    _currentMode = mode;
    return true;
  }

  @override
  Future<ThemeMode> loadThemeMode() async => _currentMode;
}

// Mock service for testing
class MockThemeService implements ThemeService {
  ThemeMode? mockMode;
  bool shouldThrow = false;

  @override
  Future<bool> saveThemeMode(ThemeMode mode) async {
    if (shouldThrow) throw Exception('Mock save error');
    mockMode = mode;
    return true;
  }

  @override
  Future<ThemeMode> loadThemeMode() async {
    if (shouldThrow) throw Exception('Mock load error');
    return mockMode ?? ThemeMode.light;
  }
}