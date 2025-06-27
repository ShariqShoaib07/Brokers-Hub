import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final Color? color;
  final double? size;
  final double? strokeWidth;
  final EdgeInsetsGeometry padding;

  const LoadingSpinner({
    super.key,
    this.color,
    this.size,
    this.strokeWidth,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? Theme.of(context).colorScheme.primary,
            ),
            strokeWidth: strokeWidth ?? 4.0,
          ),
        ),
      ),
    );
  }
}