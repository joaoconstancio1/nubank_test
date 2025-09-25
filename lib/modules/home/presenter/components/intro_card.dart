import 'package:flutter/material.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

class IntroCard extends StatelessWidget {
  const IntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SpacingTokens.paddingLg),
      margin: EdgeInsets.only(bottom: SpacingTokens.marginXl),
      decoration: BoxDecoration(
        color: ColorTokens.surfacePrimary,
        borderRadius: BorderRadiusTokens.borderRadiusLg,
        boxShadow: ElevationTokens.cardShadow,
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(SpacingTokens.paddingSm),
            decoration: BoxDecoration(
              color: ColorTokens.hoverPurpleLight,
              borderRadius: BorderRadiusTokens.borderRadiusMd,
            ),
            child: Icon(Icons.link, size: 32, color: ColorTokens.primaryPurple),
          ),
          SizedBox(height: SpacingTokens.gapSm),
          Text(
            'Transforme seus links longos em URLs curtas e elegantes',
            textAlign: TextAlign.center,
            style: TypographyTokens.bodyMedium.copyWith(
              color: ColorTokens.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
