import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_title.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/core/utils/url_launcher_helper.dart';

class AliasLoadedWidget extends StatelessWidget {
  final List<AliasModel> aliases;
  final Function(BuildContext) showLoadingOverlay;
  final VoidCallback removeLoadingOverlay;

  const AliasLoadedWidget({
    super.key,
    required this.aliases,
    required this.showLoadingOverlay,
    required this.removeLoadingOverlay,
  });

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
                onOpen: () async {
                  showLoadingOverlay(context);

                  final cubit = context.read<AliasCubit>();
                  try {
                    final originalUrl = await cubit.getOriginalUrl(alias.alias);

                    if (context.mounted) {
                      await UrlLauncherHelper.openUrl(context, originalUrl);
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text('Erro ao abrir URL: $e')),
                            ],
                          ),
                          backgroundColor: Colors.red,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    }
                  } finally {
                    removeLoadingOverlay();
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
