import 'package:flutter/painting.dart';

class AppColors {
  AppColors._();

  // Core Palette
  static const Color primary = Color(0xFFA1D1B9);
  static const Color onPrimary = Color(0xFF053827);
  static const Color primaryContainer = Color(0xFF2D5A47);
  static const Color onPrimaryContainer = Color(0xFFA1D1B9);

  // Background & Surface (The Cosmic Forest)
  static const Color background = Color(0xFF091611);
  static const Color surface = Color(0xFF091611);
  static const Color surfaceContainerLowest = Color(0xFF05110C);
  static const Color surfaceContainerLow = Color(0xFF111E19);
  static const Color surfaceContainer = Color(0xFF192722);
  static const Color surfaceContainerHigh = Color(0xFF202D27);
  static const Color surfaceContainerHighest = Color(0xFF2A3832);

  // Tertiary (The Cream)
  static const Color tertiary = Color(0xFFC8C8B0);
  static const Color tertiaryFixed = Color(0xFFE4E4CC);

  // Text Colors
  static const Color onSurface = Color(0xFFE4E4CC);
  static const Color onSurfaceVariant = Color(0xFFC0C8C2);

  // Primary Fixed (Sage)
  static const Color primaryFixed = Color(0xFFC5E8D5);

  // Error
  static const Color error = Color(0xFFFFB4AB);

  // Glassmorphism
  static const Color glassBackground = Color(0x662D5A47); // rgba(45,90,71,0.4)
  static const Color ghostBorder = Color(0x1AF5F5DC); // rgba(245,245,220,0.1)
  static const Color ghostBorderFocused = Color(0x4DF5F5DC); // 30% opacity cream

  // Shadows (Organic, green-tinted)
  static const Color organicShadow = Color(0x66000000); // rgba(0,0,0,0.4)

  // Gradients
  static const LinearGradient signatureGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryContainer, surfaceContainerHighest],
  );

  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [primaryContainer, surface],
  );
}
