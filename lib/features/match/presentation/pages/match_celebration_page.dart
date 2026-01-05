import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class MatchCelebrationPage extends StatefulWidget {
  const MatchCelebrationPage({super.key});

  @override
  State<MatchCelebrationPage> createState() => _MatchCelebrationPageState();
}

class _MatchCelebrationPageState extends State<MatchCelebrationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  Map<String, dynamic>? _matchedCat;
  Map<String, dynamic>? _myCat;

  @override
  void initState() {
    super.initState();
    
    // Get arguments
    final args = Get.arguments as Map<String, dynamic>?;
    _matchedCat = args?['cat'];
    _myCat = args?['myCat'];

    // Setup animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _openInstagram() async {
    if (_matchedCat == null) return;
    
    final owner = _matchedCat!['owner'] as Map<String, dynamic>;
    final instagram = owner['instagram'] as String;
    final username = instagram.replaceAll('@', '');
    
    final Uri instagramUrl = Uri.parse('https://instagram.com/$username');
    
    try {
      if (await canLaunchUrl(instagramUrl)) {
        await launchUrl(instagramUrl, mode: LaunchMode.externalApplication);
      } else {
        Get.snackbar(
          'Error',
          'Could not open Instagram',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not open Instagram',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _goBackToFeed() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: _buildContent(isDark),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(bool isDark) {
    final owner = _matchedCat?['owner'] as Map<String, dynamic>?;

    return Padding(
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Header
          Text(
            'It\'s a Match! 🎉',
            style: AppTextStyles.displayLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacingSm),
          
          Text(
            'You and ${_matchedCat?['name'] ?? 'this cat'} liked each other!',
            style: AppTextStyles.bodyLarge.copyWith(
              color: Colors.white.withValues(alpha: 0.9),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppDimensions.spacingXxl),

          // Cat photos side by side
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // My cat
              _buildCatAvatar(
                imageUrl: _myCat?['photo'] ?? 'https://placekitten.com/200/200',
                name: _myCat?['name'] ?? 'Your Cat',
                isLeft: true,
              ),
              
              // Heart icon in the middle
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 40,
                ),
              ),
              
              // Matched cat
              _buildCatAvatar(
                imageUrl: (_matchedCat?['photos'] as List?)?.first ?? 'https://placekitten.com/201/201',
                name: _matchedCat?['name'] ?? 'Matched Cat',
                isLeft: false,
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.spacingXxl),

          // Owner contact section
          Container(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Owner Contact',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.lightTextPrimary,
                  ),
                ),
                
                const SizedBox(height: AppDimensions.spacingMd),
                
                // Owner info
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        owner?['photo'] ?? 'https://i.pravatar.cc/150',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          owner?['name'] ?? 'Cat Owner',
                          style: AppTextStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightTextPrimary,
                          ),
                        ),
                        Text(
                          owner?['instagram'] ?? '@instagram',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: AppDimensions.spacingLg),
                
                // Instagram button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _openInstagram,
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Open Instagram'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE1306C), // Instagram pink
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppDimensions.spacingLg),

          // Back to feed button
          TextButton(
            onPressed: _goBackToFeed,
            child: Text(
              'Back to Feed',
              style: AppTextStyles.button.copyWith(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCatAvatar({
    required String imageUrl,
    required String name,
    required bool isLeft,
  }) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          name,
          style: AppTextStyles.bodyMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
