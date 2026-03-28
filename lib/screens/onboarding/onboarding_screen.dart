import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/navigation/app_router.dart';
import '../../widgets/ambient_background.dart';
import '../../widgets/glass_card.dart';
import '../assessment/assessment_screen.dart';

class _OnboardingPage {
  final String imageUrl;
  final IconData icon;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.imageUrl,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

const _pages = [
  _OnboardingPage(
    imageUrl: 'https://picsum.photos/seed/nebula/800/600',
    icon: Icons.auto_awesome,
    title: 'Discover Your Vibe',
    subtitle: 'Tell us what you love. Our AI finds places that match YOUR energy.',
  ),
  _OnboardingPage(
    imageUrl: 'https://picsum.photos/seed/forest/800/600',
    icon: Icons.eco_rounded,
    title: 'AI-Crafted Itineraries',
    subtitle: 'Get personalized day-by-day travel plans built around your unique spirit.',
  ),
  _OnboardingPage(
    imageUrl: 'https://picsum.photos/seed/ocean/800/600',
    icon: Icons.groups_rounded,
    title: 'Travel Community',
    subtitle: 'Connect with like-minded wanderers and share hidden gems around the globe.',
  ),
  _OnboardingPage(
    imageUrl: 'https://picsum.photos/seed/mountain/800/600',
    icon: Icons.map_rounded,
    title: 'Your Journey Awaits',
    subtitle: 'From dreaming to exploring — your next adventure starts with a single tap.',
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToAssessment() {
    Navigator.of(context).pushReplacement(
      FadeSlideRoute(page: const AssessmentScreen()),
    );
  }

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
              child: Column(
                children: [
                  // Skip button
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 24, top: 12),
                      child: TextButton(
                        onPressed: _goToAssessment,
                        child: Text(
                          'SKIP',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                            color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Card carousel
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      onPageChanged: (i) => setState(() => _currentPage = i),
                      itemBuilder: (context, i) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 480),
                            child: _buildCard(_pages[i]),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Bottom section: dots + CTA
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        children: [
                          // Pagination dots
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(_pages.length, (i) {
                              final active = i == _currentPage;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: active ? 32 : 6,
                                height: 6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: active ? AppColors.primary : AppColors.tertiary.withValues(alpha: 0.2),
                                  boxShadow: active
                                      ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.5), blurRadius: 8)]
                                      : null,
                                ),
                              );
                            }),
                          ),
                          const SizedBox(height: 32),

                          // CTA button
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
                                    if (_currentPage < _pages.length - 1) {
                                      _pageController.nextPage(
                                        duration: const Duration(milliseconds: 400),
                                        curve: Curves.easeOutCubic,
                                      );
                                    } else {
                                      _goToAssessment();
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
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

                          // Log in link
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(_OnboardingPage page) {
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            SizedBox(
              height: 280,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: page.imageUrl,
                    fit: BoxFit.cover,
                    color: Colors.white.withValues(alpha: 0.9),
                    colorBlendMode: BlendMode.modulate,
                    placeholder: (context, url) =>
                        Container(color: AppColors.surfaceContainerLow),
                    errorWidget: (context, url, error) =>
                        Container(color: AppColors.surfaceContainerLow),
                  ),
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
                  Positioned(
                    top: 24,
                    left: 24,
                    child: GlassCard(
                      padding: const EdgeInsets.all(12),
                      borderRadius: BorderRadius.circular(24),
                      child: Icon(page.icon, size: 24, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),

            // Text content
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    page.title,
                    style: GoogleFonts.epilogue(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -1,
                      height: 1.1,
                      color: AppColors.tertiary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    page.subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: AppColors.primary.withValues(alpha: 0.9),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
