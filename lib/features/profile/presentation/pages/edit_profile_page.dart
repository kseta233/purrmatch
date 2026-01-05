import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _nameController = TextEditingController(text: 'Sarah Kusuma');
  final _locationController = TextEditingController(text: 'Jakarta Selatan');
  final _instagramController = TextEditingController(text: '@sarahkusuma');
  final _aboutController = TextEditingController(
    text: 'Cat lover and proud owner of 2 adorable felines. Looking for the perfect breeding partners for my babies! 🐱',
  );
  
  String? _photoUrl = 'https://i.pravatar.cc/150?img=1';

  final List<String> _provinces = [
    'DKI Jakarta',
    'Jawa Barat',
    'Jawa Tengah',
    'Jawa Timur',
    'Bali',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _instagramController.dispose();
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
        _photoUrl = image.path;
      });
    }
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      // TODO: Save profile updates
      Get.snackbar(
        'Success!',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
      );
      
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.spacingLg,
              AppDimensions.spacingLg,
              AppDimensions.spacingLg,
              100, // Extra padding for save button
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Profile photo
                  _buildPhotoSection(isDark),
                  
                  const SizedBox(height: AppDimensions.spacingXl),
                  
                  // Form fields
                  _buildFormSection(isDark),
                  
                  const SizedBox(height: AppDimensions.spacingXl),
                  
                  // About section
                  _buildAboutSection(isDark),
                  
                  const SizedBox(height: AppDimensions.spacingXl),
                  
                  // Delete account link
                  Center(
                    child: TextButton(
                      onPressed: () {
                        _showDeleteConfirmation();
                      },
                      child: Text(
                        'Delete Account',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.danger,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Save button
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.spacingLg),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: ElevatedButton(
                  onPressed: _handleSave,
                  child: const Text('Save Changes'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoSection(bool isDark) {
    return Center(
      child: Column(
        children: [
          // Photo
          GestureDetector(
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
                    ),
                    color: AppColors.primarySoft,
                  ),
                  child: ClipOval(
                    child: _photoUrl != null
                        ? Image.network(
                            _photoUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.person,
                                size: 50,
                                color: AppColors.primary.withValues(alpha: 0.6),
                              );
                            },
                          )
                        : Icon(
                            Icons.person,
                            size: 50,
                            color: AppColors.primary.withValues(alpha: 0.6),
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
                        width: 3,
                      ),
                    ),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: AppDimensions.spacingSm),
          
          TextButton(
            onPressed: _pickPhoto,
            child: Text(
              'Change Photo',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name
        Text(
          'Full Name',
          style: AppTextStyles.bodySmall.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingXs),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            hintText: 'Enter your full name',
          ),
          validator: (value) => value == null || value.isEmpty ? 'Please enter your name' : null,
        ),
        
        const SizedBox(height: AppDimensions.spacingMd),
        
        // Location
        Text(
          'Location',
          style: AppTextStyles.bodySmall.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingXs),
        DropdownButtonFormField<String>(
          value: _provinces.contains(_locationController.text) ? _locationController.text : null,
          decoration: InputDecoration(
            hintText: 'Select your location',
            suffixIcon: Icon(Icons.location_on_outlined, color: AppColors.primary, size: 20),
          ),
          items: _provinces.map((prov) => DropdownMenuItem(value: prov, child: Text(prov))).toList(),
          onChanged: (value) {
            if (value != null) {
              _locationController.text = value;
            }
          },
        ),
        
        const SizedBox(height: AppDimensions.spacingMd),
        
        // Instagram
        Text(
          'Instagram Username',
          style: AppTextStyles.bodySmall.copyWith(
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimensions.spacingXs),
        TextFormField(
          controller: _instagramController,
          decoration: InputDecoration(
            hintText: '@username',
            prefixIcon: Icon(Icons.alternate_email, color: AppColors.primary, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildAboutSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'About Me',
              style: AppTextStyles.bodySmall.copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Optional',
              style: AppTextStyles.label.copyWith(
                color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingXs),
        TextFormField(
          controller: _aboutController,
          maxLines: 4,
          maxLength: 200,
          decoration: InputDecoration(
            hintText: 'Tell other cat parents about yourself...',
            alignLabelWithHint: true,
            counterStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextTertiary),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation() {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Account'),
        content: const Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently deleted.',
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
                'Account Deletion',
                'Please contact support to delete your account',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}
