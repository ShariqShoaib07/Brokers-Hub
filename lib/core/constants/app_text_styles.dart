import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Font families
  static const String headingFont = 'Poppins';
  static const String bodyFont = 'Inter';
  static const String monospaceFont = 'RobotoMono';

  // Text scale factor helper
  static double scaledSize(BuildContext context, double fontSize) =>
      fontSize * MediaQuery.textScaleFactorOf(context).clamp(0.8, 1.4);

  // Headings
  static TextStyle headlineLarge(BuildContext context) => TextStyle(
    fontFamily: headingFont,
    fontSize: scaledSize(context, 28),
    fontWeight: FontWeight.w700,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.25,
    letterSpacing: -0.5,
  );

  static TextStyle headlineMedium(BuildContext context) => TextStyle(
    fontFamily: headingFont,
    fontSize: scaledSize(context, 24),
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.3,
    letterSpacing: -0.3,
  );

  static TextStyle headlineSmall(BuildContext context) => TextStyle(
    fontFamily: headingFont,
    fontSize: scaledSize(context, 20),
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.35,
  );

  // Titles
  static TextStyle titleLarge(BuildContext context) => TextStyle(
    fontFamily: headingFont,
    fontSize: scaledSize(context, 18),
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onBackground,
    height: 1.4,
  );

  static TextStyle titleMedium(BuildContext context) => TextStyle(
    fontFamily: headingFont,
    fontSize: scaledSize(context, 16),
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onSurface,
    height: 1.5,
  );

  static TextStyle titleSmall(BuildContext context) => TextStyle(
    fontFamily: headingFont,
    fontSize: scaledSize(context, 14),
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
    height: 1.5,
  );

  // Body text
  static TextStyle bodyLarge(BuildContext context) => TextStyle(
    fontFamily: bodyFont,
    fontSize: scaledSize(context, 16),
    fontWeight: FontWeight.w400,
    color: Theme.of(context).colorScheme.onSurface,
    height: 1.5,
  );

  static TextStyle bodyMedium(BuildContext context) => TextStyle(
    fontFamily: bodyFont,
    fontSize: scaledSize(context, 14),
    fontWeight: FontWeight.w400,
    color: Theme.of(context).colorScheme.onSurface,
    height: 1.5,
  );

  static TextStyle bodySmall(BuildContext context) => TextStyle(
    fontFamily: bodyFont,
    fontSize: scaledSize(context, 12),
    fontWeight: FontWeight.w400,
    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
    height: 1.5,
  );

  // Labels
  static TextStyle labelLarge(BuildContext context) => TextStyle(
    fontFamily: bodyFont,
    fontSize: scaledSize(context, 14),
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onSurface,
    height: 1.4,
  );

  static TextStyle labelMedium(BuildContext context) => TextStyle(
    fontFamily: bodyFont,
    fontSize: scaledSize(context, 12),
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
    height: 1.4,
  );

  static TextStyle labelSmall(BuildContext context) => TextStyle(
    fontFamily: bodyFont,
    fontSize: scaledSize(context, 11),
    fontWeight: FontWeight.w500,
    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
    height: 1.4,
  );

  // Special styles
  static TextStyle neonText(BuildContext context) => TextStyle(
    fontFamily: headingFont,
    fontSize: scaledSize(context, 24),
    fontWeight: FontWeight.w700,
    color: AppColors.accentNeonPurple,
    shadows: [
      Shadow(
        color: AppColors.accentNeonPurple.withOpacity(0.8),
        blurRadius: 8,
        offset: const Offset(0, 0),
      ),
      Shadow(
        color: AppColors.accentNeonBlue.withOpacity(0.6),
        blurRadius: 16,
        offset: const Offset(0, 0),
      ),
    ],
  );

  static TextStyle errorText(BuildContext context) => TextStyle(
    fontFamily: bodyFont,
    fontSize: scaledSize(context, 14),
    fontWeight: FontWeight.w500,
    color: AppColors.errorRed,
    height: 1.4,
  );

  static TextStyle linkText(BuildContext context) => TextStyle(
    fontFamily: bodyFont,
    fontSize: scaledSize(context, 14),
    fontWeight: FontWeight.w500,
    color: AppColors.primaryBlue,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primaryBlue.withOpacity(0.4),
    height: 1.4,
  );

  static TextStyle buttonText(BuildContext context) => TextStyle(
    fontFamily: bodyFont,
    fontSize: scaledSize(context, 14),
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onPrimary,
    height: 1.4,
    letterSpacing: 0.5,
  );

  static TextStyle monospace(BuildContext context) => TextStyle(
    fontFamily: monospaceFont,
    fontSize: scaledSize(context, 14),
    fontWeight: FontWeight.w400,
    color: Theme.of(context).colorScheme.onSurface,
    height: 1.5,
  );

  // Text themes for direct use in ThemeData
  static TextTheme textTheme(BuildContext context) => TextTheme(
    displayLarge: headlineLarge(context),
    displayMedium: headlineMedium(context),
    displaySmall: headlineSmall(context),
    headlineLarge: headlineLarge(context),
    headlineMedium: headlineMedium(context),
    headlineSmall: headlineSmall(context),
    titleLarge: titleLarge(context),
    titleMedium: titleMedium(context),
    titleSmall: titleSmall(context),
    bodyLarge: bodyLarge(context),
    bodyMedium: bodyMedium(context),
    bodySmall: bodySmall(context),
    labelLarge: labelLarge(context),
    labelMedium: labelMedium(context),
    labelSmall: labelSmall(context),
  );
}