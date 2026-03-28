import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../core/navigation/app_router.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_header.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../../widgets/ambient_background.dart';
import '../main_shell.dart';

class _TravelerOption {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  const _TravelerOption({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

const _options = [
  _TravelerOption(
    id: 'adventure',
    title: 'Adventure Seeker',
    description: 'Thrill-seeker looking for remote peaks and untamed wilderness.',
    icon: Icons.terrain_rounded,
  ),
  _TravelerOption(
    id: 'culture',
    title: 'Culture Explorer',
    description: 'Diving deep into local traditions, history, and culinary secrets.',
    icon: Icons.account_balance_rounded,
  ),
  _TravelerOption(
    id: 'zen',
    title: 'Zen Nomad',
    description: 'Prioritizing mindfulness, slow travel, and restorative escapes.',
    icon: Icons.eco_rounded,
  ),
  _TravelerOption(
    id: 'urban',
    title: 'Urban Sophisticate',
    description: 'Chasing modern architecture, rooftop bars, and city pulses.',
    icon: Icons.apartment_rounded,
  ),
];

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  String _selected = 'zen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decoration
          const AmbientBackground(blobs: [
            AmbientBlob(
              top: -0.1,
              right: -0.1,
              widthFactor: 0.5,
              heightFactor: 0.5,
              color: Color(0x0DA1D1B9),
            ),
            AmbientBlob(
              bottom: -0.1,
              left: -0.1,
              widthFactor: 0.4,
              heightFactor: 0.4,
              color: Color(0x1A2D5A47),
            ),
          ]),

          // Main scrollable content
          Column(
            children: [
              // Glass header
              GlassHeader(
                leading: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primaryContainer,
                  ),
                  child: const Icon(Icons.eco_rounded, size: 16, color: AppColors.primary),
                ),
                title: Text(
                  'Wanderlust AI',
                  style: GoogleFonts.epilogue(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                    color: AppColors.tertiary,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings_rounded, size: 20, color: AppColors.onSurfaceVariant),
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: 'https://picsum.photos/seed/traveler/100/100',
                      width: 32,
                      height: 32,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 32,
                        height: 32,
                        color: AppColors.surfaceContainerHighest,
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 32,
                        height: 32,
                        color: AppColors.surfaceContainerHighest,
                        child: const Icon(Icons.person, size: 16),
                      ),
                    ),
                  ),
                ],
              ),

              // Scrollable body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  child: Column(
                    children: [
                      // Progress circle
                      _buildProgressCircle(),
                      const SizedBox(height: 48),

                      // AI message bubble
                      _buildAIMessage(),
                      const SizedBox(height: 40),

                      // Options grid
                      _buildOptionsGrid(),
                      const SizedBox(height: 64),

                      // CTA
                      _buildCTA(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom nav
          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(currentIndex: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressCircle() {
    return Column(
      children: [
        SizedBox(
          width: 80,
          height: 80,
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 0.8),
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return CustomPaint(
                painter: _ProgressPainter(progress: value),
                child: Center(
                  child: Text(
                    '${(value * 100).round()}%',
                    style: GoogleFonts.epilogue(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.tertiaryFixed,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'SPIRIT ASSESSMENT',
          style: GoogleFonts.inter(
            fontSize: 10,
            letterSpacing: 3,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildAIMessage() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.primaryContainer,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryContainer.withValues(alpha: 0.4),
                blurRadius: 12,
              ),
            ],
          ),
          child: const Icon(Icons.eco_rounded, size: 24, color: AppColors.primary),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: GlassCard(
            padding: const EdgeInsets.all(24),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Text(
              "Great. Now, let's explore your spirit. What kind of traveler are you?",
              style: GoogleFonts.epilogue(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.5,
                color: AppColors.tertiaryFixed,
              ),
            ),
          ),
        ),
      ],
    )
        .animate()
        .fadeIn(delay: 200.ms, duration: 600.ms)
        .slideX(begin: -0.05, end: 0, delay: 200.ms, duration: 600.ms);
  }

  Widget _buildOptionsGrid() {
    return Column(
      children: _options.asMap().entries.map((e) {
        final option = e.value;
        final isSelected = _selected == option.id;
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildOptionCard(option, isSelected, e.key),
        );
      }).toList(),
    );
  }

  Widget _buildOptionCard(_TravelerOption option, bool isSelected, int index) {
    return GestureDetector(
      onTap: () => setState(() => _selected = option.id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected
              ? AppColors.primaryContainer.withValues(alpha: 0.4)
              : AppColors.glassBackground,
          border: Border.all(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.ghostBorder,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      option.icon,
                      size: 32,
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.primary.withValues(alpha: 0.6),
                    ),
                    // Check circle
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? AppColors.primary : Colors.transparent,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.tertiary.withValues(alpha: 0.2),
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.4),
                                  blurRadius: 12,
                                ),
                              ]
                            : null,
                      ),
                      child: isSelected
                          ? const Icon(Icons.check, size: 14, color: AppColors.onPrimary)
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  option.title,
                  style: GoogleFonts.epilogue(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? AppColors.primary : AppColors.tertiaryFixed,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  option.description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.4,
                    color: isSelected
                        ? AppColors.onPrimaryContainer
                        : AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            // Glow effect when selected
            if (isSelected)
              Positioned(
                bottom: -48,
                right: -48,
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withValues(alpha: 0.1),
                  ),
                ),
              ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 * index), duration: 400.ms)
        .slideY(
          begin: 0.1,
          end: 0,
          delay: Duration(milliseconds: 100 * index),
          duration: 400.ms,
        );
  }

  Widget _buildCTA() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 384),
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColors.signatureGradient,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.ghostBorder),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.organicShadow,
                    blurRadius: 48,
                    offset: Offset(0, 24),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      FadeRoute(page: const MainShell()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Continue Journey',
                          style: GoogleFonts.epilogue(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                            color: AppColors.primary,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.arrow_forward_rounded, size: 20, color: AppColors.primary),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "STEP 4 OF 5 • YOU'RE ALMOST THERE",
          style: GoogleFonts.inter(
            fontSize: 10,
            letterSpacing: 3,
            fontWeight: FontWeight.w400,
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
          ),
        ),
      ],
    );
  }
}

class _ProgressPainter extends CustomPainter {
  final double progress;

  _ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    // Background circle
    final bgPaint = Paint()
      ..color = AppColors.surfaceContainerHighest
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(center, radius, bgPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      2 * pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_ProgressPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
