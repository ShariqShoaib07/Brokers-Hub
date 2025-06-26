import 'package:flutter/material.dart';
import 'app_colors.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  final Color neonAccent;
  final Color glowEffect;
  final Gradient gradientPrimary;
  final Gradient gradientNeon;
  final Color textPrimary;
  final Color textSecondary;

  const AppThemeColors({
    required this.neonAccent,
    required this.glowEffect,
    required this.gradientPrimary,
    required this.gradientNeon,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  ThemeExtension<AppThemeColors> copyWith({
    Color? neonAccent,
    Color? glowEffect,
    Gradient? gradientPrimary,
    Gradient? gradientNeon,
    Color? textPrimary,
    Color? textSecondary,
  }) {
    return AppThemeColors(
      neonAccent: neonAccent ?? this.neonAccent,
      glowEffect: glowEffect ?? this.glowEffect,
      gradientPrimary: gradientPrimary ?? this.gradientPrimary,
      gradientNeon: gradientNeon ?? this.gradientNeon,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  ThemeExtension<AppThemeColors> lerp(
      ThemeExtension<AppThemeColors>? other,
      double t,
      ) {
    if (other is! AppThemeColors) {
      return this;
    }
    return AppThemeColors(
      neonAccent: Color.lerp(neonAccent, other.neonAccent, t)!,
      glowEffect: Color.lerp(glowEffect, other.glowEffect, t)!,
      gradientPrimary: Gradient.lerp(gradientPrimary, other.gradientPrimary, t)!,
      gradientNeon: Gradient.lerp(gradientNeon, other.gradientNeon, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}