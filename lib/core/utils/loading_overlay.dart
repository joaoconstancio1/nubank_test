import 'package:flutter/material.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context, {String message = 'Carregando...'}) {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: ColorTokens.neutral900.withValues(alpha: 0.7),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ColorTokens.primaryPurple,
                  ),
                  strokeWidth: 3,
                ),
                SizedBox(height: SpacingTokens.gapMd),
                Text(
                  message,
                  style: TypographyTokens.bodyMedium.copyWith(
                    color: ColorTokens.textInverse,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static bool get isShowing => _overlayEntry != null;
}
