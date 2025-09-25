<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Nubank Design System

Sistema de design para o aplicativo Nubank Test, contendo tokens de design consistentes e reutilizáveis.

## Tokens Disponíveis

### Cores (ColorTokens)
- **Cores Primárias**: `primaryPurple`, `primaryPurpleLight`, `primaryPurpleDark`
- **Cores Secundárias**: `secondaryMagenta`, `secondaryBlue`, `secondaryTeal`
- **Cores Neutras**: Escala completa de cinzas (`neutral0` a `neutral900`)
- **Cores de Feedback**: `successGreen`, `warningYellow`, `errorRed`, `infoBlue`
- **Cores Semânticas**: Para texto, superfície, bordas e interação

### Espaçamento (SpacingTokens)
- **Escala Base**: De `space0` (0px) até `space128` (128px)
- **Espaçamentos Semânticos**: Para padding, margin, gap
- **Contextos Específicos**: Para botões, cards, inputs, listas, etc.

### Tipografia (TypographyTokens)
- **Famílias de Fonte**: Inter (primária), Roboto (secundária), Roboto Mono
- **Escalas de Tamanho**: De 10px a 64px
- **Pesos**: Light, Regular, Medium, SemiBold, Bold, ExtraBold
- **Estilos Predefinidos**: Headlines, Body, Labels, Caption, etc.

### Border Radius (BorderRadiusTokens)
- **Escalas**: De `radiusNone` a `radiusXxl` e `radiusFull`
- **Contextos Semânticos**: Para botões, cards, inputs, etc.

### Elevação (ElevationTokens)
- **Níveis**: De `elevation0` a `elevation24`
- **Sombras Customizadas**: Com variações de tamanho e cor
- **Efeitos Especiais**: Glow effects e sombras coloridas

### Tema (AppTheme)
- Tema completo do Material Design configurado com os tokens

## Uso

```dart
import 'package:nubank_design_system/nubank_design_system.dart';

// Exemplo de uso
Container(
  padding: EdgeInsets.all(SpacingTokens.paddingMd),
  decoration: BoxDecoration(
    color: ColorTokens.surfacePrimary,
    borderRadius: BorderRadiusTokens.borderRadiusLg,
    boxShadow: ElevationTokens.shadowsMd,
  ),
  child: Text(
    'Texto de exemplo',
    style: TypographyTokens.bodyMedium.copyWith(
      color: ColorTokens.textPrimary,
    ),
  ),
)
```

## Estrutura

```
lib/
  tokens/
    app_theme.dart          # Tema completo do app
    border_radius_tokens.dart # Tokens de border radius e elevação
    color_tokens.dart       # Tokens de cores
    spacing_tokens.dart     # Tokens de espaçamento
    typography_tokens.dart  # Tokens de tipografia
    tokens.dart            # Exportações centralizadas
  nubank_design_system.dart # Ponto de entrada principal
```
