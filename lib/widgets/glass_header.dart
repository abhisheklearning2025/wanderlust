import 'dart:ui';
import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

/// Persistent glass navigation header matching the "Glass Header" spec.
class GlassHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  const GlassHeader({
    super.key,
    this.leading,
    this.title,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow.withValues(alpha: 0.6),
            border: const Border(
              bottom: BorderSide(color: AppColors.ghostBorder),
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.organicShadow,
                blurRadius: 48,
                offset: Offset(0, 24),
              ),
            ],
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 64,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    ?leading,
                    if (title != null) ...[
                      const SizedBox(width: 12),
                      Expanded(child: title!),
                    ] else
                      const Spacer(),
                    ...?actions,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
