import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';
import 'app_dimensions.dart';

/// Complete theme configuration for PurrMatch
/// Provides both light and dark themes
class AppTheme {
  AppTheme._(); // Private constructor

  // ========== Light Theme ==========
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      
      // Color scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.lightBgSurface,
        error: AppColors.danger,
        onPrimary: AppColors.lightTextInverse,
        onSecondary: AppColors.lightTextInverse,
        onSurface: AppColors.lightTextPrimary,
        onError: AppColors.lightTextInverse,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.lightBgPrimary,

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightBgPrimary,
        foregroundColor: AppColors.lightTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.withLightPrimaryColor(
          AppTextStyles.titleMedium,
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        // Display
        displayLarge: AppTextStyles.withLightPrimaryColor(
          AppTextStyles.displayLarge,
        ),
        displayMedium: AppTextStyles.withLightPrimaryColor(
          AppTextStyles.displayMedium,
        ),
        
        // Title
        titleLarge: AppTextStyles.withLightPrimaryColor(
          AppTextStyles.titleLarge,
        ),
        titleMedium: AppTextStyles.withLightPrimaryColor(
          AppTextStyles.titleMedium,
        ),
        
        // Body
        bodyLarge: AppTextStyles.withLightPrimaryColor(
          AppTextStyles.bodyLarge,
        ),
        bodyMedium: AppTextStyles.withLightSecondaryColor(
          AppTextStyles.bodyMedium,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          color: AppColors.lightTextTertiary,
        ),
        
        // Label
        labelMedium: AppTextStyles.label,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.lightBgCard,
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.06),
      ),

      // Elevated button - fully rounded
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightButtonPrimaryBg,
          foregroundColor: AppColors.lightButtonPrimaryText,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXl,
            vertical: AppDimensions.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          ),
          minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
          elevation: 0,
        ),
      ),

      // Outlined button - fully rounded
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.lightButtonSecondaryBg,
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXl,
            vertical: AppDimensions.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          ),
          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightBgCard,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: AppColors.lightBorderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: AppColors.lightBorderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.lightTextTertiary,
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.lightChipBg,
        labelStyle: AppTextStyles.label.copyWith(
          color: AppColors.lightChipText,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingSm,
          vertical: AppDimensions.spacingXs,
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.lightBgCard,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.lightTextTertiary,
        selectedLabelStyle: AppTextStyles.label,
        unselectedLabelStyle: AppTextStyles.label,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.lightDividerDefault,
        thickness: 1,
      ),
    );
  }

  // ========== Dark Theme ==========
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      
      // Color scheme
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.darkBgSurface,
        error: AppColors.danger,
        onPrimary: AppColors.darkTextInverse,
        onSecondary: AppColors.darkTextInverse,
        onSurface: AppColors.darkTextPrimary,
        onError: AppColors.lightTextInverse,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.darkBgPrimary,

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBgPrimary,
        foregroundColor: AppColors.darkTextPrimary,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.withDarkPrimaryColor(
          AppTextStyles.titleMedium,
        ),
      ),

      // Text theme
      textTheme: TextTheme(
        // Display
        displayLarge: AppTextStyles.withDarkPrimaryColor(
          AppTextStyles.displayLarge,
        ),
        displayMedium: AppTextStyles.withDarkPrimaryColor(
          AppTextStyles.displayMedium,
        ),
        
        // Title
        titleLarge: AppTextStyles.withDarkPrimaryColor(
          AppTextStyles.titleLarge,
        ),
        titleMedium: AppTextStyles.withDarkPrimaryColor(
          AppTextStyles.titleMedium,
        ),
        
        // Body
        bodyLarge: AppTextStyles.withDarkPrimaryColor(
          AppTextStyles.bodyLarge,
        ),
        bodyMedium: AppTextStyles.withDarkSecondaryColor(
          AppTextStyles.bodyMedium,
        ),
        bodySmall: AppTextStyles.bodySmall.copyWith(
          color: AppColors.darkTextTertiary,
        ),
        
        // Label
        labelMedium: AppTextStyles.label,
      ),

      // Card theme
      cardTheme: CardTheme(
        color: AppColors.darkBgCard,
        elevation: AppDimensions.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.4),
      ),

      // Elevated button - fully rounded
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkButtonPrimaryBg,
          foregroundColor: AppColors.darkButtonPrimaryText,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXl,
            vertical: AppDimensions.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          ),
          minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
          elevation: 0,
        ),
      ),

      // Outlined button - fully rounded
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.darkButtonSecondaryBg,
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.button,
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spacingXl,
            vertical: AppDimensions.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          ),
          side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
        ),
      ),

      // Input decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkBgCard,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingMd,
          vertical: AppDimensions.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: AppColors.darkBorderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: AppColors.darkBorderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: AppColors.danger),
        ),
        hintStyle: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.darkTextTertiary,
        ),
      ),

      // Chip theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkChipBg,
        labelStyle: AppTextStyles.label.copyWith(
          color: AppColors.darkChipText,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusSmall),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingSm,
          vertical: AppDimensions.spacingXs,
        ),
      ),

      // Bottom navigation bar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkBgCard,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.darkTextTertiary,
        selectedLabelStyle: AppTextStyles.label,
        unselectedLabelStyle: AppTextStyles.label,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.darkDividerDefault,
        thickness: 1,
      ),
    );
  }
}
