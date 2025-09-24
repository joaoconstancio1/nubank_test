import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_title.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/core/utils/url_launcher_helper.dart';
import 'package:nubank_test/core/utils/loading_overlay.dart';

class AliasLoadedWidget extends StatelessWidget {
  final List<AliasModel> aliases;
  final Function(BuildContext, AliasModel)? onOpenUrl;

  const AliasLoadedWidget({super.key, required this.aliases, this.onOpenUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12, top: 16),
          child: Text(
            'URLs Encurtadas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
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
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
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
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text('Erro ao abrir URL: $error')),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
