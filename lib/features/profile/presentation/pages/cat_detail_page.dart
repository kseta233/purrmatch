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
      'weight': '4.5',
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
  }

  String get _age {
    final birthDate = _cat['birthDate'] as DateTime;
    return MockData.calculateAge(birthDate);
  }

  void _showDeactivateDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Deactivate Profile'),
        content: const Text(
          'Are you sure you want to deactivate this cat\'s profile? It will no longer appear in the feed and won\'t receive any new matches.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Profile Deactivated',
                'This cat profile has been deactivated',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.warning,
                colorText: Colors.white,
              );
              Get.back();
            },
            child: Text(
              'Deactivate',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final stats = _cat['stats'] as Map<String, dynamic>?;
    final tags = _cat['tags'] as List<dynamic>? ?? [];

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgSecondary,
      body: Stack(
        children: [
          // Content Scroll
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main photo (Sharp bottom)
                _buildMainPhoto(isDark),

                // White details section overlapping the photo
                Transform.translate(
                  offset: const Offset(0, -40),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkBgPrimary : AppColors.lightBgSecondary,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: AppDimensions.spacingLg),
                        
                        // Matches count
                        if (stats != null) _buildMatchesSection(stats, isDark),

                        const SizedBox(height: AppDimensions.spacingLg),

                        // Quick info (Gender, Age, Weight)
                        _buildQuickInfo(isDark),

                        const SizedBox(height: AppDimensions.spacingXl),

                        // About section
                        _buildAboutSection(isDark),

                        const SizedBox(height: AppDimensions.spacingXl),

                        // Details section (Location, Vaccinated, Sterilized)
                        _buildDetailsSection(isDark),

                        const SizedBox(height: AppDimensions.spacingXl),

                        // Personality tags
                        if (tags.isNotEmpty) _buildPersonalitySection(tags, isDark),

                        const SizedBox(height: AppDimensions.spacingXl),

                        // Photos section
                        _buildPhotosSection(isDark),

                        const SizedBox(height: AppDimensions.spacingLg),

                        // Deactivate profile button
                        Center(
                          child: TextButton(
                            onPressed: _showDeactivateDialog,
                            child: Text(
                              'Deactivate Profile',
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary).withValues(alpha: 0.8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: AppDimensions.spacingXl),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Top buttons overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingMd, vertical: AppDimensions.spacingSm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _circleButton(
                    icon: Icons.arrow_back,
                    onTap: () => Get.back(),
                    isDark: isDark,
                  ),
                  _circleButton(
                    icon: Icons.edit_outlined,
                    onTap: () {
                      Get.snackbar(
                        'Edit Cat',
                        'Edit feature coming soon!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainPhoto(bool isDark) {
    return Container(
      width: double.infinity,
      height: 480,
      decoration: const BoxDecoration(
        color: AppColors.primarySoft,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Photo placeholder
          Container(
            color: AppColors.primarySoft,
            child: Center(
              child: Icon(
                Icons.pets,
                size: 80,
                color: AppColors.primary.withValues(alpha: 0.4),
              ),
            ),
          ),
          
          // Gradient overlay at bottom
          Positioned.fill(
            child: Container(
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
          
          // Name and breed overlaid at bottom
          Positioned(
            bottom: 60, // Moved up to account for the overlap radius
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name
                Text(
                  _cat['name'] ?? '',
                  style: const TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Breed
                Text(
                  _cat['breed'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          
          // Verified badge
          if (_cat['isVerified'] == true)
            Positioned(
              top: MediaQuery.of(context).padding.top + 60,
              right: 20,
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
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }

  Widget _buildMatchesSection(Map<String, dynamic> stats, bool isDark) {
    final matchCount = stats['matches'] ?? 0;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
      ),
      child: InkWell(
        onTap: () => Get.toNamed('/profile/matches'),
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: Row(
          children: [
            // Overlapping cat avatars
            SizedBox(
              width: 60,
              height: 40,
              child: Stack(
                children: [
                  // First cat avatar
                  Positioned(
                    left: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: ClipOval(
                        child: Icon(
                          Icons.pets,
                          color: AppColors.primary.withValues(alpha: 0.6),
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  // Second cat avatar (overlapping)
                  if (matchCount > 1)
                    Positioned(
                      left: 20,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primarySoft,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        child: ClipOval(
                          child: Icon(
                            Icons.pets,
                            color: AppColors.primary.withValues(alpha: 0.6),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            
            const SizedBox(width: AppDimensions.spacingMd),
            
            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$matchCount Potential Matches',
                    style: AppTextStyles.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                  Text(
                    'View matching profiles',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            
            // Arrow button
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward,
                color: AppColors.primary,
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfo(bool isDark) {
    final weight = _cat['weight'] ?? '4.5';
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      child: Row(
        children: [
          // Gender
          Expanded(
            child: _buildQuickInfoCard(
              icon: _cat['gender'] == 'Male' ? Icons.male : Icons.female,
              iconColor: _cat['gender'] == 'Male' ? AppColors.secondary : AppColors.primary,
              label: _cat['gender'],
              isDark: isDark,
            ),
          ),
          
          const SizedBox(width: AppDimensions.spacingSm),
          
          // Age
          Expanded(
            child: _buildQuickInfoCard(
              icon: Icons.cake_outlined,
              iconColor: AppColors.primary,
              label: _age,
              isDark: isDark,
            ),
          ),
          
          const SizedBox(width: AppDimensions.spacingSm),
          
          // Weight
          Expanded(
            child: _buildQuickInfoCard(
              icon: Icons.monitor_weight_outlined,
              iconColor: AppColors.primary,
              label: '$weight kg',
              isDark: isDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfoCard({
    required IconData icon,
    required Color iconColor,
    required String label,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingMd),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBgCard : AppColors.lightBgCard,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(height: 6),
          Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacingSm),
          
          Text(
            _cat['about'] ?? 'No description available.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(bool isDark) {
    final location = _cat['location'] ?? 'Not specified';
    final isVaccinated = _cat['vaccinationStatus'] == 'Full' || _cat['vaccinationStatus'] == 'Partial';
    final isSterilized = _cat['isSterilized'] == true;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Details',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacingMd),
          
          // Location card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBgCard : AppColors.lightBgCard,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Location icon
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  ),
                  child: Icon(
                    Icons.location_on,
                    color: AppColors.primary,
                    size: 22,
                  ),
                ),
                
                const SizedBox(width: AppDimensions.spacingMd),
                
                // Location text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOCATION',
                        style: AppTextStyles.label.copyWith(
                          color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                          fontSize: 10,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        location,
                        style: AppTextStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        ),
                      ),
                      Text(
                        'DKI Jakarta, Indonesia',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacingMd),
          
          // Vaccinated & Steril row
          Row(
            children: [
              // Vaccinated card
              Expanded(
                child: _buildDetailCard(
                  icon: Icons.vaccines_outlined,
                  label: 'VACCINATED',
                  value: isVaccinated ? 'Yes' : 'No',
                  iconColor: AppColors.success,
                  isDark: isDark,
                ),
              ),
              
              const SizedBox(width: AppDimensions.spacingMd),
              
              // Steril card
              Expanded(
                child: _buildDetailCard(
                  icon: Icons.content_cut_outlined,
                  label: 'STERIL',
                  value: isSterilized ? 'Yes' : 'No',
                  iconColor: AppColors.lightTextTertiary,
                  isDark: isDark,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spacingMd),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBgCard : AppColors.lightBgCard,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          
          const SizedBox(width: AppDimensions.spacingSm),
          
          // Text
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.label.copyWith(
                  color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                  fontSize: 10,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                value,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPersonalitySection(List<dynamic> tags, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personality',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacingSm),
          
          Wrap(
            spacing: AppDimensions.spacingSm,
            runSpacing: AppDimensions.spacingSm,
            children: tags.map((tag) => _buildTagChip(tag.toString(), isDark)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTagChip(String tag, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spacingMd,
        vertical: AppDimensions.spacingSm,
      ),
      decoration: BoxDecoration(
        color: AppColors.primarySoft,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Text(
        tag,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPhotosSection(bool isDark) {
    final photos = _cat['photos'] as List<dynamic>? ?? [];
    final displayCount = photos.length > 6 ? 6 : (photos.isEmpty ? 3 : photos.length);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Photos',
                style: AppTextStyles.titleMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.snackbar(
                    'Gallery',
                    'Photo gallery coming soon!',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Text(
                  'See All',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: AppDimensions.spacingSm),
          
          // Photo grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: displayCount,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.primarySoft,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                  child: Icon(
                    Icons.pets,
                    color: AppColors.primary.withValues(alpha: 0.4),
                    size: 28,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
