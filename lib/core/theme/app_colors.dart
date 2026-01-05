import 'dart:ui';

/// Design tokens for PurrMatch app colors
/// Based on the warm, cat-first design system
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // ========== Brand Colors (Shared) ==========
  static const Color primary = Color(0xFFFF8A5B);
  static const Color primarySoft = Color(0xFFFFE2D6);
  static const Color secondary = Color(0xFF5B7FFF);
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFB020);
  static const Color danger = Color(0xFFE5484D);

  // ========== Light Theme ==========
  static const Color lightBgPrimary = Color(0xFFFFF8F4);
  static const Color lightBgSecondary = Color(0xFFFFFFFF);
  static const Color lightBgSurface = Color(0xFFFFFDFB);
  static const Color lightBgCard = Color(0xFFFFFFFF);

  static const Color lightTextPrimary = Color(0xFF1F1F1F);
  static const Color lightTextSecondary = Color(0xFF5F5F5F);
  static const Color lightTextTertiary = Color(0xFF9A9A9A);
  static const Color lightTextInverse = Color(0xFFFFFFFF);

  static const Color lightBorderDefault = Color(0xFFE8E1DC);
  static const Color lightDividerDefault = Color(0xFFF0EAE6);

  // ========== Dark Theme ==========
  static const Color darkBgPrimary = Color(0xFF121212);
 static const Color darkBgSecondary = Color(0xFF1A1A1A);
  static const Color darkBgSurface = Color(0xFF1F1F1F);
  static const Color darkBgCard = Color(0xFF242424);

  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFCFCFCF);
  static const Color darkTextTertiary = Color(0xFF8B8B8B);
  static const Color darkTextInverse = Color(0xFF1F1F1F);

  static const Color darkBorderDefault = Color(0xFF2E2E2E);
  static const Color darkDividerDefault = Color(0xFF2A2A2A);

  // ========== Component States (Light) ==========
  static const Color lightButtonPrimaryBg = primary;
  static const Color lightButtonPrimaryText = Color(0xFFFFFFFF);
  static const Color lightButtonSecondaryBg = Color(0xFFFFEFE7);
  
  static const Color lightChipBg = primarySoft;
  static const Color lightChipText = Color(0xFFFF6A3D);

  // ========== Component States (Dark) ==========
  static const Color darkButtonPrimaryBg = primary;
  static const Color darkButtonPrimaryText = Color(0xFF1A1A1A);
  static const Color darkButtonSecondaryBg = Color(0xFF2A1F1A);
  
  static const Color darkChipBg = Color(0xFF2A1F1A);
  static const Color darkChipText = Color(0xFFFFB299);
}
