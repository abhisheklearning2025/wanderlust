import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/glass_card.dart';

class _Highlight {
  final IconData icon;
  final String label;
  final String value;
  const _Highlight(this.icon, this.label, this.value);
}

class DestinationDetailScreen extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String matchPercent;
  final List<String> tags;

  const DestinationDetailScreen({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.matchPercent,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final highlights = [
      const _Highlight(Icons.wb_sunny_rounded, 'Weather', '26°C'),
      const _Highlight(Icons.attach_money_rounded, 'Budget', '\$\$'),
      const _Highlight(Icons.flight_rounded, 'Flight', '~8h'),
      const _Highlight(Icons.star_rounded, 'Rating', '4.8'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Hero image with parallax-like header
          SliverAppBar(
            expandedHeight: 360,
            pinned: true,
            backgroundColor: AppColors.surfaceContainerLow,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background.withValues(alpha: 0.5),
                  ),
                  child: const Icon(Icons.arrow_back_rounded, color: AppColors.tertiaryFixed),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background.withValues(alpha: 0.5),
                  ),
                  child: const Icon(Icons.bookmark_border_rounded, color: AppColors.tertiaryFixed),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.background.withValues(alpha: 0.5),
                  ),
                  child: const Icon(Icons.share_rounded, color: AppColors.tertiaryFixed),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: AppColors.surfaceContainerLow),
                    errorWidget: (context, url, error) =>
                        Container(color: AppColors.surfaceContainerLow),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          AppColors.background.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tags + match
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.auto_awesome, size: 12, color: AppColors.onPrimary),
                            const SizedBox(width: 6),
                            Text(
                              '$matchPercent Match',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      ...tags.map((tag) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                            tag.toUpperCase(),
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1,
                              color: AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      )),
                    ],
                  )
                      .animate()
                      .fadeIn(duration: 400.ms),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    title,
                    style: GoogleFonts.epilogue(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1.5,
                      height: 1.1,
                      color: AppColors.tertiaryFixed,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 100.ms, duration: 500.ms),

                  const SizedBox(height: 16),

                  // Description
                  Text(
                    'Discover a breathtaking destination where ancient traditions meet natural wonders. Immerse yourself in the local culture, explore hidden gems, and create memories that last a lifetime. This destination perfectly matches your travel spirit.',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      height: 1.7,
                      color: AppColors.onSurfaceVariant,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 200.ms, duration: 500.ms),

                  const SizedBox(height: 32),

                  // Highlights grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.7,
                    ),
                    itemCount: highlights.length,
                    itemBuilder: (context, i) {
                      final h = highlights[i];
                      return GlassCard(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                        borderRadius: BorderRadius.circular(16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(h.icon, size: 22, color: AppColors.primary),
                            const SizedBox(height: 8),
                            Text(
                              h.value,
                              style: GoogleFonts.epilogue(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: AppColors.tertiaryFixed,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              h.label.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 9,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      )
                          .animate()
                          .fadeIn(delay: Duration(milliseconds: 300 + 80 * i), duration: 400.ms);
                    },
                  ),

                  const SizedBox(height: 32),

                  // What to expect
                  Text(
                    'What to Expect',
                    style: GoogleFonts.epilogue(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.tertiaryFixed,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildExpectItem(Icons.restaurant_rounded, 'Local Cuisine', 'Authentic flavors and street food experiences.'),
                  const SizedBox(height: 12),
                  _buildExpectItem(Icons.photo_camera_rounded, 'Scenic Views', 'Instagram-worthy spots at every corner.'),
                  const SizedBox(height: 12),
                  _buildExpectItem(Icons.self_improvement_rounded, 'Wellness', 'Rejuvenate with local healing practices.'),

                  const SizedBox(height: 40),

                  // CTA
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Text('Start Planning This Trip'),
                      label: const Icon(Icons.arrow_forward_rounded, size: 20),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        textStyle: GoogleFonts.epilogue(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 500.ms),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpectItem(IconData icon, String title, String desc) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.primary.withValues(alpha: 0.12),
            ),
            child: Icon(icon, size: 22, color: AppColors.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.tertiaryFixed,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
