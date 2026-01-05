import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class MyCatsListPage extends StatefulWidget {
  const MyCatsListPage({super.key});

  @override
  State<MyCatsListPage> createState() => _MyCatsListPageState();
}

class _MyCatsListPageState extends State<MyCatsListPage> {
  // Mock user's cats with stats
  final List<Map<String, dynamic>> _myCats = [
    {
      'id': 'my_cat_1',
      'name': 'Whiskers',
      'breed': 'Persian',
      'birthDate': DateTime(2022, 3, 15),
      'gender': 'Male',
      'photo': 'https://placekitten.com/300/300',
      'isVerified': true,
      'isSterilized': false,
      'vaccinationStatus': 'Full',
      'tags': ['Playful', 'Cuddly', 'Active'],
      'about': 'Whiskers loves to play and cuddle!',
      'stats': {
        'views': 156,
        'likes': 48,
        'matches': 12,
      },
    },
    {
      'id': 'my_cat_2',
      'name': 'Mittens',
      'breed': 'British Shorthair',
      'birthDate': DateTime(2023, 1, 20),
      'gender': 'Female',
      'photo': 'https://placekitten.com/301/301',
      'isVerified': false,
      'isSterilized': true,
      'vaccinationStatus': 'Partial',
      'tags': ['Calm', 'Independent'],
      'about': 'Mittens is a calm and elegant lady.',
      'stats': {
        'views': 89,
        'likes': 24,
        'matches': 5,
      },
    },
  ];

  String _calculateAge(DateTime birthDate) {
    final now = DateTime.now();
    final years = now.year - birthDate.year;
    
    if (years == 0) {
      final months = now.month - birthDate.month;
      return '$months mo';
    } else {
      return '$years yr';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
      appBar: AppBar(
        title: const Text('My Cats'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Cat list
          _myCats.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimensions.spacingLg,
                    AppDimensions.spacingLg,
                    AppDimensions.spacingLg,
                    100, // Extra padding for FAB
                  ),
                  itemCount: _myCats.length,
                  itemBuilder: (context, index) {
                    return _buildCatCard(_myCats[index], isDark);
                  },
                ),
          
          // Bottom FAB
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.spacingLg),
              child: SafeArea(
                top: false,
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () => Get.toNamed('/register/cat-profile'),
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('Add New Cat'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 52),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingXl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              ),
              child: Icon(
                Icons.pets,
                size: 60,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            Text(
              'No cats yet',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(
              'Add your first cat to start finding matches!',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatCard(Map<String, dynamic> cat, bool isDark) {
    final stats = cat['stats'] as Map<String, dynamic>;
    final age = _calculateAge(cat['birthDate'] as DateTime);
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spacingMd),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBgCard : AppColors.lightBgCard,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        child: InkWell(
          onTap: () {
            Get.toNamed('/profile/cats/${cat['id']}', arguments: cat);
          },
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          child: Column(
            children: [
              // Main content row
              Padding(
                padding: const EdgeInsets.all(AppDimensions.spacingMd),
                child: Row(
                  children: [
                    // Photo placeholder with paw icon
                    Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppColors.primarySoft,
                            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
                          ),
                          child: Icon(
                            Icons.pets,
                            size: 48,
                            color: AppColors.primary.withValues(alpha: 0.6),
                          ),
                        ),
                        // Verified badge
                        if (cat['isVerified'] == true)
                          Positioned(
                            top: -4,
                            left: -4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.success,
                                borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.verified, size: 12, color: Colors.white),
                                  const SizedBox(width: 3),
                                  Text(
                                    'Verified',
                                    style: AppTextStyles.label.copyWith(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    
                    const SizedBox(width: AppDimensions.spacingMd),
                    
                    // Cat info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name and Gender
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  cat['name'],
                                  style: AppTextStyles.titleMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                  ),
                                ),
                              ),
                              Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: cat['gender'] == 'Male'
                                      ? AppColors.secondary.withValues(alpha: 0.15)
                                      : AppColors.primary.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  cat['gender'] == 'Male' ? Icons.male : Icons.female,
                                  size: 18,
                                  color: cat['gender'] == 'Male' ? AppColors.secondary : AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Breed and age
                          Text(
                            '${cat['breed']} • $age',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            ),
                          ),
                          
                          const SizedBox(height: AppDimensions.spacingSm),
                          
                          // Tap to view details
                          Row(
                            children: [
                              Text(
                                '•••',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Tap to view details',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Stats row at bottom
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.spacingLg,
                  vertical: AppDimensions.spacingMd,
                ),
                decoration: BoxDecoration(
                  color: isDark 
                      ? AppColors.darkBgPrimary.withValues(alpha: 0.3)
                      : AppColors.lightBgPrimary,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(AppDimensions.radiusLarge),
                    bottomRight: Radius.circular(AppDimensions.radiusLarge),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      icon: Icons.visibility_outlined,
                      value: stats['views'].toString(),
                      label: 'Views',
                      isDark: isDark,
                    ),
                    _buildStatItem(
                      icon: Icons.favorite,
                      value: stats['likes'].toString(),
                      label: 'Likes',
                      isDark: isDark,
                      iconColor: Colors.red,
                    ),
                    _buildStatItem(
                      icon: Icons.pets,
                      value: stats['matches'].toString(),
                      label: 'Matches',
                      isDark: isDark,
                      iconColor: AppColors.primary,
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

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required bool isDark,
    Color? iconColor,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: iconColor ?? (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
          ),
        ),
      ],
    );
  }
}
