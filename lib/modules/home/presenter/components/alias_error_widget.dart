import 'package:flutter/material.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

class AliasErrorWidget extends StatelessWidget {
  const AliasErrorWidget({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SpacingTokens.paddingLg),
      margin: EdgeInsets.only(top: SpacingTokens.marginSm),
      decoration: BoxDecoration(
        color: ColorTokens.surfacePrimary,
        borderRadius: BorderRadiusTokens.borderRadiusLg,
        border: Border.all(color: ColorTokens.errorRedLight),
        boxShadow: ElevationTokens.cardShadow,
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: ColorTokens.errorRed, size: 48),
          SizedBox(height: SpacingTokens.gapSm),
          Text(
            'Ops! Algo deu errado',
            style: TypographyTokens.headline6.copyWith(
              color: ColorTokens.errorRed,
            ),
          ),
          SizedBox(height: SpacingTokens.gapXs),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TypographyTokens.bodySmall.copyWith(
              color: ColorTokens.errorRed,
            ),
          ),
          SizedBox(height: SpacingTokens.gapSm),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorTokens.errorRed,
              foregroundColor: ColorTokens.textInverse,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusTokens.borderRadiusMd,
              ),
            ),
            child: Text(
              'Tentar novamente',
              style: TypographyTokens.button.copyWith(
                color: ColorTokens.textInverse,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
