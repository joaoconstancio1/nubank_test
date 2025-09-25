import 'package:flutter/material.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

class AliasEmptyWidget extends StatelessWidget {
  const AliasEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SpacingTokens.paddingXl),
      margin: EdgeInsets.only(top: SpacingTokens.marginSm),
      decoration: BoxDecoration(
        color: ColorTokens.surfacePrimary,
        borderRadius: BorderRadiusTokens.borderRadiusLg,
        boxShadow: ElevationTokens.cardShadow,
      ),
      child: Column(
        children: [
          Icon(Icons.link_off, size: 48, color: ColorTokens.textQuaternary),
          SizedBox(height: SpacingTokens.gapSm),
          Text(
            'Nenhuma URL encurtada ainda',
            style: TypographyTokens.bodyLarge.copyWith(
              color: ColorTokens.textSecondary,
            ),
          ),
          SizedBox(height: SpacingTokens.gapXs),
          Text(
            'Cole uma URL acima para começar',
            style: TypographyTokens.bodySmall.copyWith(
              color: ColorTokens.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
