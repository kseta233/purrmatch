import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/data/mock_data.dart';

class CatCard extends StatelessWidget {
  final Map<String, dynamic> cat;
  final double percentThresholdX;

  const CatCard({
    super.key,
    required this.cat,
    this.percentThresholdX = 0,
  });

  String get _age {
    final birthDate = cat['birthDate'] as DateTime;
    return MockData.calculateAge(birthDate);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final owner = cat['owner'] as Map<String, dynamic>;
    final tags = cat['tags'] as List<dynamic>;
    final isVerified = cat['isVerified'] as bool;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            _buildBackgroundImage(),

            // Gradient overlay
            _buildGradientOverlay(),

            // Swipe indicator overlays
            if (percentThresholdX != 0) _buildSwipeIndicator(),

            // Content
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildCardContent(isDark, owner, tags, isVerified),
            ),

            // Verified badge
            if (isVerified)
              Positioned(
                top: 16,
                right: 16,
                child: _buildVerifiedBadge(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    final photos = cat['photos'] as List<dynamic>;
    return CachedNetworkImage(
      imageUrl: photos.isNotEmpty ? photos[0] : 'https://placekitten.com/400/600',
      fit: BoxFit.cover,
      placeholder: (context, url) => Container(
        color: AppColors.primarySoft,
        child: const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.primarySoft,
        child: const Icon(Icons.pets, size: 60, color: AppColors.primary),
      ),
    );
  }

  Widget _buildGradientOverlay() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.transparent,
            Colors.black.withValues(alpha: 0.3),
            Colors.black.withValues(alpha: 0.8),
          ],
          stops: const [0.0, 0.4, 0.7, 1.0],
        ),
      ),
    );
  }

  Widget _buildSwipeIndicator() {
    final isLike = percentThresholdX > 0;
    final opacity = percentThresholdX.abs().clamp(0.0, 1.0);

    return Positioned(
      top: 40,
      left: isLike ? null : 20,
      right: isLike ? 20 : null,
      child: Opacity(
        opacity: opacity,
        child: Transform.rotate(
          angle: isLike ? 0.3 : -0.3,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: isLike ? AppColors.success : AppColors.danger,
                width: 3,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            ),
            child: Text(
              isLike ? 'LIKE' : 'NOPE',
              style: TextStyle(
                color: isLike ? AppColors.success : AppColors.danger,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardContent(bool isDark, Map<String, dynamic> owner, List<dynamic> tags, bool isVerified) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Name and age
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      cat['name'],
                      style: AppTextStyles.displayMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _age,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              // Gender icon
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: cat['gender'] == 'Male' 
                      ? AppColors.secondary.withValues(alpha: 0.8)
                      : AppColors.primary.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  cat['gender'] == 'Male' ? Icons.male : Icons.female,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Breed
          Text(
            cat['breed'],
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),

          const SizedBox(height: 8),

          // Location
          Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.white.withValues(alpha: 0.8),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '${cat['location']} • ${cat['distance']}',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Tags
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: tags.take(3).map((tag) => _buildTag(tag.toString())).toList(),
          ),

          const SizedBox(height: 12),

          // Divider
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.2),
          ),

          const SizedBox(height: 12),

          // Owner info
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: NetworkImage(owner['photo']),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Owner: ${owner['name']}',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      owner['instagram'],
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String tag) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Text(
        tag,
        style: AppTextStyles.label.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildVerifiedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.success,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified, color: Colors.white, size: 14),
          const SizedBox(width: 4),
          Text(
            'Verified',
            style: AppTextStyles.label.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
