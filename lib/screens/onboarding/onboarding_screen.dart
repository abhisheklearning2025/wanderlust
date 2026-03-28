import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/navigation/app_router.dart';
import '../../widgets/ambient_background.dart';
import '../../widgets/glass_card.dart';
import '../assessment/assessment_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF091611), Color(0xFF05110C)],
          ),
        ),
        child: Stack(
          children: [
            // Ambient background
            const AmbientBackground(blobs: [
              AmbientBlob(
                top: -0.1,
                right: -0.1,
                widthFactor: 0.6,
                heightFactor: 0.6,
                color: Color(0x1AA1D1B9),
              ),
              AmbientBlob(
                bottom: -0.05,
                left: -0.05,
                widthFactor: 0.4,
                heightFactor: 0.4,
                color: Color(0x332D5A47),
              ),
            ]),

            // Main content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Glass card with image + content
                        _buildMainCard()
                            .animate()
                            .fadeIn(duration: 800.ms)
                            .slideY(
                              begin: 0.1,
                              end: 0,
                              duration: 800.ms,
                              curve: Curves.easeOut,
                            ),

                        const SizedBox(height: 48),

                        // CTA section
                        _buildCTA(context)
                            .animate()
                            .fadeIn(delay: 400.ms, duration: 600.ms)
                            .slideY(
                              begin: 0.1,
                              end: 0,
                              delay: 400.ms,
                              duration: 600.ms,
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.glassBackground,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: AppColors.ghostBorder),
          boxShadow: const [
            BoxShadow(
              color: AppColors.organicShadow,
              blurRadius: 48,
              offset: Offset(0, 24),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            SizedBox(
              height: 320,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: 'https://picsum.photos/seed/nebula/800/600',
                    fit: BoxFit.cover,
                    color: Colors.white.withValues(alpha: 0.9),
                    colorBlendMode: BlendMode.modulate,
                    placeholder: (context, url) => Container(
                      color: AppColors.surfaceContainerLow,
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.surfaceContainerLow,
                      child: const Icon(Icons.image, color: AppColors.onSurfaceVariant),
                    ),
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.surfaceContainerLow.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Floating sparkle icon
                  Positioned(
                    top: 24,
                    left: 24,
                    child: GlassCard(
                      padding: const EdgeInsets.all(12),
                      borderRadius: BorderRadius.circular(24),
                      child: const Icon(
                        Icons.auto_awesome,
                        size: 24,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Discover Your Vibe',
                    style: GoogleFonts.epilogue(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                      height: 1.1,
                      color: AppColors.tertiary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Tell us what you love. Our AI finds places that match YOUR energy.',
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: AppColors.primary.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Pagination dots
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: AppColors.primary,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.5),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ...List.generate(3, (i) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.tertiary.withValues(alpha: 0.2),
                          ),
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTA(BuildContext context) {
    return Column(
      children: [
        // Primary CTA
        SizedBox(
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryContainer],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    FadeSlideRoute(page: const AssessmentScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
                        style: GoogleFonts.epilogue(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        size: 24,
                        color: AppColors.onPrimary,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Secondary link
        TextButton(
          onPressed: () {},
          child: Text(
            'ALREADY HAVE AN ACCOUNT? LOG IN',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 2,
              color: AppColors.tertiary.withValues(alpha: 0.6),
            ),
          ),
        ),
      ],
    );
  }
}
