import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

class UrlLauncherHelper {
  static Future<void> openUrl(BuildContext context, String url) async {
    try {
      String finalUrl = url;
      if (!url.startsWith('http://') && !url.startsWith('https://')) {
        finalUrl = 'https://$url';
      }

      final uri = Uri.parse(finalUrl);

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      } else {
        throw Exception('Não foi possível abrir a URL: $finalUrl');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ao abrir URL: $e',
              style: TypographyTokens.bodySmall.copyWith(
                color: ColorTokens.textInverse,
              ),
            ),
            backgroundColor: ColorTokens.errorRed,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusTokens.borderRadiusSm,
            ),
          ),
        );
      }
    }
  }
}
