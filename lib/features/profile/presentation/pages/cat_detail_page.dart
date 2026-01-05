import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/data/mock_data.dart';

class CatDetailPage extends StatefulWidget {
  const CatDetailPage({super.key});

  @override
  State<CatDetailPage> createState() => _CatDetailPageState();
}

class _CatDetailPageState extends State<CatDetailPage> {
  late Map<String, dynamic> _cat;
  int _currentPhotoIndex = 0;

  @override
  void initState() {
    super.initState();
    // Get cat data from arguments or use mock
    _cat = Get.arguments ?? {
      'id': 'my_cat_1',
      'name': 'Whiskers',
      'breed': 'Persian',
      'birthDate': DateTime(2022, 3, 15),
      'gender': 'Male',
      'photos': [
        'https://placekitten.com/400/500',
        'https://placekitten.com/401/501',
        'https://placekitten.com/402/502',
      ],
      'isVerified': true,
      'isSterilized': false,
      'vaccinationStatus': 'Full',
      'location': 'Jakarta Selatan',
      'tags': ['Playful', 'Cuddly', 'Active'],
      'about': 'Whiskers is a friendly Persian cat who loves to play and cuddle. He enjoys chasing toys and napping in sunny spots.',
      'stats': {
        'views': 156,
        'likes': 48,
        'matches': 12,
      },
    };
    
    // Ensure photos is a list
    if (_cat['photos'] == null) {
      _cat['photos'] = [_cat['photo'] ?? 'https://placekitten.com/400/500'];
    }
  }

  String get _age {
    final birthDate = _cat['birthDate'] as DateTime;
    return MockData.calculateAge(birthDate);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final photos = _cat['photos'] as List;
    final stats = _cat['stats'] as Map<String, dynamic>?;
    final tags = _cat['tags'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
      body: CustomScrollView(
        slivers: [
          // App bar with photo
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
                onPressed: () {
                  Get.snackbar(
                    'Edit Cat',
                    'Edit feature coming soon!',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.share, color: Colors.white),
                ),
                onPressed: () {
                  Get.snackbar(
                    'Share',
                    'Share feature coming soon!',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Photo
                  PageView.builder(
                    itemCount: photos.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPhotoIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        photos[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.primarySoft,
                            child: const Icon(Icons.pets, size: 80, color: AppColors.primary),
                          );
                        },
                      );
                    },
                  ),
                  
                  // Gradient overlay
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),
                  ),
                  
                  // Photo indicators
                  if (photos.length > 1)
                    Positioned(
                      bottom: 16,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          photos.length,
                          (index) => Container(
                            width: index == _currentPhotoIndex ? 20 : 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              color: index == _currentPhotoIndex
                                  ? AppColors.primary
                                  : Colors.white.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    
                  // Verified badge
                  if (_cat['isVerified'] == true)
                    Positioned(
                      top: 100,
                      right: 16,
                      child: Container(
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
                              style: AppTextStyles.label.copyWith(color: Colors.white),
                            ),
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
              padding: const EdgeInsets.all(AppDimensions.spacingLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name and gender
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  _cat['name'],
                                  style: AppTextStyles.displayMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: _cat['gender'] == 'Male'
                                        ? AppColors.secondary.withValues(alpha: 0.2)
                                        : AppColors.primary.withValues(alpha: 0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _cat['gender'] == 'Male' ? Icons.male : Icons.female,
                                    size: 20,
                                    color: _cat['gender'] == 'Male' ? AppColors.secondary : AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${_cat['breed']} • $_age',
                              style: AppTextStyles.bodyLarge.copyWith(
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppDimensions.spacingLg),

                  // Stats (if available)
                  if (stats != null) ...[
                    _buildStatsSection(stats, isDark),
                    const SizedBox(height: AppDimensions.spacingLg),
                  ],

                  // Location
                  if (_cat['location'] != null) ...[
                    _buildInfoRow(Icons.location_on, 'Location', _cat['location'], isDark),
                    const SizedBox(height: AppDimensions.spacingMd),
                  ],

                  // Health info
                  _buildInfoRow(
                    Icons.health_and_safety,
                    'Health Status',
                    _buildHealthStatus(),
                    isDark,
                  ),

                  const SizedBox(height: AppDimensions.spacingLg),

                  // Personality tags
                  if (tags.isNotEmpty) ...[
                    Text(
                      'Personality',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingSm),
                    Wrap(
                      spacing: AppDimensions.spacingSm,
                      runSpacing: AppDimensions.spacingSm,
                      children: tags.map((tag) => _buildTagChip(tag.toString(), isDark)).toList(),
                    ),
                    const SizedBox(height: AppDimensions.spacingLg),
                  ],

                  // About
                  if (_cat['about'] != null) ...[
                    Text(
                      'About',
                      style: AppTextStyles.titleMedium.copyWith(
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingSm),
                    Text(
                      _cat['about'],
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],

                  const SizedBox(height: AppDimensions.spacingXxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _buildHealthStatus() {
    final parts = <String>[];
    
    if (_cat['isSterilized'] == true) {
      parts.add('Sterilized');
    }
    
    if (_cat['vaccinationStatus'] != null) {
      parts.add('Vaccination: ${_cat['vaccinationStatus']}');
    }
    
    return parts.isNotEmpty ? parts.join(' • ') : 'Not specified';
  }

  Widget _buildStatsSection(Map<String, dynamic> stats, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBgCard : AppColors.primarySoft.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(Icons.visibility, stats['views'].toString(), 'Views', isDark),
          _buildStatItem(Icons.favorite, stats['likes'].toString(), 'Likes', isDark),
          _buildStatItem(Icons.pets, stats['matches'].toString(), 'Matches', isDark),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label, bool isDark) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, bool isDark) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: AppDimensions.spacingMd),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTagChip(String tag, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingSm,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkChipBg : AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Text(
        tag,
        style: AppTextStyles.label.copyWith(
          color: isDark ? AppColors.darkChipText : AppColors.primary,
        ),
      ),
    );
  }
}
