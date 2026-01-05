import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class CreateUserProfilePage extends StatefulWidget {
  const CreateUserProfilePage({super.key});

  @override
  State<CreateUserProfilePage> createState() => _CreateUserProfilePageState();
}

class _CreateUserProfilePageState extends State<CreateUserProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _aboutController = TextEditingController();
  String? _photoPath;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _photoPath = image.path;
      });
    }
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save user profile data
      print('User Profile: ${_nameController.text}, ${_locationController.text}');
      
      // Navigate to Add Cat Profile page
      Get.toNamed('/register/cat-profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
      appBar: AppBar(
        title: const Text('Create Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.spacingLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress indicator
              _buildProgressIndicator(),
              
              const SizedBox(height: AppDimensions.spacingXl),
              
              // Header
              _buildHeader(isDark),
              
              const SizedBox(height: AppDimensions.spacingXl),
              
              // Photo picker
              _buildPhotoPicker(isDark),
              
              const SizedBox(height: AppDimensions.spacingXl),
              
              // Form
              _buildForm(theme),
              
              const SizedBox(height: AppDimensions.spacingXl),
              
              // Privacy note
              _buildPrivacyNote(isDark),
              
              const SizedBox(height: AppDimensions.spacingLg),
              
              // Continue button
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.spacingSm),
        Expanded(
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.lightBorderDefault,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(bool isDark) {
    return Column(
      children: [
        Text(
          'Let\'s get to know you',
          style: AppTextStyles.displayMedium.copyWith(
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spacingSm),
        Text(
          'Introduce yourself to the community. Don\'t\nworry, your cat\'s profile comes next!',
          style: AppTextStyles.bodyMedium.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPhotoPicker(bool isDark) {
    return Center(
      child: GestureDetector(
        onTap: _pickPhoto,
        child: Stack(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary,
                  width: 3,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
                color: isDark ? AppColors.darkBgCard : AppColors.lightBgCard,
              ),
              child: _photoPath != null
                  ? ClipOval(
                      child: Image.network(
                        _photoPath!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.person,
                            size: 60,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    )
                  : const Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: AppColors.primary,
                    ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
                    width: 3,
                  ),
                ),
                child: const Icon(
                  Icons.edit,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(ThemeData theme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name
          Text(
            'Full Name',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'e.g. Sarah Kusuma',
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          
          const SizedBox(height: AppDimensions.spacingMd),
          
          // Location
          Text(
            'Location',
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          TextFormField(
            controller: _locationController,
            decoration: const InputDecoration(
              hintText: 'e.g. South Jakarta',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your location';
              }
              return null;
            },
          ),
          
          const SizedBox(height: AppDimensions.spacingMd),
          
          // About Me (Optional)
          Row(
            children: [
              Text(
                'About Me',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: AppDimensions.spacingXs),
              Text(
                'Optional',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.lightTextTertiary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spacingSm),
          TextFormField(
            controller: _aboutController,
            maxLines: 4,
            decoration: const InputDecoration(
              hintText: 'Tell us a bit about your love for cats...',
              alignLabelWithHint: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyNote(bool isDark) {
    return Row(
      children: [
        Icon(
          Icons.lock_outline,
          size: 16,
          color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
        ),
        const SizedBox(width: AppDimensions.spacingXs),
        Expanded(
          child: Text(
            'Your personal details are kept private and secure.',
            style: AppTextStyles.bodySmall.copyWith(
              color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContinueButton() {
    return ElevatedButton(
      onPressed: _handleContinue,
      child: const Text('Continue'),
    );
  }
}
