import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/glass_header.dart';
import '../../widgets/bottom_nav_bar.dart';

class _Post {
  final String username;
  final String avatarUrl;
  final String location;
  final String imageUrl;
  final String caption;
  final String timeAgo;
  final int likes;
  final int comments;

  const _Post({
    required this.username,
    required this.avatarUrl,
    required this.location,
    required this.imageUrl,
    required this.caption,
    required this.timeAgo,
    required this.likes,
    required this.comments,
  });
}

const _posts = [
  _Post(
    username: 'Mia Chen',
    avatarUrl: 'https://picsum.photos/seed/mia/100/100',
    location: 'Bali, Indonesia',
    imageUrl: 'https://picsum.photos/seed/balipost/800/600',
    caption: 'Found paradise hidden between rice terraces and sacred temples. The energy here is unreal 🌿',
    timeAgo: '2h ago',
    likes: 284,
    comments: 32,
  ),
  _Post(
    username: 'James Walker',
    avatarUrl: 'https://picsum.photos/seed/james/100/100',
    location: 'Reykjavik, Iceland',
    imageUrl: 'https://picsum.photos/seed/icelandpost/800/600',
    caption: 'Northern lights hit different when you\'re standing on a glacier at midnight.',
    timeAgo: '5h ago',
    likes: 512,
    comments: 67,
  ),
  _Post(
    username: 'Priya Sharma',
    avatarUrl: 'https://picsum.photos/seed/priya/100/100',
    location: 'Kyoto, Japan',
    imageUrl: 'https://picsum.photos/seed/kyotopost/800/600',
    caption: 'Morning tea in a 400-year-old garden. Slow travel is the only way.',
    timeAgo: '8h ago',
    likes: 198,
    comments: 21,
  ),
];

class _Story {
  final String name;
  final String avatarUrl;
  final bool isLive;

  const _Story({required this.name, required this.avatarUrl, this.isLive = false});
}

const _stories = [
  _Story(name: 'Your Story', avatarUrl: 'https://picsum.photos/seed/alex/100/100'),
  _Story(name: 'Mia', avatarUrl: 'https://picsum.photos/seed/mia/100/100', isLive: true),
  _Story(name: 'James', avatarUrl: 'https://picsum.photos/seed/james/100/100'),
  _Story(name: 'Priya', avatarUrl: 'https://picsum.photos/seed/priya/100/100', isLive: true),
  _Story(name: 'Leo', avatarUrl: 'https://picsum.photos/seed/leo/100/100'),
  _Story(name: 'Sara', avatarUrl: 'https://picsum.photos/seed/sara/100/100'),
];

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

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
                  'Community',
                  style: GoogleFonts.epilogue(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tertiary,
                  ),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline_rounded, size: 22, color: AppColors.onSurfaceVariant),
                    onPressed: () {},
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Stories row
                      _buildStories(),
                      const SizedBox(height: 24),

                      // Posts
                      ..._posts.asMap().entries.map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: _PostCard(post: e.value)
                            .animate()
                            .fadeIn(delay: Duration(milliseconds: 100 * e.key), duration: 500.ms),
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
            child: BottomNavBar(currentIndex: 3),
          ),
        ],
      ),
    );
  }

  Widget _buildStories() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: _stories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, i) {
          final story = _stories[i];
          final isFirst = i == 0;
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: story.isLive
                          ? const LinearGradient(
                              colors: [AppColors.primary, Color(0xFF2D5A47)],
                            )
                          : null,
                      border: !story.isLive
                          ? Border.all(color: AppColors.ghostBorder, width: 2)
                          : null,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: story.avatarUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            Container(color: AppColors.surfaceContainerHighest),
                        errorWidget: (context, url, error) =>
                            Container(color: AppColors.surfaceContainerHighest),
                      ),
                    ),
                  ),
                  if (isFirst)
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                          border: Border.all(color: AppColors.background, width: 2),
                        ),
                        child: const Icon(Icons.add, size: 14, color: AppColors.onPrimary),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                story.name,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          );
        },
      ),
    ).animate().fadeIn(duration: 400.ms);
  }
}

class _PostCard extends StatelessWidget {
  final _Post post;
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: post.avatarUrl,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(width: 40, height: 40, color: AppColors.surfaceContainerHighest),
                  errorWidget: (context, url, error) =>
                      Container(width: 40, height: 40, color: AppColors.surfaceContainerHighest),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.username,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.tertiaryFixed,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.place_rounded, size: 12, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(
                          post.location,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        Text(
                          '  •  ${post.timeAgo}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz_rounded, size: 20, color: AppColors.onSurfaceVariant),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Image
        SizedBox(
          height: 320,
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: post.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: AppColors.surfaceContainerLow),
            errorWidget: (context, url, error) => Container(color: AppColors.surfaceContainerLow),
          ),
        ),
        const SizedBox(height: 12),

        // Actions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.favorite_border_rounded, size: 24, color: AppColors.tertiaryFixed),
                  const SizedBox(width: 16),
                  const Icon(Icons.chat_bubble_outline_rounded, size: 22, color: AppColors.tertiaryFixed),
                  const SizedBox(width: 16),
                  const Icon(Icons.send_rounded, size: 22, color: AppColors.tertiaryFixed),
                  const Spacer(),
                  const Icon(Icons.bookmark_border_rounded, size: 24, color: AppColors.tertiaryFixed),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                '${post.likes} likes',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.tertiaryFixed,
                ),
              ),
              const SizedBox(height: 6),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.inter(fontSize: 13, height: 1.5, color: AppColors.onSurfaceVariant),
                  children: [
                    TextSpan(
                      text: '${post.username}  ',
                      style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.tertiaryFixed),
                    ),
                    TextSpan(text: post.caption),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'View all ${post.comments} comments',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
