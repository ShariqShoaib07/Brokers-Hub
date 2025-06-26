import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_colors_extension.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    extensions: [_lightAppColors],
    textTheme: _textTheme(_lightColorScheme),
    appBarTheme: _appBarTheme(_lightColorScheme),
    buttonTheme: _buttonTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    textButtonTheme: _textButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme(_lightColorScheme),
    cardTheme: _cardTheme,
    dividerTheme: _dividerTheme(_lightColorScheme),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    extensions: [_darkAppColors],
    textTheme: _textTheme(_darkColorScheme),
    appBarTheme: _appBarTheme(_darkColorScheme),
    buttonTheme: _buttonTheme,
    elevatedButtonTheme: _elevatedButtonTheme,
    textButtonTheme: _textButtonTheme,
    outlinedButtonTheme: _outlinedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme(_darkColorScheme),
    cardTheme: _cardTheme,
    dividerTheme: _dividerTheme(_darkColorScheme),
  );

  // Color Schemes (M3 compliant)
  static final _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primaryBlue,
    onPrimary: AppColors.lightOnPrimary,
    primaryContainer: AppColors.lightPrimaryVariant,
    onPrimaryContainer: AppColors.lightOnPrimary,
    secondary: AppColors.secondaryPurple,
    onSecondary: AppColors.lightOnSecondary,
    secondaryContainer: AppColors.lightSecondaryVariant,
    onSecondaryContainer: AppColors.lightOnSecondary,
    error: AppColors.errorRed,
    onError: AppColors.lightOnError,
    background: AppColors.lightBackground,
    onBackground: AppColors.lightOnBackground,
    surface: AppColors.lightSurface,
    onSurface: AppColors.lightOnSurface,
    surfaceVariant: AppColors.cardLight,
    outline: AppColors.dividerLight,
  );

  static final _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: AppColors.primaryBlue,
    onPrimary: AppColors.darkOnPrimary,
    primaryContainer: AppColors.darkPrimaryVariant,
    onPrimaryContainer: AppColors.darkOnPrimary,
    secondary: AppColors.secondaryPurple,
    onSecondary: AppColors.darkOnSecondary,
    secondaryContainer: AppColors.darkSecondaryVariant,
    onSecondaryContainer: AppColors.darkOnSecondary,
    error: AppColors.errorRed,
    onError: AppColors.darkOnError,
    background: AppColors.darkBackground,
    onBackground: AppColors.darkOnBackground,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    surfaceVariant: AppColors.cardDark,
    outline: AppColors.dividerDark,
  );

  // Custom Theme Extensions
  static final _lightAppColors = AppThemeColors(
    neonAccent: AppColors.accentNeonPurple,
    glowEffect: AppColors.glowEffect,
    gradientPrimary: AppColors.primaryGradient,
    gradientNeon: AppColors.neonGradient,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
  );

  static final _darkAppColors = AppThemeColors(
    neonAccent: AppColors.accentNeonPurple,
    glowEffect: AppColors.glowEffect,
    gradientPrimary: AppColors.primaryGradient,
    gradientNeon: AppColors.neonGradient,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
  );

  // Text Theme (WCAG AA compliant contrast)
  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      color: colorScheme.onBackground,
      height: 1.12,
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      color: colorScheme.onBackground,
      height: 1.16,
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      color: colorScheme.onBackground,
      height: 1.22,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      color: colorScheme.onBackground,
      height: 1.25,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      color: colorScheme.onBackground,
      height: 1.29,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: colorScheme.onBackground,
      height: 1.33,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: colorScheme.onBackground,
      height: 1.27,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: colorScheme.onBackground,
      height: 1.5,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: colorScheme.onSurface.withOpacity(0.8),
      height: 1.43,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurface,
      height: 1.5,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurface,
      height: 1.43,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurface.withOpacity(0.8),
      height: 1.33,
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: colorScheme.onPrimary,
      height: 1.43,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: colorScheme.onPrimary,
      height: 1.33,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: colorScheme.onPrimary,
      height: 1.45,
      letterSpacing: 0.5,
    ),
  );

  // Component Themes
  static final _buttonTheme = ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );

  static final _elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.lightOnPrimary,
      backgroundColor: AppColors.buttonPrimary,
      disabledForegroundColor: AppColors.buttonDisabled,
      disabledBackgroundColor: AppColors.buttonDisabled.withOpacity(0.12),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: _textTheme(_lightColorScheme).labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final _textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryBlue,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      textStyle: _textTheme(_lightColorScheme).labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static final _outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryBlue,
      side: BorderSide(color: AppColors.primaryBlue),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: _textTheme(_lightColorScheme).labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  static InputDecorationTheme _inputDecorationTheme(ColorScheme colorScheme) =>
      InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        errorStyle: _textTheme(colorScheme).bodySmall?.copyWith(
          color: colorScheme.error,
        ),
        hintStyle: _textTheme(colorScheme).bodyLarge?.copyWith(
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
      );

  static final _cardTheme = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    margin: EdgeInsets.zero,
  );

  static AppBarTheme _appBarTheme(ColorScheme colorScheme) => AppBarTheme(
    elevation: 0,
    centerTitle: false,
    backgroundColor: colorScheme.background,
    foregroundColor: colorScheme.onBackground,
    titleTextStyle: _textTheme(colorScheme).titleLarge?.copyWith(
      fontWeight: FontWeight.w600,
    ),
  );

  static DividerThemeData _dividerTheme(ColorScheme colorScheme) =>
      DividerThemeData(
        color: colorScheme.outline.withOpacity(0.12),
        thickness: 1,
        space: 1,
      );

  // Helper to get custom colors from context
  static AppThemeColors appColors(BuildContext context) =>
      Theme.of(context).extension<AppThemeColors>()!;
}

// Custom Theme Extension
@immutable
class _AppThemeColors extends ThemeExtension<_AppThemeColors> {
  final Color neonAccent;
  final Color glowEffect;
  final Gradient gradientPrimary;
  final Gradient gradientNeon;
  final Color textPrimary;
  final Color textSecondary;

  const _AppThemeColors({
    required this.neonAccent,
    required this.glowEffect,
    required this.gradientPrimary,
    required this.gradientNeon,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  ThemeExtension<_AppThemeColors> copyWith({
    Color? neonAccent,
    Color? glowEffect,
    Gradient? gradientPrimary,
    Gradient? gradientNeon,
    Color? textPrimary,
    Color? textSecondary,
  }) {
    return _AppThemeColors(
      neonAccent: neonAccent ?? this.neonAccent,
      glowEffect: glowEffect ?? this.glowEffect,
      gradientPrimary: gradientPrimary ?? this.gradientPrimary,
      gradientNeon: gradientNeon ?? this.gradientNeon,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  ThemeExtension<_AppThemeColors> lerp(
      covariant ThemeExtension<_AppThemeColors>? other,
      double t,
      ) {
    if (other is! _AppThemeColors) {
      return this;
    }
    return _AppThemeColors(
      neonAccent: Color.lerp(neonAccent, other.neonAccent, t)!,
      glowEffect: Color.lerp(glowEffect, other.glowEffect, t)!,
      gradientPrimary: Gradient.lerp(gradientPrimary, other.gradientPrimary, t)!,
      gradientNeon: Gradient.lerp(gradientNeon, other.gradientNeon, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}