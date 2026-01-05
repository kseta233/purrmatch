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
      backgroundColor: const Color(0xFFFFF8F1), // White with a bit of orange
      body: Stack(
        children: [
          SafeArea(
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
          
          // Floating Glass Back/Close Button
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            child: _glassButton(
              icon: Icons.close,
              onTap: _goBackToFeed,
              isDark: isDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _glassButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.05),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
      ),
    );
  }

  Widget _buildContent(bool isDark) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 60),
          
          // Cat photos side by side (Overlapping)
          SizedBox(
            height: 160,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Heart icon in the middle (Z-index high)
                Positioned(
                  bottom: 50,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.primary,
                      size: 28,
                    ),
                  ),
                ),
                
                // Avatars
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // My cat
                    _buildCatAvatar(
                      imageUrl: _myCat?['photo'] ?? 'https://placekitten.com/200/200',
                      name: _myCat?['name'] ?? 'Whiskers',
                    ),
                    
                    // Use Transform to overlap without negative SizedBox
                    Transform.translate(
                      offset: const Offset(-30, 0),
                      child: _buildCatAvatar(
                        imageUrl: (_matchedCat?['photos'] as List?)?.first ?? 'https://placekitten.com/201/201',
                        name: _matchedCat?['name'] ?? 'Mochi',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
  
          const SizedBox(height: 40),
          
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'It\'s a Match!',
                style: AppTextStyles.displayMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                '🎉',
                style: TextStyle(fontSize: 32),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          Text(
            'You and ${_matchedCat?['name'] ?? 'Mochi'} liked each other!',
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.lightTextSecondary,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
  
          const SizedBox(height: 40),
  
          // Owner contact section (Card)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Owner Contact',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Owner details in a row for more card-like feel
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(
                          _matchedCat?['owner']?['photo'] ?? 'https://i.pravatar.cc/150?u=sarah',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _matchedCat?['owner']?['name'] ?? 'Sarah Kusuma',
                            style: AppTextStyles.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.lightTextPrimary,
                            ),
                          ),
                          Text(
                            _matchedCat?['owner']?['instagram'] ?? '@sarahkusuma',
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Instagram button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _openInstagram,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE91E63),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                        ),
                      ),
                      child: Text(
                        'Open Instagram',
                        style: AppTextStyles.button.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
  
          const SizedBox(height: 48),
  
          // Back action button
          TextButton(
            onPressed: _goBackToFeed,
            child: Text(
              'Keep Swiping',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
          
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCatAvatar({
    required String imageUrl,
    required String name,
  }) {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          name,
          style: AppTextStyles.titleMedium.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
