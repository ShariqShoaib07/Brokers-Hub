import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final double iconSize;
  final Widget? action;
  final EdgeInsetsGeometry padding;

  const EmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.iconSize = 64,
    this.action,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: padding,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: iconSize,
                color: iconColor ?? colorScheme.onSurface.withOpacity(0.5),
              ),
            if (icon != null) const SizedBox(height: 16),
            Text(
              title,
              style: AppTextStyles.titleMedium(context)?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) const SizedBox(height: 8),
            if (subtitle != null)
              Text(
                subtitle!,
                style: AppTextStyles.bodyMedium(context)?.copyWith(
                  color: colorScheme.onSurface.withOpacity(0.6),
                ),
                textAlign: TextAlign.center,
              ),
            if (action != null) const SizedBox(height: 24),
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}