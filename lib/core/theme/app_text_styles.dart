import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Typography system for PurrMatch
/// Uses Inter-like font family with proper fallbacks
class AppTextStyles {
  AppTextStyles._(); // Private constructor

  // Font family - using system defaults that match Inter
  static const String _fontFamily = 'Inter';

  // ========== Display Styles ==========
  static const TextStyle displayLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700, // Bold
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700, // Bold
    height: 1.2,
  );

  // ========== Title Styles ==========
  static const TextStyle titleLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600, // SemiBold
    height: 1.3,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600, // SemiBold
    height: 1.3,
  );

  // ========== Body Styles ==========
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400, // Regular
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400, // Regular
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400, // Regular
    height: 1.4,
  );

  // ========== Label/Chip Styles ==========
  static const TextStyle label = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500, // Medium
    height: 1.4,
  );

  // ========== Button Style ==========
  static const TextStyle button = TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600, // SemiBold
    height: 1.2,
  );

  // ========== Helper Methods for Colored Text ==========
  
  /// Apply light theme primary text color
  static TextStyle withLightPrimaryColor(TextStyle style) {
    return style.copyWith(color: AppColors.lightTextPrimary);
  }

  /// Apply light theme secondary text color
  static TextStyle withLightSecondaryColor(TextStyle style) {
    return style.copyWith(color: AppColors.lightTextSecondary);
  }

  /// Apply dark theme primary text color
  static TextStyle withDarkPrimaryColor(TextStyle style) {
    return style.copyWith(color: AppColors.darkTextPrimary);
  }

  /// Apply dark theme secondary text color
  static TextStyle withDarkSecondaryColor(TextStyle style) {
    return style.copyWith(color: AppColors.darkTextSecondary);
  }
}
