import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  int _logoTapCount = 0;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement login logic with controller
      print('Login with: ${_emailController.text}');
      Get.snackbar(
        'Login',
        'Login functionality will be implemented soon',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _handleGoogleSignIn() {
    // TODO: Implement Google sign-in
    Get.snackbar(
      'Google Sign-In',
      'Google authentication will be implemented soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _handleAppleSignIn() {
    // TODO: Implement Apple sign-in
    Get.snackbar(
      'Apple Sign-In',
      'Apple authentication will be implemented soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppDimensions.spacingLg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo and branding
                _buildBranding(isDark),
                
                const SizedBox(height: AppDimensions.spacingXxl),
                
                // Login form
                _buildLoginForm(theme),
                
                const SizedBox(height: AppDimensions.spacingLg),
                
                // Forgot password
                _buildForgotPassword(theme),
                
                const SizedBox(height: AppDimensions.spacingLg),
                
                // Login button
                _buildLoginButton(),
                
                const SizedBox(height:AppDimensions.spacingXl),
                
                // Social auth
                _buildSocialAuth(theme),
                
                const SizedBox(height: AppDimensions.spacingXl),
                
                // Register link
                _buildRegisterLink(theme),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBranding(bool isDark) {
    return Column(
      children: [
        // Logo placeholder (paw icon) with easter egg
        GestureDetector(
          onTap: () {
            setState(() {
              _logoTapCount++;
            });
            
            if (_logoTapCount >= 5) {
              // Easter egg activated!
              Get.snackbar(
                '🐱 Easter Egg Found!',
                'Welcome to the secret shortcut, Paw-rent!',
                snackPosition: SnackPosition.TOP,
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
              
              // Navigate to feed after a short delay
              Future.delayed(const Duration(milliseconds: 500), () {
                // TODO: Navigate to feed when it's ready
                // Get.offAllNamed(AppRoutes.feed);
                Get.snackbar(
                  'Coming Soon',
                  'Feed page will be available soon!',
                  snackPosition: SnackPosition.BOTTOM,
                );
              });
              
              _logoTapCount = 0; // Reset counter
            }
          },
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
            ),
            child: const Icon(
              Icons.pets,
              size: 60,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: AppDimensions.spacingLg),
        
        // Greeting
        Text(
          'Hello, Paw-rent! 🐾',
          style: AppTextStyles.displayMedium.copyWith(
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacingSm),
        
        Text(
          'Join Indonesia\'s safest cat breeding\ncommunity to find the purr-fect match.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginForm(ThemeData theme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email Address',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'name@example.com',
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!GetUtils.isEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          
          const SizedBox(height: AppDimensions.spacingMd),
          
          Text(
            'Password',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            decoration: InputDecoration(
              hintText: 'Enter your password',
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForgotPassword(ThemeData theme) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Get.snackbar(
            'Forgot Password',
            'Password reset will be implemented soon',
            snackPosition: SnackPosition.BOTTOM,
          );
        },
        child: Text(
          'Forgot Password?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _handleLogin,
      child: const Text('Log In'),
    );
  }

  Widget _buildSocialAuth(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    
    return Column(
      children: [
        Text(
          'Or continue with',
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingMd),
        
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _handleGoogleSignIn,
                icon: const Icon(Icons.g_mobiledata, size: 24),
                label: const Text('Google'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.spacingMd,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppDimensions.spacingMd),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _handleAppleSignIn,
                icon: const Icon(Icons.apple, size: 24),
                label: const Text('Apple'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDimensions.spacingMd,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRegisterLink(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        TextButton(
          onPressed: () {
            // TODO: Navigate to register page
            Get.snackbar(
              'Register',
              'Registration page will be implemented soon',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.spacingXs),
          ),
          child: Text(
            'Register',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
