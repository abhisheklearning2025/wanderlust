import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Ghost border corner accents like in the splash screen.
class CornerAccents extends StatelessWidget {
  final double inset;
  final double size;

  const CornerAccents({super.key, this.inset = 32, this.size = 48});

  @override
  Widget build(BuildContext context) {
    const borderColor = AppColors.ghostBorder;
    const borderWidth = 1.0;

    return Stack(
      children: [
        // Top-left
        Positioned(
          top: inset,
          left: inset,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor, width: borderWidth),
                left: BorderSide(color: borderColor, width: borderWidth),
              ),
            ),
          ),
        ),
        // Top-right
        Positioned(
          top: inset,
          right: inset,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor, width: borderWidth),
                right: BorderSide(color: borderColor, width: borderWidth),
              ),
            ),
          ),
        ),
        // Bottom-left
        Positioned(
          bottom: inset,
          left: inset,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: borderColor, width: borderWidth),
                left: BorderSide(color: borderColor, width: borderWidth),
              ),
            ),
          ),
        ),
        // Bottom-right
        Positioned(
          bottom: inset,
          right: inset,
          child: Container(
            width: size,
            height: size,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: borderColor, width: borderWidth),
                right: BorderSide(color: borderColor, width: borderWidth),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
