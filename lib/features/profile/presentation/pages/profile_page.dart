import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock user data
  final Map<String, dynamic> _user = {
    'id': 'current_user',
    'name': 'Sarah Kusuma',
    'email': 'sarah@example.com',
    'location': 'Jakarta Selatan',
    'photo': 'https://i.pravatar.cc/150?img=1',
    'about': 'Looking for the perfect breeding partners for my babies! 🐱',
    'instagram': '@sarahkusuma',
    'totalCats': 4,
    'totalMatches': 12,
    'totalLikes': 100,
  };

  // Mock cattery data
  final Map<String, dynamic> _cattery = {
    'name': 'Kusuma Cattery',
    'description': 'Premium Persian & British Shorthair breeder since 2020',
    'isVerified': true,
  };

  // Mock photos
  final List<String> _photos = [
    'https://placekitten.com/200/200',
    'https://placekitten.com/201/201',
    'https://placekitten.com/202/202',
    'https://placekitten.com/203/203',
    'https://placekitten.com/204/204',
    'https://placekitten.com/205/205',
  ];

  void _launchHelpSupport() async {
    final Uri url = Uri.parse('mailto:support@purrmatch.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with picture, name, location
            _buildProfileHeader(isDark),

            const SizedBox(height: AppDimensions.spacingMd),

            // Edit & Share buttons
            _buildActionButtons(isDark),

            const SizedBox(height: AppDimensions.spacingXl),

            // Stats row
            _buildStatsRow(isDark),

            const SizedBox(height: AppDimensions.spacingXl),

            // My Cattery section
            _buildCatterySection(isDark),

            const SizedBox(height: AppDimensions.spacingXl),

            // Photos section
            _buildPhotosSection(isDark),

            const SizedBox(height: AppDimensions.spacingXl),

            // App version & Help Support
            _buildFooterSection(isDark),

            const SizedBox(height: AppDimensions.spacingLg),

            // Logout button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed('/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.danger,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Log Out'),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.spacingXl),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      child: Column(
        children: [
          // Profile photo
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 3,
              ),
              color: AppColors.primarySoft,
            ),
            child: ClipOval(
              child: Icon(
                Icons.person,
                size: 50,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ),
          ),

          const SizedBox(height: AppDimensions.spacingMd),

          // Name
          Text(
            _user['name'],
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),

          const SizedBox(height: AppDimensions.spacingXs),

          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on,
                size: 16,
                color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
              ),
              const SizedBox(width: 4),
              Text(
                _user['location'],
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      child: Row(
        children: [
          // Edit Profile button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => Get.toNamed('/profile/edit'),
              icon: const Icon(Icons.edit, size: 18),
              label: const Text('Edit'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          
          const SizedBox(width: AppDimensions.spacingMd),
          
          // Share button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                Get.snackbar(
                  'Share Profile',
                  'Share feature coming soon!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              icon: const Icon(Icons.share, size: 18),
              label: const Text('Share'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingLg),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBgCard : AppColors.lightBgCard,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              value: '${_user['totalCats']}',
              label: 'Cats',
              isDark: isDark,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: isDark ? AppColors.darkBorderDefault : AppColors.lightBorderDefault,
          ),
          Expanded(
            child: _buildStatItem(
              value: '${_user['totalMatches']}',
              label: 'Matches',
              isDark: isDark,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: isDark ? AppColors.darkBorderDefault : AppColors.lightBorderDefault,
          ),
          Expanded(
            child: _buildStatItem(
              value: '${_user['totalLikes']}',
              label: 'Likes',
              isDark: isDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required bool isDark,
  }) {
    return Column(
      children: [
        Text(
          value,
          style: AppTextStyles.titleLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildCatterySection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Cattery',
            style: AppTextStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacingMd),
          
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.spacingMd),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkBgCard : AppColors.lightBgCard,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: InkWell(
              onTap: () => Get.toNamed('/profile/cats'),
              borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
              child: Row(
                children: [
                  // Cattery icon
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primarySoft,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                    ),
                    child: Icon(
                      Icons.pets,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                  
                  const SizedBox(width: AppDimensions.spacingMd),
                  
                  // Cattery info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              _cattery['name'],
                              style: AppTextStyles.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                              ),
                            ),
                            if (_cattery['isVerified'] == true) ...[
                              const SizedBox(width: 6),
                              Icon(
                                Icons.verified,
                                size: 16,
                                color: AppColors.success,
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _cattery['description'],
                          style: AppTextStyles.bodySmall.copyWith(
                            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  Icon(
                    Icons.chevron_right,
                    color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosSection(bool isDark) {
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
          
          // Photo grid (3 columns, 2 rows)
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: _photos.length > 6 ? 6 : _photos.length,
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
                    size: 32,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingLg),
      child: Column(
        children: [
          // App version
          Text(
            'Version 1.0.0',
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacingSm),
          
          // Help & Support link
          TextButton.icon(
            onPressed: _launchHelpSupport,
            icon: Icon(
              Icons.help_outline,
              size: 18,
              color: AppColors.primary,
            ),
            label: Text(
              'Help & Support',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
