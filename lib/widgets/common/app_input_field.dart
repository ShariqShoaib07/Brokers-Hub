import 'package:flutter/material.dart';
import 'package:brokers_hub/core/constants/app_colors.dart';
import 'package:brokers_hub/core/constants/app_text_styles.dart';

class AppInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool? enabled;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final FocusNode? focusNode;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;

  const AppInputField({
    super.key,
    this.controller,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.enabled,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.border,
    this.fillColor,
    this.filled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          maxLines: maxLines,
          minLines: minLines,
          maxLength: maxLength,
          enabled: enabled,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          autofocus: autofocus,
          textCapitalization: textCapitalization,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurface,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            helperText: helperText,
            errorText: errorText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            filled: filled,
            fillColor: fillColor ?? colorScheme.surfaceVariant,
            border: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
            enabledBorder: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorScheme.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 1.5,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: colorScheme.error,
                width: 1.5,
              ),
            ),
            hintStyle: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withOpacity(0.6),
            ),
            errorStyle: textTheme.bodySmall?.copyWith(
              color: colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}