// Sugestão de nome: UrlInputCard

import 'package:flutter/material.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

class UrlInputCard extends StatelessWidget {
  final TextEditingController controller;
  final void Function() onShorten;

  const UrlInputCard({
    super.key,
    required this.controller,
    required this.onShorten,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SpacingTokens.paddingLg),
      margin: EdgeInsets.only(bottom: SpacingTokens.marginSm),
      decoration: BoxDecoration(
        color: ColorTokens.surfacePrimary,
        borderRadius: BorderRadiusTokens.borderRadiusLg,
        boxShadow: ElevationTokens.cardShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cole sua URL aqui',
            style: TypographyTokens.labelMedium.copyWith(
              color: ColorTokens.textPrimary,
            ),
          ),
          SizedBox(height: SpacingTokens.inputLabelGap),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'https://exemplo.com/sua-url-muito-longa',
              hintStyle: TypographyTokens.bodyMedium.copyWith(
                color: ColorTokens.textTertiary,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadiusTokens.borderRadiusMd,
                borderSide: BorderSide(color: ColorTokens.borderPrimary),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadiusTokens.borderRadiusMd,
                borderSide: BorderSide(
                  color: ColorTokens.primaryPurple,
                  width: 2,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadiusTokens.borderRadiusMd,
                borderSide: BorderSide(color: ColorTokens.borderPrimary),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: SpacingTokens.inputPaddingHorizontal,
                vertical: SpacingTokens.inputPaddingVertical,
              ),
            ),
            style: TypographyTokens.bodyMedium.copyWith(
              color: ColorTokens.textPrimary,
            ),
            keyboardType: TextInputType.url,
          ),
          SizedBox(height: SpacingTokens.gapSm),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: onShorten,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorTokens.primaryPurple,
                foregroundColor: ColorTokens.textInverse,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusTokens.borderRadiusMd,
                ),
                shadowColor: ColorTokens.shadowPrimary,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.content_cut, size: 20),
                  SizedBox(width: SpacingTokens.buttonIconGap),
                  Text(
                    'Encurtar URL',
                    style: TypographyTokens.button.copyWith(
                      color: ColorTokens.textInverse,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
