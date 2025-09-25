import 'package:flutter/material.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

class AliasTile extends StatelessWidget {
  final AliasModel alias;
  final VoidCallback? onOpen;

  const AliasTile({super.key, required this.alias, this.onOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SpacingTokens.paddingSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(SpacingTokens.paddingXs),
                decoration: BoxDecoration(
                  color: ColorTokens.hoverPurpleLight,
                  borderRadius: BorderRadiusTokens.borderRadiusSm,
                ),
                child: Icon(
                  Icons.link,
                  size: 20,
                  color: ColorTokens.primaryPurple,
                ),
              ),
              SizedBox(width: SpacingTokens.gapSm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'URL Encurtada',
                      style: TypographyTokens.overline.copyWith(
                        color: ColorTokens.textSecondary,
                      ),
                    ),
                    SizedBox(height: SpacingTokens.space2),
                    Text(
                      alias.short,
                      style: TypographyTokens.bodyMedium.copyWith(
                        color: ColorTokens.primaryPurple,
                        fontWeight: TypographyTokens.fontWeightSemiBold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: ColorTokens.primaryPurple,
                  borderRadius: BorderRadiusTokens.borderRadiusSm,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.open_in_browser,
                    color: ColorTokens.textInverse,
                  ),
                  onPressed: onOpen,
                  tooltip: 'Abrir URL original',
                ),
              ),
            ],
          ),
          SizedBox(height: SpacingTokens.gapSm),
          Container(
            padding: EdgeInsets.all(SpacingTokens.paddingSm),
            decoration: BoxDecoration(
              color: ColorTokens.surfaceSecondary,
              borderRadius: BorderRadiusTokens.borderRadiusSm,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.language,
                  size: 16,
                  color: ColorTokens.textSecondary,
                ),
                SizedBox(width: SpacingTokens.gapXs),
                Expanded(
                  child: Text(
                    alias.original,
                    style: TypographyTokens.bodySmall.copyWith(
                      color: ColorTokens.textSecondary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
