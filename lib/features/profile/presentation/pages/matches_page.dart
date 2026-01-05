import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock matches data
  final List<Map<String, dynamic>> _matches = [
    {
      'id': 'match_1',
      'myCat': {
        'name': 'Whiskers',
        'photo': 'https://placekitten.com/200/200',
      },
      'matchedCat': {
        'name': 'Luna',
        'breed': 'Persian',
        'photo': 'https://placekitten.com/201/201',
      },
      'owner': {
        'name': 'Budi Santoso',
        'instagram': '@budisantoso',
        'photo': 'https://i.pravatar.cc/150?img=3',
      },
      'matchedAt': DateTime(2024, 12, 28),
      'hasContacted': false,
    },
    {
      'id': 'match_2',
      'myCat': {
        'name': 'Whiskers',
        'photo': 'https://placekitten.com/200/200',
      },
      'matchedCat': {
        'name': 'Simba',
        'breed': 'Maine Coon',
        'photo': 'https://placekitten.com/202/202',
      },
      'owner': {
        'name': 'Dewi Lestari',
        'instagram': '@dewilestari',
        'photo': 'https://i.pravatar.cc/150?img=5',
      },
      'matchedAt': DateTime(2024, 12, 25),
      'hasContacted': true,
    },
    {
      'id': 'match_3',
      'myCat': {
        'name': 'Mittens',
        'photo': 'https://placekitten.com/203/203',
      },
      'matchedCat': {
        'name': 'Oliver',
        'breed': 'Scottish Fold',
        'photo': 'https://placekitten.com/204/204',
      },
      'owner': {
        'name': 'Maya Putri',
        'instagram': '@mayaputri',
        'photo': 'https://i.pravatar.cc/150?img=9',
      },
      'matchedAt': DateTime(2024, 12, 20),
      'hasContacted': false,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    
    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
      appBar: AppBar(
        title: const Text('Matches'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All Matches'),
            Tab(text: 'Not Contacted'),
          ],
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // All matches
          _buildMatchesList(_matches, isDark),
          // Not contacted
          _buildMatchesList(
            _matches.where((m) => m['hasContacted'] == false).toList(),
            isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildMatchesList(List<Map<String, dynamic>> matches, bool isDark) {
    if (matches.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return _buildMatchCard(matches[index], isDark);
      },
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
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border,
                size: 60,
                color: AppColors.primary.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            Text(
              'No matches yet',
              style: AppTextStyles.titleMedium,
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            Text(
              'Keep swiping to find the perfect match for your cat!',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spacingLg),
            ElevatedButton.icon(
              onPressed: () => Get.offAllNamed('/feed'),
              icon: const Icon(Icons.pets),
              label: const Text('Go to Feed'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(180, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMatchCard(Map<String, dynamic> match, bool isDark) {
    final myCat = match['myCat'] as Map<String, dynamic>;
    final matchedCat = match['matchedCat'] as Map<String, dynamic>;
    final owner = match['owner'] as Map<String, dynamic>;
    final matchedAt = match['matchedAt'] as DateTime;
    final hasContacted = match['hasContacted'] as bool;

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
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date label
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(matchedAt),
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                  ),
                ),
                if (!hasContacted)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                    ),
                    child: Text(
                      'New',
                      style: AppTextStyles.label.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
              ],
            ),
            
            const SizedBox(height: AppDimensions.spacingMd),
            
            // Cats photos
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // My cat
                _buildCatAvatar(myCat['name'], true, isDark),
                
                // Heart connector
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 40,
                        height: 2,
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.favorite, color: Colors.white, size: 14),
                      ),
                    ],
                  ),
                ),
                
                // Matched cat
                _buildCatAvatar(matchedCat['name'], false, isDark),
              ],
            ),
            
            const SizedBox(height: AppDimensions.spacingMd),
            
            // Match info
            Center(
              child: Text(
                '${myCat['name']} matched with ${matchedCat['name']}',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                ),
              ),
            ),
            
            const SizedBox(height: 4),
            
            Center(
              child: Text(
                matchedCat['breed'],
                style: AppTextStyles.bodySmall.copyWith(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
            ),
            
            const SizedBox(height: AppDimensions.spacingMd),
            
            // Divider
            Container(
              height: 1,
              color: isDark ? AppColors.darkBorderDefault : AppColors.lightBorderDefault,
            ),
            
            const SizedBox(height: AppDimensions.spacingMd),
            
            // Owner info
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primarySoft,
                  child: Icon(Icons.person, color: AppColors.primary, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        owner['name'],
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        ),
                      ),
                      Text(
                        owner['instagram'],
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.snackbar(
                      'Opening Instagram',
                      'Opening ${owner['instagram']}',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Contact'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCatAvatar(String name, bool isMine, bool isDark) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            shape: BoxShape.circle,
            border: Border.all(
              color: isMine ? AppColors.secondary : AppColors.primary,
              width: 2,
            ),
          ),
          child: Icon(
            Icons.pets,
            color: isMine ? AppColors.secondary : AppColors.primary,
            size: 28,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
        ),
        Text(
          isMine ? 'Your cat' : 'Match',
          style: AppTextStyles.label.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
