import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Renders decorative ambient glow blobs behind content.
class AmbientBackground extends StatelessWidget {
  final List<AmbientBlob> blobs;

  const AmbientBackground({super.key, required this.blobs});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: blobs.map((blob) {
        return Positioned(
          top: blob.top != null ? size.height * blob.top! : null,
          bottom: blob.bottom != null ? size.height * blob.bottom! : null,
          left: blob.left != null ? size.width * blob.left! : null,
          right: blob.right != null ? size.width * blob.right! : null,
          child: Container(
            width: size.width * blob.widthFactor,
            height: size.height * blob.heightFactor,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: blob.color,
            ),
          ),
        );
      }).toList(),
    );
  }
}

class AmbientBlob {
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final double widthFactor;
  final double heightFactor;
  final Color color;

  const AmbientBlob({
    this.top,
    this.bottom,
    this.left,
    this.right,
    required this.widthFactor,
    required this.heightFactor,
    required this.color,
  });
}

/// Default splash-style ambient blobs.
List<AmbientBlob> splashBlobs = [
  AmbientBlob(
    top: -0.1,
    left: -0.1,
    widthFactor: 0.6,
    heightFactor: 0.6,
    color: AppColors.primary.withValues(alpha: 0.10),
  ),
  AmbientBlob(
    bottom: -0.1,
    right: -0.1,
    widthFactor: 0.5,
    heightFactor: 0.5,
    color: AppColors.primaryContainer.withValues(alpha: 0.20),
  ),
];

List<AmbientBlob> onboardingBlobs = [
  AmbientBlob(
    top: -0.1,
    right: -0.1,
    widthFactor: 0.6,
    heightFactor: 0.6,
    color: AppColors.primary.withValues(alpha: 0.10),
  ),
  AmbientBlob(
    bottom: -0.05,
    left: -0.05,
    widthFactor: 0.4,
    heightFactor: 0.4,
    color: AppColors.primaryContainer.withValues(alpha: 0.20),
  ),
];
