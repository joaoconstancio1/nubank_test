import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_title.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/core/utils/url_launcher_helper.dart';
import 'package:nubank_test/core/utils/loading_overlay.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

class AliasLoadedWidget extends StatelessWidget {
  final List<AliasModel> aliases;
  final Function(BuildContext, AliasModel)? onOpenUrl;

  const AliasLoadedWidget({super.key, required this.aliases, this.onOpenUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: SpacingTokens.space4,
            bottom: SpacingTokens.gapSm,
            top: SpacingTokens.marginSm,
          ),
          child: Text(
            'URLs Encurtadas',
            style: TypographyTokens.headline6.copyWith(
              color: ColorTokens.textPrimary,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: aliases.length,
          itemBuilder: (context, index) {
            final alias = aliases[index];
            return Container(
              margin: EdgeInsets.only(bottom: SpacingTokens.cardMarginExternal),
              decoration: BoxDecoration(
                color: ColorTokens.surfacePrimary,
                borderRadius: BorderRadiusTokens.borderRadiusMd,
                boxShadow: ElevationTokens.cardShadow,
              ),
              child: AliasTile(
                alias: alias,
                onOpen: onOpenUrl != null
                    ? () => onOpenUrl!(context, alias)
                    : () => _handleOpenUrl(context, alias),
              ),
            );
          },
        ),
      ],
    );
  }

  Future<void> _handleOpenUrl(BuildContext context, AliasModel alias) async {
    LoadingOverlay.show(context, message: 'Abrindo URL...');

    final cubit = context.read<AliasCubit>();
    try {
      final originalUrl = await cubit.getOriginalUrl(alias.alias);

      if (context.mounted) {
        await UrlLauncherHelper.openUrl(context, originalUrl);
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorSnackBar(context, e.toString());
      }
    } finally {
      LoadingOverlay.hide();
    }
  }

  void _showErrorSnackBar(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.error_outline, color: ColorTokens.textInverse),
            SizedBox(width: SpacingTokens.gapXs),
            Expanded(
              child: Text(
                'Erro ao abrir URL: $error',
                style: TypographyTokens.bodySmall.copyWith(
                  color: ColorTokens.textInverse,
                ),
              ),
            ),
          ],
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
