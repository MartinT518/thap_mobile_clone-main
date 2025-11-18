import 'package:flutter/material.dart';
import 'package:thap/ui/common/colors.dart';

/// App theme configuration based on Design System v2.0
class AppTheme {
  AppTheme._();

  // Primary Colors (Design System)
  static const Color primaryBlue500 = Color(0xFF2196F3);
  static const Color primaryBlue700 = Color(0xFF1976D2);
  static const Color primaryBlue300 = Color(0xFF64B5F6);
  static const Color primaryBlue50 = Color(0xFFE3F2FD);

  // Accent Colors
  static const Color accentGreen500 = Color(0xFF4CAF50);
  static const Color accentGreen700 = Color(0xFF388E3C);

  // Semantic Colors
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color warningOrange = Color(0xFFFF9800);
  static const Color errorRed = Color(0xFFF44336);
  static const Color infoBlue = Color(0xFF2196F3);

  // Neutral Colors
  static const Color gray900 = Color(0xFF212121);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray50 = Color(0xFFFAFAFA);

  // Convenience color aliases
  static const Color primaryColor = primaryBlue500;
  static const Color errorColor = errorRed;
  static const Color surfaceColor = gray100;
  static const Color textSecondaryColor = gray700;

  // Spacing (8px base)
  static const double spacingXXS = 4.0;
  static const double spacingXS = 8.0;
  static const double spacingS = 12.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  static const double spacingXXL = 48.0;
  static const double spacingXXXL = 64.0;

  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 28.0;
  static const double radiusPill = 9999.0;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Manrope',
      
      // Color Scheme
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue500,
        brightness: Brightness.light,
      ).copyWith(
        primary: primaryBlue500,
        secondary: accentGreen500,
        error: errorRed,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
        onSurface: gray900,
      ),

      // Scaffold
      scaffoldBackgroundColor: gray50,
      canvasColor: Colors.white,

      // App Bar
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: gray900,
        titleTextStyle: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: gray900,
        ),
        iconTheme: IconThemeData(color: gray700),
      ),

      // Card Theme
      cardTheme: CardTheme(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusL),
        ),
        color: Colors.white,
        margin: const EdgeInsets.all(spacingM),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue500,
          foregroundColor: Colors.white,
          elevation: 2,
          minimumSize: const Size(double.infinity, 48),
          padding: const EdgeInsets.symmetric(horizontal: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusPill),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue500,
          side: const BorderSide(color: primaryBlue500, width: 2),
          minimumSize: const Size(double.infinity, 48),
          padding: const EdgeInsets.symmetric(horizontal: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusPill),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryBlue500,
          minimumSize: const Size(0, 40),
          padding: const EdgeInsets.symmetric(horizontal: spacingXS),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusS),
          ),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: gray50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusS),
          borderSide: const BorderSide(color: gray300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusS),
          borderSide: const BorderSide(color: gray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusS),
          borderSide: const BorderSide(color: primaryBlue500, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusS),
          borderSide: const BorderSide(color: errorRed),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: spacingM,
          vertical: spacingM,
        ),
      ),

      // Text Theme (Design System v2.0)
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.w400,
          height: 64 / 57,
          color: gray900,
          fontFamily: 'Manrope', // Using Manrope as per existing app
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w400,
          height: 52 / 45,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w400,
          height: 40 / 32,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w400,
          height: 36 / 28,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          height: 32 / 24,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w400,
          height: 28 / 22,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 24 / 16,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 24 / 16,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 20 / 14,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 16 / 12,
          color: gray700,
          fontFamily: 'Manrope',
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 20 / 14,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 16 / 12,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 16 / 11,
          color: gray700,
          fontFamily: 'Manrope',
        ),
      ),

      // Bottom Navigation Bar (Design System: Section 5.4)
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white, // Design System: White
        selectedItemColor: primaryBlue500, // Design System: Primary Blue 500
        unselectedItemColor: gray700, // Design System: Gray 700
        selectedLabelStyle: TextStyle(
          fontSize: 11, // Design System: Label Small (11px)
          fontWeight: FontWeight.w500,
          fontFamily: 'Manrope',
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 11, // Design System: Label Small (11px)
          fontWeight: FontWeight.w400,
          fontFamily: 'Manrope',
        ),
        type: BottomNavigationBarType.fixed, // Design System: Fixed type
        elevation: 8, // Design System: 8dp
        iconSize: 24, // Design System: 24x24px
      ),

      // Dialog Theme (Design System: Section 5.5)
      dialogTheme: DialogTheme(
        backgroundColor: Colors.white, // Design System: White
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28), // Design System: 28px (not radiusXXL which is 28px)
        ),
        elevation: 24, // Design System: 24dp
        titleTextStyle: const TextStyle(
          fontSize: 24, // Design System: Headline Small (24px)
          fontWeight: FontWeight.w400,
          color: gray900,
          fontFamily: 'Manrope',
        ),
        contentTextStyle: const TextStyle(
          fontSize: 14, // Design System: Body Medium
          fontWeight: FontWeight.w400,
          color: gray900,
          fontFamily: 'Manrope',
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: gray300,
        thickness: 1,
        space: 1,
      ),
    );
  }
}

