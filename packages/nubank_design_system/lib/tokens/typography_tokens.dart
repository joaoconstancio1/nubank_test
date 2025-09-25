import 'package:flutter/material.dart';

/// Design tokens para tipografia do sistema
class TypographyTokens {
  // Família de fontes
  static const String primaryFontFamily = 'Inter';
  static const String secondaryFontFamily = 'Roboto';
  static const String monospaceFontFamily = 'Roboto Mono';

  // Tamanhos de fonte (seguindo escala harmônica)
  static const double fontSize10 = 10.0;
  static const double fontSize12 = 12.0;
  static const double fontSize14 = 14.0;
  static const double fontSize16 = 16.0; // Base
  static const double fontSize18 = 18.0;
  static const double fontSize20 = 20.0;
  static const double fontSize24 = 24.0;
  static const double fontSize28 = 28.0;
  static const double fontSize32 = 32.0;
  static const double fontSize40 = 40.0;
  static const double fontSize48 = 48.0;
  static const double fontSize64 = 64.0;

  // Pesos de fonte
  static const FontWeight fontWeightLight = FontWeight.w300;
  static const FontWeight fontWeightRegular = FontWeight.w400;
  static const FontWeight fontWeightMedium = FontWeight.w500;
  static const FontWeight fontWeightSemiBold = FontWeight.w600;
  static const FontWeight fontWeightBold = FontWeight.w700;
  static const FontWeight fontWeightExtraBold = FontWeight.w800;

  // Altura de linha (line height)
  static const double lineHeight1_2 = 1.2;
  static const double lineHeight1_4 = 1.4;
  static const double lineHeight1_5 = 1.5;
  static const double lineHeight1_6 = 1.6;

  // Espaçamento entre letras
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingExtraWide = 1.0;

  // Estilos pré-definidos - Headlines
  static const TextStyle headline1 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize64,
    fontWeight: fontWeightBold,
    height: lineHeight1_2,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle headline2 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize48,
    fontWeight: fontWeightBold,
    height: lineHeight1_2,
    letterSpacing: letterSpacingTight,
  );

  static const TextStyle headline3 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize40,
    fontWeight: fontWeightSemiBold,
    height: lineHeight1_2,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle headline4 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize32,
    fontWeight: fontWeightSemiBold,
    height: lineHeight1_4,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle headline5 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize28,
    fontWeight: fontWeightMedium,
    height: lineHeight1_4,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle headline6 = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize24,
    fontWeight: fontWeightMedium,
    height: lineHeight1_4,
    letterSpacing: letterSpacingNormal,
  );

  // Estilos pré-definidos - Body
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize20,
    fontWeight: fontWeightRegular,
    height: lineHeight1_6,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize16,
    fontWeight: fontWeightRegular,
    height: lineHeight1_5,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    height: lineHeight1_5,
    letterSpacing: letterSpacingNormal,
  );

  // Estilos pré-definidos - Labels
  static const TextStyle labelLarge = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize18,
    fontWeight: fontWeightMedium,
    height: lineHeight1_4,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize16,
    fontWeight: fontWeightMedium,
    height: lineHeight1_4,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize14,
    fontWeight: fontWeightMedium,
    height: lineHeight1_4,
    letterSpacing: letterSpacingWide,
  );

  // Estilos pré-definidos - Caption e Overline
  static const TextStyle caption = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize12,
    fontWeight: fontWeightRegular,
    height: lineHeight1_4,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle overline = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize10,
    fontWeight: fontWeightMedium,
    height: lineHeight1_2,
    letterSpacing: letterSpacingExtraWide,
  );

  // Estilos especiais
  static const TextStyle button = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize16,
    fontWeight: fontWeightSemiBold,
    height: lineHeight1_4,
    letterSpacing: letterSpacingWide,
  );

  static const TextStyle monospace = TextStyle(
    fontFamily: monospaceFontFamily,
    fontSize: fontSize14,
    fontWeight: fontWeightRegular,
    height: lineHeight1_5,
    letterSpacing: letterSpacingNormal,
  );

  static const TextStyle link = TextStyle(
    fontFamily: primaryFontFamily,
    fontSize: fontSize16,
    fontWeight: fontWeightMedium,
    height: lineHeight1_5,
    letterSpacing: letterSpacingNormal,
    decoration: TextDecoration.underline,
  );
}
