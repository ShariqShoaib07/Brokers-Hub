import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String badgeText;
  final VoidCallback onTap;
  final Widget? trailing;
  final Widget? child;

  const CustomCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badgeText,
    required this.onTap,
    this.trailing,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: AppTextStyles.titleMedium(context),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  if (trailing != null) trailing!,
                  _StatusBadge(text: badgeText),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: AppTextStyles.bodyMedium(context)?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;

  const _StatusBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color textColor;

    switch (text.toLowerCase()) {
      case 'pending':
        backgroundColor = AppColors.warningYellow.withOpacity(0.2);
        textColor = AppColors.warningYellow;
        break;
      case 'approved':
        backgroundColor = AppColors.successGreen.withOpacity(0.2);
        textColor = AppColors.successGreen;
        break;
      case 'rejected':
        backgroundColor = AppColors.errorRed.withOpacity(0.2);
        textColor = AppColors.errorRed;
        break;
      case 'active':
        backgroundColor = AppColors.successGreen.withOpacity(0.2);
        textColor = AppColors.successGreen;
        break;
      case 'suspended':
        backgroundColor = AppColors.errorRed.withOpacity(0.2);
        textColor = AppColors.errorRed;
        break;
      default:
        backgroundColor = Theme.of(context).colorScheme.surfaceVariant;
        textColor = Theme.of(context).colorScheme.onSurface;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.labelSmall(context)?.copyWith(
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}