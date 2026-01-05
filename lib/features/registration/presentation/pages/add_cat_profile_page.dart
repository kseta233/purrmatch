import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../core/theme/app_text_styles.dart';

class AddCatProfilePage extends StatefulWidget {
  const AddCatProfilePage({super.key});

  @override
  State<AddCatProfilePage> createState() => _AddCatProfilePageState();
}

class _AddCatProfilePageState extends State<AddCatProfilePage> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _nameController = TextEditingController();
  final _instagramController = TextEditingController();
  final _aboutController = TextEditingController();
  
  // Form state
  final List<String> _photos = [];
  String? _selectedBreed;
  DateTime? _birthDate;
  String? _selectedGender;
  bool _isSterilized = false;
  String? _vaccinationStatus; // 'Full', 'Partial', 'Not yet'
  String? _selectedProvince;
  String? _selectedCity;
  final List<String> _selectedTags = [];

  // Mock data
  final List<String> _breeds = [
    'Persian',
    'British Shorthair',
    'Scottish Fold',
    'Maine Coon',
    'Siamese',
    'Ragdoll',
    'Bengal',
    'Sphynx',
  ];

  final List<String> _provinces = [
    'DKI Jakarta',
    'Jawa Barat',
    'Jawa Tengah',
    'Jawa Timur',
    'Bali',
  ];

  final Map<String, List<String>> _cities = {
    'DKI Jakarta': ['Jakarta Selatan', 'Jakarta Pusat', 'Jakarta Utara', 'Jakarta Barat', 'Jakarta Timur'],
    'Jawa Barat': ['Bandung', 'Bekasi', 'Bogor', 'Depok'],
    'Jawa Tengah': ['Semarang', 'Solo', 'Yogyakarta'],
    'Jawa Timur': ['Surabaya', 'Malang', 'Sidoarjo'],
    'Bali': ['Denpasar', 'Ubud', 'Seminyak'],
  };

  final List<String> _personalityTags = [
    'Playful',
    'Chill',
    'Vocal',
    'Cuddly',
    'Independent',
    'Active',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _instagramController.dispose();
    _aboutController.dispose();
    super.dispose();
  }

  Future<void> _pickPhotos() async {
    if (_photos.length >= 5) {
      Get.snackbar(
        'Maximum Photos',
        'You can only add up to 5 photos',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() {
        _photos.add(image.path);
      });
    }
  }

  void _removePhoto(int index) {
    setState(() {
      _photos.removeAt(index);
    });
  }

  Future<void> _selectBirthDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365)),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _birthDate = picked;
      });
    }
  }

  void _toggleTag(String tag) {
    setState(() {
      if (_selectedTags.contains(tag)) {
        _selectedTags.remove(tag);
      } else {
        if (_selectedTags.length < 5) {
          _selectedTags.add(tag);
        } else {
          Get.snackbar(
            'Maximum Tags',
            'You can only select up to 5 personality tags',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      }
    });
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      if (_photos.isEmpty) {
        Get.snackbar(
          'Photo Required',
          'Please add at least one photo of your cat',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      // TODO: Save cat profile to backend
      print('Cat Profile Saved: ${_nameController.text}');
      
      Get.snackbar(
        'Success!',
        'Cat profile created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.success,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to feed
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offAllNamed('/feed');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBgPrimary : AppColors.lightBgPrimary,
      appBar: AppBar(
        title: const Text('Add Cat Profile'),
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
              100, // Extra padding for bottom button
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Photos Section
                  _buildPhotosSection(isDark),
                  
                  const SizedBox(height: AppDimensions.spacingXl),
                  
                  // Identity Section
                  _buildIdentitySection(isDark),
                  
                  const SizedBox(height: AppDimensions.spacingXl),
                  
                  // Health Status Section
                  _buildHealthSection(isDark),
                  
                  const SizedBox(height: AppDimensions.spacingXl),
                  
                  // Location Section
                  _buildLocationSection(isDark),
                  
                  const SizedBox(height: AppDimensions.spacingXl),
                  
                  // Personality Section
                  _buildPersonalitySection(isDark),
                ],
              ),
            ),
          ),
          
          // Fixed bottom button
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
                child: ElevatedButton.icon(
                  onPressed: _handleSave,
                  icon: const Icon(Icons.pets),
                  label: const Text('Save Profile'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotosSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Photos', style: AppTextStyles.titleMedium),
            Text(
              '${_photos.length}/5',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextTertiary),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingMd),
        
        // Photo grid - 2x3 layout with main photo larger
        Column(
          children: [
            // Top row - Main photo (large) + 2 small
            Row(
              children: [
                // Main photo (larger)
                Expanded(
                  flex: 2,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _buildPhotoSlot(0, isDark, isMain: true),
                  ),
                ),
                const SizedBox(width: AppDimensions.spacingSm),
                // Right column - 2 stacked
                Expanded(
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: _buildPhotoSlot(1, isDark),
                      ),
                      const SizedBox(height: AppDimensions.spacingSm),
                      AspectRatio(
                        aspectRatio: 1,
                        child: _buildPhotoSlot(2, isDark),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.spacingSm),
            // Bottom row - 3 small photos
            Row(
              children: [
                Expanded(child: AspectRatio(aspectRatio: 1, child: _buildPhotoSlot(3, isDark))),
                const SizedBox(width: AppDimensions.spacingSm),
                Expanded(child: AspectRatio(aspectRatio: 1, child: _buildPhotoSlot(4, isDark))),
                const SizedBox(width: AppDimensions.spacingSm),
                const Expanded(child: SizedBox()), // Empty space for balance
              ],
            ),
          ],
        ),
        
        const SizedBox(height: AppDimensions.spacingSm),
        Text(
          'Add up to 5 photos. First one is the cover.',
          style: AppTextStyles.bodySmall.copyWith(
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoSlot(int index, bool isDark, {bool isMain = false}) {
    final hasPhoto = index < _photos.length;
    
    return GestureDetector(
      onTap: hasPhoto ? null : _pickPhotos,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 2,
            style: hasPhoto ? BorderStyle.none : BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          color: hasPhoto ? null : (isDark ? AppColors.darkBgCard : AppColors.primarySoft.withValues(alpha: 0.3)),
          image: hasPhoto
              ? DecorationImage(
                  image: NetworkImage(_photos[index]),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: hasPhoto
            ? Stack(
                children: [
                  if (isMain)
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
                        ),
                        child: const Text(
                          'Main Photo',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _removePhoto(index),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, color: Colors.white, size: 14),
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isMain ? Icons.camera_alt : Icons.add,
                    color: AppColors.primary,
                    size: isMain ? 32 : 24,
                  ),
                  if (isMain) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Main Photo',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }

  Widget _buildIdentitySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Identity', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppDimensions.spacingMd),
        
        // Cat Name
        Text('Cat\'s Name', style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary)),
        const SizedBox(height: AppDimensions.spacingXs),
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'e.g. Mochi'),
          validator: (value) => value == null || value.isEmpty ? 'Please enter cat\'s name' : null,
        ),
        
        const SizedBox(height: AppDimensions.spacingMd),
        
        // Breed & Birth Date Row
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Breed', style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary)),
                  const SizedBox(height: AppDimensions.spacingXs),
                  DropdownButtonFormField<String>(
                    value: _selectedBreed,
                    decoration: const InputDecoration(
                      hintText: 'Select Breed',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    ),
                    isExpanded: true,
                    items: _breeds.map((breed) => DropdownMenuItem(value: breed, child: Text(breed, overflow: TextOverflow.ellipsis))).toList(),
                    onChanged: (value) => setState(() => _selectedBreed = value),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppDimensions.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Birth Date', style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary)),
                  const SizedBox(height: AppDimensions.spacingXs),
                  InkWell(
                    onTap: _selectBirthDate,
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                        suffixIcon: Icon(Icons.calendar_today, size: 20),
                      ),
                      child: Text(
                        _birthDate != null
                            ? '${_birthDate!.month}/${_birthDate!.day}/${_birthDate!.year}'
                            : 'mm/dd/yyyy',
                        style: TextStyle(
                          color: _birthDate != null 
                              ? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary)
                              : AppColors.lightTextTertiary,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        
        const SizedBox(height: AppDimensions.spacingMd),
        
        // Gender - Full width buttons
        Text('Gender', style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary)),
        const SizedBox(height: AppDimensions.spacingXs),
        Row(
          children: [
            Expanded(child: _buildGenderButton('Male', Icons.male, isDark)),
            const SizedBox(width: AppDimensions.spacingSm),
            Expanded(child: _buildGenderButton('Female', Icons.female, isDark)),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderButton(String gender, IconData icon, bool isDark) {
    final isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () => setState(() => _selectedGender = gender),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : (isDark ? AppColors.darkBgCard : AppColors.lightBgCard),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightBorderDefault,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon, 
              size: 20, 
              color: isSelected ? Colors.white : AppColors.lightTextSecondary,
            ),
            const SizedBox(width: 6),
            Text(
              gender,
              style: TextStyle(
                color: isSelected ? Colors.white : AppColors.lightTextSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Health & Status', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppDimensions.spacingMd),
        
        // Sterilized
        Text('Sterilized?', style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary)),
        const SizedBox(height: AppDimensions.spacingSm),
        Row(
          children: [
            _buildToggleChip('Yes', _isSterilized == true, () => setState(() => _isSterilized = true), isDark),
            const SizedBox(width: AppDimensions.spacingSm),
            _buildToggleChip('No', _isSterilized == false, () => setState(() => _isSterilized = false), isDark, isNo: true),
          ],
        ),
        
        const SizedBox(height: AppDimensions.spacingMd),
        
        // Vaccination Status - 3 options
        Text('Vaccination Status', style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary)),
        const SizedBox(height: AppDimensions.spacingSm),
        Row(
          children: [
            _buildToggleChip('Full', _vaccinationStatus == 'Full', () => setState(() => _vaccinationStatus = 'Full'), isDark),
            const SizedBox(width: AppDimensions.spacingSm),
            _buildToggleChip('Partial', _vaccinationStatus == 'Partial', () => setState(() => _vaccinationStatus = 'Partial'), isDark),
            const SizedBox(width: AppDimensions.spacingSm),
            _buildToggleChip('Not yet', _vaccinationStatus == 'Not yet', () => setState(() => _vaccinationStatus = 'Not yet'), isDark, isNo: true),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleChip(String label, bool isSelected, VoidCallback onTap, bool isDark, {bool isNo = false}) {
    final selectedColor = isNo ? AppColors.primary : (isDark ? AppColors.darkBgCard : AppColors.lightBgCard);
    final selectedBgColor = isNo && isSelected ? AppColors.primary : (isSelected ? (isDark ? AppColors.darkBgCard : AppColors.lightBgCard) : Colors.transparent);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected 
              ? (isNo ? AppColors.primary : (isDark ? AppColors.darkBgCard : AppColors.lightBgCard))
              : Colors.transparent,
          border: Border.all(
            color: isSelected 
                ? (isNo ? AppColors.primary : AppColors.lightBorderDefault)
                : AppColors.lightBorderDefault,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected && isNo 
                ? Colors.white 
                : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildLocationSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Location', style: AppTextStyles.titleMedium),
        const SizedBox(height: AppDimensions.spacingMd),
        
        Text('Province', style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary)),
        const SizedBox(height: AppDimensions.spacingXs),
        DropdownButtonFormField<String>(
          value: _selectedProvince,
          decoration: InputDecoration(
            hintText: 'Select Province',
            suffixIcon: Icon(Icons.location_on_outlined, color: AppColors.primary, size: 20),
          ),
          items: _provinces.map((prov) => DropdownMenuItem(value: prov, child: Text(prov))).toList(),
          onChanged: (value) => setState(() {
            _selectedProvince = value;
            _selectedCity = null;
          }),
        ),
        
        const SizedBox(height: AppDimensions.spacingMd),
        
        Text('District / City', style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary)),
        const SizedBox(height: AppDimensions.spacingXs),
        DropdownButtonFormField<String>(
          value: _selectedCity,
          decoration: InputDecoration(
            hintText: 'Select District',
            suffixIcon: Icon(Icons.business, color: AppColors.primary, size: 20),
          ),
          items: _selectedProvince != null
              ? _cities[_selectedProvince]!.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList()
              : [],
          onChanged: (value) => setState(() => _selectedCity = value),
        ),
      ],
    );
  }

  Widget _buildPersonalitySection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Personality', style: AppTextStyles.titleMedium),
            Text(
              'Select tags (Max 5)',
              style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextTertiary),
            ),
          ],
        ),
        const SizedBox(height: AppDimensions.spacingMd),
        
        Wrap(
          spacing: AppDimensions.spacingSm,
          runSpacing: AppDimensions.spacingSm,
          children: _personalityTags.map((tag) {
            final isSelected = _selectedTags.contains(tag);
            return GestureDetector(
              onTap: () => _toggleTag(tag),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (isDark ? AppColors.darkChipBg : AppColors.primarySoft)
                      : (isDark ? AppColors.darkBgCard : AppColors.lightBgCard),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.lightBorderDefault,
                  ),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      tag,
                      style: TextStyle(
                        color: isSelected
                            ? (isDark ? AppColors.darkChipText : AppColors.primary)
                            : (isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (isSelected) ...[
                      const SizedBox(width: 4),
                      Icon(Icons.close, size: 14, color: AppColors.primary),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        
        const SizedBox(height: AppDimensions.spacingLg),
        
        Text('About', style: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextSecondary)),
        const SizedBox(height: AppDimensions.spacingXs),
        TextFormField(
          controller: _aboutController,
          maxLines: 4,
          maxLength: 300,
          decoration: InputDecoration(
            hintText: 'Tell us more about this cutie! What do they like to eat? Any funny habits?',
            alignLabelWithHint: true,
            counterStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.lightTextTertiary),
          ),
        ),
      ],
    );
  }
}
