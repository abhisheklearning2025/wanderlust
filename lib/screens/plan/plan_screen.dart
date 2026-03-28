import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/glass_header.dart';
import '../../widgets/bottom_nav_bar.dart';

class _Trip {
  final String title;
  final String dateRange;
  final String imageUrl;
  final int days;
  final int stops;
  final double progress;

  const _Trip({
    required this.title,
    required this.dateRange,
    required this.imageUrl,
    required this.days,
    required this.stops,
    required this.progress,
  });
}

const _upcomingTrips = [
  _Trip(
    title: 'Sapa Valley, Vietnam',
    dateRange: 'Apr 12 – Apr 19',
    imageUrl: 'https://picsum.photos/seed/sapavalley/600/400',
    days: 7,
    stops: 5,
    progress: 0.65,
  ),
  _Trip(
    title: 'Kyoto, Japan',
    dateRange: 'May 3 – May 10',
    imageUrl: 'https://picsum.photos/seed/kyoto/600/400',
    days: 7,
    stops: 8,
    progress: 0.3,
  ),
];

const _pastTrips = [
  _Trip(
    title: 'Copenhagen, Denmark',
    dateRange: 'Feb 10 – Feb 15',
    imageUrl: 'https://picsum.photos/seed/copenhagen/600/400',
    days: 5,
    stops: 6,
    progress: 1.0,
  ),
];

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

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
                  'My Trips',
                  style: GoogleFonts.epilogue(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiary,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add_rounded, size: 24, color: AppColors.primary),
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Create new trip CTA
                      _buildCreateTripCard(context),
                      const SizedBox(height: 40),

                      // Upcoming trips
                      Text(
                        'Upcoming',
                        style: GoogleFonts.epilogue(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: AppColors.tertiaryFixed,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._upcomingTrips.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _TripCard(trip: e.value)
                            .animate()
                            .fadeIn(delay: Duration(milliseconds: 100 * e.key), duration: 500.ms)
                            .slideY(begin: 0.05, end: 0, delay: Duration(milliseconds: 100 * e.key), duration: 500.ms),
                      )),

                      const SizedBox(height: 32),

                      // Past trips
                      Text(
                        'Past Adventures',
                        style: GoogleFonts.epilogue(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                          color: AppColors.tertiaryFixed,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ..._pastTrips.map((trip) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _TripCard(trip: trip, isPast: true),
                      )),
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
            child: BottomNavBar(currentIndex: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTripCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(28),
      borderRadius: BorderRadius.circular(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plan a new trip',
                  style: GoogleFonts.epilogue(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiaryFixed,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Let AI craft your perfect itinerary based on your travel spirit.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    height: 1.5,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, size: 16, color: AppColors.onPrimary),
                      const SizedBox(width: 8),
                      Text(
                        'Start with AI',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: const Icon(Icons.flight_takeoff_rounded, size: 32, color: AppColors.primary),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.05, end: 0, duration: 600.ms);
  }
}

class _TripCard extends StatelessWidget {
  final _Trip trip;
  final bool isPast;

  const _TripCard({required this.trip, this.isPast = false});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SizedBox(
              height: 140,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: trip.imageUrl,
                    fit: BoxFit.cover,
                    color: isPast ? Colors.white.withValues(alpha: 0.6) : null,
                    colorBlendMode: isPast ? BlendMode.modulate : null,
                    placeholder: (context, url) => Container(color: AppColors.surfaceContainerLow),
                    errorWidget: (context, url, error) => Container(color: AppColors.surfaceContainerLow),
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.background.withValues(alpha: 0.6)],
                      ),
                    ),
                  ),
                  if (isPast)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          'COMPLETED',
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.5,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trip.title,
                  style: GoogleFonts.epilogue(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiaryFixed,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  trip.dateRange,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _InfoChip(Icons.calendar_today_rounded, '${trip.days} days'),
                    const SizedBox(width: 12),
                    _InfoChip(Icons.place_rounded, '${trip.stops} stops'),
                    const Spacer(),
                    if (!isPast)
                      SizedBox(
                        width: 80,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${(trip.progress * 100).round()}%',
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: LinearProgressIndicator(
                                value: trip.progress,
                                backgroundColor: AppColors.surfaceContainerHighest,
                                valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                                minHeight: 3,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.primary),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
