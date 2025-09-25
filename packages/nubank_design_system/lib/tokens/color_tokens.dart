import 'package:flutter/material.dart';

/// Design tokens para cores do sistema
class ColorTokens {
  // Cores primárias do Nubank
  static const Color primaryPurple = Color(0xFF8A2BE2);
  static const Color primaryPurpleLight = Color(0xFFB47ED8);
  static const Color primaryPurpleDark = Color(0xFF6B1F99);

  // Cores secundárias
  static const Color secondaryMagenta = Color(0xFFE63946);
  static const Color secondaryBlue = Color(0xFF457B9D);
  static const Color secondaryTeal = Color(0xFF1D3557);

  // Cores neutras
  static const Color neutral900 = Color(0xFF0D1117);
  static const Color neutral800 = Color(0xFF21262D);
  static const Color neutral700 = Color(0xFF30363D);
  static const Color neutral600 = Color(0xFF484F58);
  static const Color neutral500 = Color(0xFF656D76);
  static const Color neutral400 = Color(0xFF8B949E);
  static const Color neutral300 = Color(0xFFB1BAC4);
  static const Color neutral200 = Color(0xFFD0D7DE);
  static const Color neutral100 = Color(0xFFEAEEF2);
  static const Color neutral50 = Color(0xFFF6F8FA);
  static const Color neutral0 = Color(0xFFFFFFFF);

  // Cores de feedback
  static const Color successGreen = Color(0xFF28A745);
  static const Color successGreenLight = Color(0xFF34CE57);
  static const Color successGreenDark = Color(0xFF1E7E34);

  static const Color warningYellow = Color(0xFFFFC107);
  static const Color warningYellowLight = Color(0xFFFFD54F);
  static const Color warningYellowDark = Color(0xFFFF8F00);

  static const Color errorRed = Color(0xFFDC3545);
  static const Color errorRedLight = Color(0xFFFF5722);
  static const Color errorRedDark = Color(0xFFC62828);

  static const Color infoBlue = Color(0xFF17A2B8);
  static const Color infoBlueLight = Color(0xFF29B6F6);
  static const Color infoBlueDark = Color(0xFF0288D1);

  // Cores de superficie
  static const Color surfacePrimary = neutral0;
  static const Color surfaceSecondary = neutral50;
  static const Color surfaceTertiary = neutral100;
  static const Color surfaceQuaternary = neutral200;

  // Cores de texto
  static const Color textPrimary = neutral900;
  static const Color textSecondary = neutral700;
  static const Color textTertiary = neutral500;
  static const Color textQuaternary = neutral400;
  static const Color textInverse = neutral0;

  // Cores de borda
  static const Color borderPrimary = neutral300;
  static const Color borderSecondary = neutral200;
  static const Color borderTertiary = neutral100;

  // Cores de foco e interação
  static const Color focusPurple = primaryPurple;
  static const Color hoverPurpleLight = Color(0xFFF3E5F5);
  static const Color activePurpleDark = primaryPurpleDark;

  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, primaryPurpleLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [neutral800, neutral900],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Sombras coloridas
  static const Color shadowPrimary = Color(0x1A8A2BE2);
  static const Color shadowSecondary = Color(0x0D000000);
  static const Color shadowTertiary = Color(0x05000000);
}
