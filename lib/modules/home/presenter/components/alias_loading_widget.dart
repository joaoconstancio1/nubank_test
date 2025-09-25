import 'package:flutter/material.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

class AliasLoadingWidget extends StatelessWidget {
  const AliasLoadingWidget({super.key});

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
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              ColorTokens.primaryPurple,
            ),
          ),
          SizedBox(height: SpacingTokens.gapSm),
          Text(
            'Encurtando sua URL...',
            style: TypographyTokens.bodySmall.copyWith(
              color: ColorTokens.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}
