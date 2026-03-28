import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_header.dart';
import '../../widgets/bottom_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Column(
            children: [
              GlassHeader(
                title: Text(
                  'Profile',
                  style: GoogleFonts.epilogue(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiary,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.settings_rounded, size: 22, color: AppColors.onSurfaceVariant),
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 100),
                  child: Column(
                    children: [
                      // Avatar + name
                      _buildProfileHeader(),
                      const SizedBox(height: 32),

                      // Stats row
                      _buildStatsRow(),
                      const SizedBox(height: 32),

                      // Travel spirit badge
                      _buildSpiritBadge(),
                      const SizedBox(height: 32),

                      // Menu items
                      _buildMenuSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavBar(currentIndex: 4),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Avatar with ring
        Container(
          width: 96,
          height: 96,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.primary, Color(0xFF2D5A47)],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 24,
              ),
            ],
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: 'https://picsum.photos/seed/alex/200/200',
              fit: BoxFit.cover,
              placeholder: (context, url) =>
                  Container(color: AppColors.primaryContainer),
              errorWidget: (context, url, error) =>
                  Container(color: AppColors.primaryContainer),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Alex Wanderer',
          style: GoogleFonts.epilogue(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.tertiaryFixed,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '@alexwanders',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primaryContainer.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.eco_rounded, size: 14, color: AppColors.primary),
              const SizedBox(width: 6),
              Text(
                'ZEN NOMAD',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms);
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _StatItem(value: '12', label: 'Trips'),
        _StatItem(value: '8', label: 'Countries'),
        _StatItem(value: '47', label: 'Places'),
        _StatItem(value: '1.2k', label: 'Followers'),
      ]
          .map((w) => Expanded(child: w))
          .toList(),
    ).animate().fadeIn(delay: 200.ms, duration: 500.ms);
  }

  Widget _buildSpiritBadge() {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.15),
            ),
            child: const Icon(Icons.eco_rounded, size: 28, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Travel Spirit',
                  style: GoogleFonts.epilogue(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiaryFixed,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Mindfulness, slow travel, and restorative escapes define your journey.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    height: 1.5,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 500.ms);
  }

  Widget _buildMenuSection() {
    final items = [
      _MenuItem(Icons.bookmark_rounded, 'Saved Places'),
      _MenuItem(Icons.history_rounded, 'Travel History'),
      _MenuItem(Icons.language_rounded, 'Language'),
      _MenuItem(Icons.notifications_rounded, 'Notifications'),
      _MenuItem(Icons.shield_rounded, 'Privacy & Security'),
      _MenuItem(Icons.help_outline_rounded, 'Help & Support'),
    ];

    return Column(
      children: items.asMap().entries.map((e) {
        final item = e.value;
        return Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.surfaceContainerHigh,
                      ),
                      child: Icon(item.icon, size: 20, color: AppColors.primary),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        item.label,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: AppColors.tertiaryFixed,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, size: 20, color: AppColors.onSurfaceVariant),
                  ],
                ),
              ),
            ),
          )
              .animate()
              .fadeIn(delay: Duration(milliseconds: 350 + 60 * e.key), duration: 400.ms),
        );
      }).toList(),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;
  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.epilogue(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.tertiaryFixed,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.5,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  const _MenuItem(this.icon, this.label);
}
