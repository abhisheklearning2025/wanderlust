import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_header.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../destination_detail/destination_detail_screen.dart';
import '../main_shell.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              // Top app bar
              GlassHeader(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: CachedNetworkImage(
                        imageUrl: 'https://picsum.photos/seed/alex/100/100',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.primaryContainer,
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person, color: AppColors.primary),
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'Wanderlust AI',
                  style: GoogleFonts.epilogue(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiary,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings_rounded, size: 24, color: AppColors.onSurfaceVariant),
                    onPressed: () {},
                  ),
                ],
              ),

              // Scrollable content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Greeting + weather
                      _buildGreetingSection(context),
                      const SizedBox(height: 40),

                      // Hero — AI Pick of the Day
                      _buildHeroSection(context),
                      const SizedBox(height: 32),

                      // Quick actions
                      _buildQuickActions(context),
                      const SizedBox(height: 40),

                      // For You section
                      _buildForYouSection(context),
                      const SizedBox(height: 40),

                      // Trending section
                      _buildTrendingSection(),
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
            child: BottomNavBar(currentIndex: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildGreetingSection(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'hey Alex!',
                style: GoogleFonts.epilogue(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  height: 1.0,
                  color: AppColors.tertiaryFixed,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'YOUR ADVENTURE CONTINUES',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.1, end: 0, duration: 600.ms),
        ),
        // Weather chip
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.ghostBorder),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wb_sunny_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'TOKYO • 22°C',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: AppColors.tertiary,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideX(begin: 0.1, end: 0, delay: 200.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: 16 / 10,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            CachedNetworkImage(
              imageUrl: 'https://picsum.photos/seed/sapavalley/1200/800',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.surfaceContainerLow,
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.surfaceContainerLow,
              ),
            ),

            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.surfaceContainerLow.withValues(alpha: 0.4),
                    AppColors.background,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),

            // Content overlay
            Positioned(
              left: 24,
              right: 24,
              bottom: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          'AI PICK OF THE DAY',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 15,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome, size: 12, color: AppColors.onPrimary),
                            const SizedBox(width: 4),
                            Text(
                              '95% Match',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Title
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.epilogue(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1.5,
                        color: AppColors.tertiaryFixed,
                      ),
                      children: const [
                        TextSpan(text: 'Sapa Valley, '),
                        TextSpan(
                          text: 'Vietnam',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    'Experience the ethereal beauty of cascading emerald terraces and ancient hill tribe cultures in the heart of the Tonkinese Alps.',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      height: 1.6,
                      color: AppColors.onSurfaceVariant,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),

                  // CTA button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        PageRouteBuilder(
                          pageBuilder: (_, _, _) => const MainShell(initialIndex: 2),
                          transitionDuration: const Duration(milliseconds: 250),
                          transitionsBuilder: (_, animation, _, child) =>
                              FadeTransition(opacity: animation, child: child),
                        ),
                      );
                    },
                    icon: const Text('Start Planning'),
                    label: const Icon(Icons.arrow_forward_rounded, size: 20),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.onPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: 300.ms, duration: 800.ms)
        .scale(
          begin: const Offset(0.95, 0.95),
          end: const Offset(1.0, 1.0),
          delay: 300.ms,
          duration: 800.ms,
          curve: Curves.easeOut,
        );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = [
      _QuickActionData(Icons.explore_rounded, 'Explore', 1),
      _QuickActionData(Icons.calendar_today_rounded, 'Plan', 2),
      _QuickActionData(Icons.translate_rounded, 'Translate', null),
      _QuickActionData(Icons.error_outline_rounded, 'SOS', null),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: actions.length,
      itemBuilder: (_, i) => _QuickActionCard(
        data: actions[i],
        onTap: actions[i].navIndex != null
            ? () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, _, _) =>
                        MainShell(initialIndex: actions[i].navIndex!),
                    transitionDuration: const Duration(milliseconds: 250),
                    transitionsBuilder: (_, animation, _, child) =>
                        FadeTransition(opacity: animation, child: child),
                  ),
                );
              }
            : null,
      ),
    );
  }

  Widget _buildForYouSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'For You',
              style: GoogleFonts.epilogue(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                color: AppColors.tertiaryFixed,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, _, _) => const MainShell(initialIndex: 1),
                    transitionDuration: const Duration(milliseconds: 250),
                    transitionsBuilder: (_, animation, _, child) =>
                        FadeTransition(opacity: animation, child: child),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'VIEW ALL',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right, size: 14, color: AppColors.primary),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 360,
          child: ListView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            children: [
              _DestinationCard(
                imageUrl: 'https://picsum.photos/seed/copenhagen/400/500',
                tag: 'Nordic Escape',
                title: 'Copenhagen, Denmark',
                onTap: () => _openDetail(context, 'Copenhagen, Denmark', 'https://picsum.photos/seed/copenhagen/400/500', ['Nordic', 'Culture']),
              ),
              const SizedBox(width: 24),
              _DestinationCard(
                imageUrl: 'https://picsum.photos/seed/kyoto/400/500',
                tag: 'Cultural Immersion',
                title: 'Kyoto, Japan',
                onTap: () => _openDetail(context, 'Kyoto, Japan', 'https://picsum.photos/seed/kyoto/400/500', ['Culture', 'Zen']),
              ),
              const SizedBox(width: 24),
              _DestinationCard(
                imageUrl: 'https://picsum.photos/seed/amalfi/400/500',
                tag: 'Coastal Serenity',
                title: 'Amalfi, Italy',
                onTap: () => _openDetail(context, 'Amalfi, Italy', 'https://picsum.photos/seed/amalfi/400/500', ['Coastal', 'Romance']),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openDetail(BuildContext context, String title, String imageUrl, List<String> tags) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DestinationDetailScreen(
          title: title,
          imageUrl: imageUrl,
          matchPercent: '90%',
          tags: tags,
        ),
      ),
    );
  }

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending rn',
          style: GoogleFonts.epilogue(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: AppColors.tertiaryFixed,
          ),
        ),
        const SizedBox(height: 16),
        const _TrendingCard(
          imageUrl: 'https://picsum.photos/seed/tajmahal/200/200',
          title: 'Agra, India',
          users: '12.4k',
          tags: ['#Architecture', '#History'],
        ),
        const SizedBox(height: 16),
        const _TrendingCard(
          imageUrl: 'https://picsum.photos/seed/iceland/200/200',
          title: 'Reykjavik, Iceland',
          users: '8.9k',
          tags: ['#Nature', '#Adventure'],
        ),
        const SizedBox(height: 16),
        const _TrendingCard(
          imageUrl: 'https://picsum.photos/seed/nyc/200/200',
          title: 'New York, USA',
          users: '15.2k',
          tags: ['#Urban', '#Food'],
        ),
      ],
    );
  }
}

// --- Sub-widgets ---

class _QuickActionData {
  final IconData icon;
  final String label;
  final int? navIndex;
  const _QuickActionData(this.icon, this.label, this.navIndex);
}

class _QuickActionCard extends StatelessWidget {
  final _QuickActionData data;
  final VoidCallback? onTap;
  const _QuickActionCard({required this.data, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.1),
              ),
              child: Icon(data.icon, size: 24, color: AppColors.primary),
            ),
            const SizedBox(height: 10),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                data.label.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: AppColors.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String title;
  final VoidCallback? onTap;

  const _DestinationCard({
    required this.imageUrl,
    required this.tag,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 280,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: AppColors.surfaceContainerLow,
              ),
              errorWidget: (context, url, error) => Container(
                color: AppColors.surfaceContainerLow,
              ),
            ),
            // Gradient overlay
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withValues(alpha: 0.9),
                  ],
                ),
              ),
            ),
            // Content
            Positioned(
              bottom: 24,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tag.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: GoogleFonts.epilogue(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.tertiaryFixed,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }
}

class _TrendingCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String users;
  final List<String> tags;

  const _TrendingCard({
    required this.imageUrl,
    required this.title,
    required this.users,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(24),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              width: 72,
              height: 72,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 72,
                height: 72,
                color: AppColors.surfaceContainerLow,
              ),
              errorWidget: (context, url, error) => Container(
                width: 72,
                height: 72,
                color: AppColors.surfaceContainerLow,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiaryFixed,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$users USERS EXPLORING TODAY',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.5,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  children: tags.map((tag) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      tag.toUpperCase(),
                      style: GoogleFonts.inter(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  )).toList(),
                ),
              ],
            ),
          ),
          // Pulse dot
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.6),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
