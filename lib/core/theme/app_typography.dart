import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  AppTypography._();

  static TextTheme get textTheme {
    return TextTheme(
      // Display - Epilogue (Editorial Voice)
      displayLarge: GoogleFonts.epilogue(
        fontSize: 56,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.5,
        height: 1.1,
        color: AppColors.tertiaryFixed,
      ),
      displayMedium: GoogleFonts.epilogue(
        fontSize: 45,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        height: 1.15,
        color: AppColors.tertiaryFixed,
      ),
      displaySmall: GoogleFonts.epilogue(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        height: 1.2,
        color: AppColors.tertiaryFixed,
      ),

      // Headline - Epilogue
      headlineLarge: GoogleFonts.epilogue(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.25,
        color: AppColors.tertiaryFixed,
      ),
      headlineMedium: GoogleFonts.epilogue(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        height: 1.3,
        color: AppColors.tertiaryFixed,
      ),
      headlineSmall: GoogleFonts.epilogue(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        height: 1.35,
        color: AppColors.tertiaryFixed,
      ),

      // Title - Inter (Functional Voice)
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.3,
        color: AppColors.onSurface,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.15,
        height: 1.4,
        color: AppColors.onSurface,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.4,
        color: AppColors.onSurface,
      ),

      // Body - Inter
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        height: 1.6,
        color: AppColors.onSurfaceVariant,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.5,
        color: AppColors.onSurfaceVariant,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.5,
        color: AppColors.onSurfaceVariant,
      ),

      // Label - Inter
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.4,
        color: AppColors.onSurface,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.3,
        color: AppColors.onSurfaceVariant,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.3,
        color: AppColors.onSurfaceVariant,
      ),
    );
  }
}
