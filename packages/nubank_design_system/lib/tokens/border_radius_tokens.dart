import 'package:flutter/material.dart';

/// Design tokens para border radius e elevações do sistema
class BorderRadiusTokens {
  // Border radius - seguindo escala suave
  static const double radiusNone = 0.0;
  static const double radiusXs = 2.0;
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radiusXxl = 24.0;
  static const double radiusFull =
      1000.0; // Para elementos totalmente arredondados

  // Border radius semânticos
  static const double buttonRadius = radiusMd;
  static const double cardRadius = radiusLg;
  static const double inputRadius = radiusMd;
  static const double modalRadius = radiusXl;
  static const double chipRadius = radiusFull;
  static const double avatarRadius = radiusFull;
  static const double badgeRadius = radiusFull;

  // BorderRadius objects para uso direto
  static const BorderRadius borderRadiusNone = BorderRadius.all(
    Radius.circular(radiusNone),
  );
  static const BorderRadius borderRadiusXs = BorderRadius.all(
    Radius.circular(radiusXs),
  );
  static const BorderRadius borderRadiusSm = BorderRadius.all(
    Radius.circular(radiusSm),
  );
  static const BorderRadius borderRadiusMd = BorderRadius.all(
    Radius.circular(radiusMd),
  );
  static const BorderRadius borderRadiusLg = BorderRadius.all(
    Radius.circular(radiusLg),
  );
  static const BorderRadius borderRadiusXl = BorderRadius.all(
    Radius.circular(radiusXl),
  );
  static const BorderRadius borderRadiusXxl = BorderRadius.all(
    Radius.circular(radiusXxl),
  );
  static const BorderRadius borderRadiusFull = BorderRadius.all(
    Radius.circular(radiusFull),
  );

  // Border radius específicos para diferentes posições
  static const BorderRadius borderRadiusTopOnly = BorderRadius.only(
    topLeft: Radius.circular(radiusLg),
    topRight: Radius.circular(radiusLg),
  );

  static const BorderRadius borderRadiusBottomOnly = BorderRadius.only(
    bottomLeft: Radius.circular(radiusLg),
    bottomRight: Radius.circular(radiusLg),
  );

  static const BorderRadius borderRadiusLeftOnly = BorderRadius.only(
    topLeft: Radius.circular(radiusLg),
    bottomLeft: Radius.circular(radiusLg),
  );

  static const BorderRadius borderRadiusRightOnly = BorderRadius.only(
    topRight: Radius.circular(radiusLg),
    bottomRight: Radius.circular(radiusLg),
  );
}

/// Design tokens para elevações e sombras do sistema
class ElevationTokens {
  // Níveis de elevação
  static const double elevation0 = 0.0;
  static const double elevation1 = 1.0;
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation6 = 6.0;
  static const double elevation8 = 8.0;
  static const double elevation12 = 12.0;
  static const double elevation16 = 16.0;
  static const double elevation24 = 24.0;

  // Sombras personalizadas
  static const BoxShadow shadowXs = BoxShadow(
    color: Color(0x0D000000),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  );

  static const BoxShadow shadowSm = BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 2),
    blurRadius: 4,
    spreadRadius: 0,
  );

  static const BoxShadow shadowMd = BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 4),
    blurRadius: 8,
    spreadRadius: 0,
  );

  static const BoxShadow shadowLg = BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 8),
    blurRadius: 16,
    spreadRadius: 0,
  );

  static const BoxShadow shadowXl = BoxShadow(
    color: Color(0x1A000000),
    offset: Offset(0, 12),
    blurRadius: 24,
    spreadRadius: 0,
  );

  static const BoxShadow shadowXxl = BoxShadow(
    color: Color(0x26000000),
    offset: Offset(0, 16),
    blurRadius: 32,
    spreadRadius: 0,
  );

  // Sombras coloridas do Nubank
  static const BoxShadow shadowPrimary = BoxShadow(
    color: Color(0x1A8A2BE2), // primaryPurple com alpha
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );

  static const BoxShadow shadowSuccess = BoxShadow(
    color: Color(0x1A28A745), // successGreen com alpha
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );

  static const BoxShadow shadowError = BoxShadow(
    color: Color(0x1ADC3545), // errorRed com alpha
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );

  static const BoxShadow shadowWarning = BoxShadow(
    color: Color(0x1AFFC107), // warningYellow com alpha
    offset: Offset(0, 4),
    blurRadius: 12,
    spreadRadius: 0,
  );

  // Listas de sombras para uso em decorations
  static const List<BoxShadow> shadowsXs = [shadowXs];
  static const List<BoxShadow> shadowsSm = [shadowSm];
  static const List<BoxShadow> shadowsMd = [shadowMd];
  static const List<BoxShadow> shadowsLg = [shadowLg];
  static const List<BoxShadow> shadowsXl = [shadowXl];
  static const List<BoxShadow> shadowsXxl = [shadowXxl];

  // Sombras específicas para componentes
  static const List<BoxShadow> cardShadow = shadowsMd;
  static const List<BoxShadow> buttonShadow = shadowsSm;
  static const List<BoxShadow> modalShadow = shadowsXl;
  static const List<BoxShadow> fabShadow = shadowsLg;
  static const List<BoxShadow> appBarShadow = shadowsSm;

  // Sombra interna (inner shadow effect)
  static const BoxShadow innerShadow = BoxShadow(
    color: Color(0x0D000000),
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  );

  // Glow effects
  static const BoxShadow glowPrimary = BoxShadow(
    color: Color(0x338A2BE2),
    offset: Offset(0, 0),
    blurRadius: 8,
    spreadRadius: 0,
  );

  static const BoxShadow glowSuccess = BoxShadow(
    color: Color(0x3328A745),
    offset: Offset(0, 0),
    blurRadius: 8,
    spreadRadius: 0,
  );

  static const BoxShadow glowError = BoxShadow(
    color: Color(0x33DC3545),
    offset: Offset(0, 0),
    blurRadius: 8,
    spreadRadius: 0,
  );
}
