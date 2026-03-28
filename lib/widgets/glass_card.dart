import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final double blurSigma;
  final Color? backgroundColor;
  final bool showGhostBorder;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.blurSigma = 20,
    this.backgroundColor,
    this.showGhostBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(16);

    return ClipRRect(
      borderRadius: radius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding ?? const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.glassBackground,
            borderRadius: radius,
            border: showGhostBorder
                ? Border.all(color: AppColors.ghostBorder)
                : null,
            boxShadow: const [
              BoxShadow(
                color: AppColors.organicShadow,
                blurRadius: 48,
                offset: Offset(0, 24),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
