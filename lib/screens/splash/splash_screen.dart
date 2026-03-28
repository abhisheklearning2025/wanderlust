import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/theme/app_colors.dart';
import '../../core/navigation/app_router.dart';
import '../../widgets/ambient_background.dart';
import '../../widgets/corner_accents.dart';
import '../onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _orbitController;

  @override
  void initState() {
    super.initState();
    _orbitController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();

    Timer(const Duration(milliseconds: 3500), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          FadeRoute(page: const OnboardingScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _orbitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0B1A14), Color(0xFF14211C)],
          ),
        ),
        child: Stack(
          children: [
            // Ambient glow blobs
            const AmbientBackground(blobs: [
              AmbientBlob(
                top: -0.1,
                left: -0.1,
                widthFactor: 0.6,
                heightFactor: 0.6,
                color: Color(0x1AA1D1B9),
              ),
              AmbientBlob(
                bottom: -0.1,
                right: -0.1,
                widthFactor: 0.5,
                heightFactor: 0.5,
                color: Color(0x332D5A47),
              ),
            ]),

            // Radial center glow
            Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF2D5A47).withValues(alpha: 0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // Corner accents
            const CornerAccents(),

            // Main content
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Glass orb with compass
                    _buildOrb(),
                    const SizedBox(height: 48),

                    // Branding cluster
                    _buildBranding(),
                    const SizedBox(height: 48),

                    // Bottom loading section
                    _buildLoadingSection(),
                  ],
                ),
              ),
            ),

            // Bottom attribution
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'BOTANICAL INTELLIGENCE V.2.4',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w400,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 1500.ms, duration: 800.ms),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrb() {
    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Inner glow
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.20),
            ),
          ),

          // Main glass orb
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer.withValues(alpha: 0.4),
              border: Border.all(
                color: AppColors.tertiary.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(
              Icons.explore_rounded,
              size: 64,
              color: AppColors.tertiary,
              shadows: [
                Shadow(
                  color: AppColors.tertiary.withValues(alpha: 0.6),
                  blurRadius: 12,
                ),
              ],
            ),
          ),

          // Rotating orbit ring
          AnimatedBuilder(
            animation: _orbitController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _orbitController.value * 2 * pi,
                child: child,
              );
            },
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.tertiary.withValues(alpha: 0.1),
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
            ),
          ),
        ],
      ),
    )
        .animate()
        .scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1.0, 1.0),
          duration: 1200.ms,
          curve: Curves.easeOut,
        )
        .fadeIn(duration: 1200.ms);
  }

  Widget _buildBranding() {
    return Column(
      children: [
        // Title
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              AppColors.tertiaryFixed,
              AppColors.primary,
              AppColors.tertiaryFixed,
            ],
          ).createShader(bounds),
          child: Text(
            'Wanderlust AI',
            style: GoogleFonts.epilogue(
              fontSize: 48,
              fontWeight: FontWeight.w800,
              letterSpacing: -2,
              height: 1.0,
              color: Colors.white,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 500.ms, duration: 800.ms)
            .slideY(begin: 0.15, end: 0, delay: 500.ms, duration: 800.ms),

        const SizedBox(height: 16),

        // Subtitle with decorative lines
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 1,
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
            const SizedBox(width: 12),
            Text(
              'YOUR AI-POWERED TRAVEL BESTIE',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                letterSpacing: 2.5,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 32,
              height: 1,
              color: AppColors.primary.withValues(alpha: 0.3),
            ),
          ],
        ).animate().fadeIn(delay: 1000.ms, duration: 1000.ms),
      ],
    );
  }

  Widget _buildLoadingSection() {
    return Column(
      children: [
        // "Syncing..." label
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 18,
              color: AppColors.tertiary,
            ),
            const SizedBox(width: 12),
            Text(
              'Syncing global destinations...',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // Loading bar
        SizedBox(
          width: 192,
          height: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1),
            child: Stack(
              children: [
                Container(color: AppColors.surfaceContainerHighest),
                _LoadingBar(),
              ],
            ),
          ),
        ),
      ],
    )
        .animate()
        .fade(
          delay: 1500.ms,
          duration: 1000.ms,
          begin: 0,
          end: 0.6,
        );
  }
}

class _LoadingBar extends StatefulWidget {
  @override
  State<_LoadingBar> createState() => _LoadingBarState();
}

class _LoadingBarState extends State<_LoadingBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FractionallySizedBox(
          alignment: Alignment(-1.0 + _controller.value * 4, 0),
          widthFactor: 0.33,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        );
      },
    );
  }
}
