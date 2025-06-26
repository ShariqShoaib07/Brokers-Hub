import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final double? borderRadius;
  final Widget? icon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.isFullWidth = true,
    this.padding,
    this.elevation,
    this.borderRadius,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? colorScheme.primary,
          foregroundColor: textColor ?? colorScheme.onPrimary,
          elevation: elevation ?? 0,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) icon!,
            const SizedBox(width: 8),
            Text(
              label,
              style: AppTextStyles.buttonText(context).copyWith(
                color: textColor ?? colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}