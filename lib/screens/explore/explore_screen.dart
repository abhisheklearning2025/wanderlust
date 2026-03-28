import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/glass_header.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../destination_detail/destination_detail_screen.dart';

class _Category {
  final String label;
  final IconData icon;
  const _Category(this.label, this.icon);
}

const _categories = [
  _Category('All', Icons.public_rounded),
  _Category('Beach', Icons.beach_access_rounded),
  _Category('Mountain', Icons.terrain_rounded),
  _Category('City', Icons.apartment_rounded),
  _Category('Culture', Icons.account_balance_rounded),
  _Category('Nature', Icons.forest_rounded),
];

class _Destination {
  final String title;
  final String country;
  final String imageUrl;
  final String matchPercent;
  final List<String> tags;

  const _Destination({
    required this.title,
    required this.country,
    required this.imageUrl,
    required this.matchPercent,
    required this.tags,
  });
}

const _destinations = [
  _Destination(
    title: 'Bali',
    country: 'Indonesia',
    imageUrl: 'https://picsum.photos/seed/bali/600/400',
    matchPercent: '94%',
    tags: ['Beach', 'Culture'],
  ),
  _Destination(
    title: 'Santorini',
    country: 'Greece',
    imageUrl: 'https://picsum.photos/seed/santorini/600/400',
    matchPercent: '91%',
    tags: ['Beach', 'Romance'],
  ),
  _Destination(
    title: 'Patagonia',
    country: 'Argentina',
    imageUrl: 'https://picsum.photos/seed/patagonia/600/400',
    matchPercent: '88%',
    tags: ['Mountain', 'Adventure'],
  ),
  _Destination(
    title: 'Marrakech',
    country: 'Morocco',
    imageUrl: 'https://picsum.photos/seed/marrakech/600/400',
    matchPercent: '86%',
    tags: ['Culture', 'Food'],
  ),
  _Destination(
    title: 'Swiss Alps',
    country: 'Switzerland',
    imageUrl: 'https://picsum.photos/seed/swissalps/600/400',
    matchPercent: '85%',
    tags: ['Mountain', 'Nature'],
  ),
  _Destination(
    title: 'Lisbon',
    country: 'Portugal',
    imageUrl: 'https://picsum.photos/seed/lisbon/600/400',
    matchPercent: '83%',
    tags: ['City', 'Food'],
  ),
];

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  int _selectedCategory = 0;

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
                  'Explore',
                  style: GoogleFonts.epilogue(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiary,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.tune_rounded, size: 22, color: AppColors.onSurfaceVariant),
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search bar
                      _buildSearchBar(),
                      const SizedBox(height: 24),

                      // Category chips
                      _buildCategoryChips(),
                      const SizedBox(height: 32),

                      // Section header
                      Text(
                        'Recommended For You',
                        style: GoogleFonts.epilogue(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: AppColors.tertiaryFixed,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Based on your Zen Nomad profile',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Destination grid
                      _buildDestinationGrid(),
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
            child: BottomNavBar(currentIndex: 1),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.ghostBorder),
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, size: 22, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              style: GoogleFonts.inter(fontSize: 15, color: AppColors.onSurface),
              decoration: InputDecoration(
                hintText: 'Search destinations, experiences...',
                hintStyle: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                filled: false,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final cat = _categories[i];
          final selected = i == _selectedCategory;
          return GestureDetector(
            onTap: () => setState(() => _selectedCategory = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.primaryContainer : AppColors.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(cat.icon, size: 16, color: selected ? AppColors.primary : AppColors.onSurfaceVariant),
                  const SizedBox(width: 8),
                  Text(
                    cat.label.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1,
                      color: selected ? AppColors.primary : AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ).animate().fadeIn(delay: 100.ms, duration: 400.ms);
  }

  Widget _buildDestinationGrid() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _destinations.length,
      separatorBuilder: (_, __) => const SizedBox(height: 20),
      itemBuilder: (context, i) {
        final dest = _destinations[i];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => DestinationDetailScreen(
                  title: '${dest.title}, ${dest.country}',
                  imageUrl: dest.imageUrl,
                  matchPercent: dest.matchPercent,
                  tags: dest.tags,
                ),
              ),
            );
          },
          child: _ExploreDestinationCard(destination: dest),
        )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 80 * i), duration: 400.ms)
            .slideY(begin: 0.05, end: 0, delay: Duration(milliseconds: 80 * i), duration: 400.ms);
      },
    );
  }
}

class _ExploreDestinationCard extends StatelessWidget {
  final _Destination destination;
  const _ExploreDestinationCard({required this.destination});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 220,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: destination.imageUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: AppColors.surfaceContainerLow),
              errorWidget: (context, url, error) => Container(color: AppColors.surfaceContainerLow),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    AppColors.background.withValues(alpha: 0.85),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
                    const Icon(Icons.auto_awesome, size: 10, color: AppColors.onPrimary),
                    const SizedBox(width: 4),
                    Text(
                      destination.matchPercent,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${destination.title}, ${destination.country}',
                    style: GoogleFonts.epilogue(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.tertiaryFixed,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: destination.tags.map((tag) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHighest.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        tag.toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    )).toList(),
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
