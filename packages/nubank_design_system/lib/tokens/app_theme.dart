import 'package:flutter/material.dart';
import 'tokens.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: ColorTokens.primaryPurple,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorTokens.primaryPurple,
        primary: ColorTokens.primaryPurple,
        secondary: ColorTokens.secondaryMagenta,
        surface: ColorTokens.surfacePrimary,
        error: ColorTokens.errorRed,
        onPrimary: ColorTokens.textInverse,
        onSecondary: ColorTokens.textInverse,
        onSurface: ColorTokens.textPrimary,
        onError: ColorTokens.textInverse,
      ),
      fontFamily: TypographyTokens.primaryFontFamily,
      useMaterial3: true,

      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: ColorTokens.primaryPurple,
        foregroundColor: ColorTokens.textInverse,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TypographyTokens.headline6.copyWith(
          color: ColorTokens.textInverse,
        ),
      ),

      // Card Theme
      cardTheme: const CardThemeData(
        color: ColorTokens.surfacePrimary,
        elevation: ElevationTokens.elevation4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusTokens.borderRadiusLg,
        ),
        shadowColor: ColorTokens.shadowSecondary,
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorTokens.primaryPurple,
          foregroundColor: ColorTokens.textInverse,
          textStyle: TypographyTokens.button,
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingTokens.buttonPaddingHorizontal,
            vertical: SpacingTokens.buttonPaddingVertical,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusTokens.borderRadiusMd,
          ),
          elevation: ElevationTokens.elevation2,
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: false,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: SpacingTokens.inputPaddingHorizontal,
          vertical: SpacingTokens.inputPaddingVertical,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadiusTokens.borderRadiusMd,
          borderSide: BorderSide(color: ColorTokens.borderPrimary),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadiusTokens.borderRadiusMd,
          borderSide: BorderSide(color: ColorTokens.borderPrimary),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadiusTokens.borderRadiusMd,
          borderSide: BorderSide(color: ColorTokens.primaryPurple, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadiusTokens.borderRadiusMd,
          borderSide: BorderSide(color: ColorTokens.errorRed),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadiusTokens.borderRadiusMd,
          borderSide: BorderSide(color: ColorTokens.errorRed, width: 2),
        ),
        hintStyle: TypographyTokens.bodyMedium.copyWith(
          color: ColorTokens.textTertiary,
        ),
        labelStyle: TypographyTokens.labelMedium.copyWith(
          color: ColorTokens.textSecondary,
        ),
        errorStyle: TypographyTokens.caption.copyWith(
          color: ColorTokens.errorRed,
        ),
      ),

      // SnackBar Theme
      snackBarTheme: SnackBarThemeData(
        backgroundColor: ColorTokens.neutral800,
        contentTextStyle: TypographyTokens.bodySmall.copyWith(
          color: ColorTokens.textInverse,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusTokens.borderRadiusSm,
        ),
        behavior: SnackBarBehavior.floating,
      ),

      // Text Theme
      textTheme: TextTheme(
        headlineLarge: TypographyTokens.headline1.copyWith(
          color: ColorTokens.textPrimary,
        ),
        headlineMedium: TypographyTokens.headline2.copyWith(
          color: ColorTokens.textPrimary,
        ),
        headlineSmall: TypographyTokens.headline3.copyWith(
          color: ColorTokens.textPrimary,
        ),
        titleLarge: TypographyTokens.headline4.copyWith(
          color: ColorTokens.textPrimary,
        ),
        titleMedium: TypographyTokens.headline5.copyWith(
          color: ColorTokens.textPrimary,
        ),
        titleSmall: TypographyTokens.headline6.copyWith(
          color: ColorTokens.textPrimary,
        ),
        bodyLarge: TypographyTokens.bodyLarge.copyWith(
          color: ColorTokens.textPrimary,
        ),
        bodyMedium: TypographyTokens.bodyMedium.copyWith(
          color: ColorTokens.textPrimary,
        ),
        bodySmall: TypographyTokens.bodySmall.copyWith(
          color: ColorTokens.textSecondary,
        ),
        labelLarge: TypographyTokens.labelLarge.copyWith(
          color: ColorTokens.textPrimary,
        ),
        labelMedium: TypographyTokens.labelMedium.copyWith(
          color: ColorTokens.textPrimary,
        ),
        labelSmall: TypographyTokens.labelSmall.copyWith(
          color: ColorTokens.textSecondary,
        ),
      ),

      // Icon Theme
      iconTheme:
          const IconThemeData(color: ColorTokens.textSecondary, size: 24),

      // Primary Icon Theme
      primaryIconTheme:
          const IconThemeData(color: ColorTokens.textInverse, size: 24),
    );
  }
}
