import 'package:flutter/material.dart';

class AppColors {
  // Common colors (used in both themes)
  static const Color primaryBlue = Color(0xFF2962FF);
  static const Color secondaryPurple = Color(0xFF7C4DFF);
  static const Color accentNeonPurple = Color(0xFFBC13FE);
  static const Color accentNeonBlue = Color(0xFF00F5FF);
  static const Color errorRed = Color(0xFFE53935);
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningYellow = Color(0xFFFFC107);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightPrimaryVariant = Color(0xFF0039CB);
  static const Color lightSecondaryVariant = Color(0xFF651FFF);
  static const Color lightOnBackground = Color(0xFF212121);
  static const Color lightOnSurface = Color(0xFF424242);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightOnSecondary = Color(0xFFFFFFFF);
  static const Color lightOnError = Color(0xFFFFFFFF);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkPrimaryVariant = Color(0xFF82B1FF);
  static const Color darkSecondaryVariant = Color(0xFFB388FF);
  static const Color darkOnBackground = Color(0xFFE0E0E0);
  static const Color darkOnSurface = Color(0xFFEEEEEE);
  static const Color darkOnPrimary = Color(0xFF000000);
  static const Color darkOnSecondary = Color(0xFF000000);
  static const Color darkOnError = Color(0xFF000000);

  // Text colors
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFBDBDBD);

  // Component colors
  static const Color buttonPrimary = primaryBlue;
  static const Color buttonSecondary = secondaryPurple;
  static const Color buttonDisabled = Color(0xFFBDBDBD);
  static const Color cardLight = lightSurface;
  static const Color cardDark = Color(0xFF252525);
  static const Color dividerLight = Color(0xFFEEEEEE);
  static const Color dividerDark = Color(0xFF424242);

  // Alert/status colors
  static const Color alertInfo = Color(0xFF2196F3);
  static const Color alertSuccess = successGreen;
  static const Color alertWarning = warningYellow;
  static const Color alertError = errorRed;

  // Special effects
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color neonEffect = accentNeonPurple;
  static const Color glowEffect = Color(0x55BC13FE); // 33% opacity

  // Gradient colors
  static const Gradient primaryGradient = LinearGradient(
    colors: [primaryBlue, secondaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient neonGradient = LinearGradient(
    colors: [accentNeonBlue, accentNeonPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadow colors
  static const Color shadowLight = Color(0x33000000);
  static const Color shadowDark = Color(0x66000000);
}