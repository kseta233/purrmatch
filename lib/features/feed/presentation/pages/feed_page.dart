import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/data/mock_data.dart';
import '../widgets/cat_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final CardSwiperController _swiperController = CardSwiperController();
  late List<Map<String, dynamic>> _cats;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _cats = List.from(MockData.cats);
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  void _onSwipe(int previousIndex, int? currentIndex, CardSwiperDirection direction) {
    setState(() {
      _currentIndex = currentIndex ?? 0;
    });

    if (direction == CardSwiperDirection.right) {
      // Like - check for match
      _handleLike(_cats[previousIndex]);
    } else if (direction == CardSwiperDirection.left) {
      // Pass
      print('Passed: ${_cats[previousIndex]['name']}');
    }
  }

  void _handleLike(Map<String, dynamic> cat) {
    print('Liked: ${cat['name']}');
    
    // Simulate match check
    if (MockData.checkForMatch()) {
      // Match found!
      Future.delayed(const Duration(milliseconds: 300), () {
        Get.toNamed('/match/celebration', arguments: {
          'cat': cat,
          'myCat': MockData.currentUser['cats'][0],
        });
      });
    }
  }

  void _onLikePressed() {
    _swiperController.swipeRight();
  }

  void _onPassPressed() {
    _swiperController.swipeLeft();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
              ),
              child: const Icon(Icons.pets, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              'PurrMatch',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              Get.snackbar(
                'Filters',
                'Filter feature coming soon!',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),
        ],
      ),
      body: _cats.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                // Card stack
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.spacingMd,
                      vertical: AppDimensions.spacingSm,
                    ),
                    child: CardSwiper(
                      controller: _swiperController,
                      cardsCount: _cats.length,
                      numberOfCardsDisplayed: 2,
                      backCardOffset: const Offset(0, 40),
                      padding: EdgeInsets.zero,
                      onSwipe: (prev, curr, dir) {
                        _onSwipe(prev, curr, dir);
                        return true;
                      },
                      onEnd: () {
                        setState(() {
                          // Reload cats for demo
                          _cats = List.from(MockData.cats);
                        });
                        Get.snackbar(
                          'All caught up! 🎉',
                          'Check back later for more cats',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      },
                      cardBuilder: (context, index, percentThresholdX, percentThresholdY) {
                        return CatCard(
                          cat: _cats[index],
                          percentThresholdX: percentThresholdX.toDouble(),
                        );
                      },
                    ),
                  ),
                ),

                // Action buttons
                _buildActionButtons(isDark),

                const SizedBox(height: AppDimensions.spacingMd),
              ],
            ),
      bottomNavigationBar: _buildBottomNav(isDark),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pets,
            size: 80,
            color: AppColors.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: AppDimensions.spacingLg),
          Text(
            'No more cats nearby',
            style: AppTextStyles.titleMedium,
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          Text(
            'Check back later for new furry friends!',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingXl),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Pass button
          _buildActionButton(
            icon: Icons.close,
            color: AppColors.danger,
            onPressed: _onPassPressed,
            size: 56,
          ),
          
          // Super Like (favorite) - future feature
          _buildActionButton(
            icon: Icons.star,
            color: AppColors.secondary,
            onPressed: () {
              Get.snackbar(
                'Super Like',
                'This feature is coming soon!',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            size: 48,
          ),
          
          // Like button
          _buildActionButton(
            icon: Icons.favorite,
            color: AppColors.primary,
            onPressed: _onLikePressed,
            size: 56,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
    required double size,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
        ),
        child: Icon(icon, color: color, size: size * 0.5),
      ),
    );
  }

  Widget _buildBottomNav(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBgCard : AppColors.lightBgCard,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppDimensions.spacingSm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.pets, 'Feed', true),
              _buildNavItem(Icons.person_outline, 'Profile', false, onTap: () {
                Get.toNamed('/profile');
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? AppColors.primary : AppColors.lightTextTertiary,
            size: 28,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.label.copyWith(
              color: isActive ? AppColors.primary : AppColors.lightTextTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
