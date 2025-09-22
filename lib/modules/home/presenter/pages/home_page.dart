import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_default_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_empty_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_error_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_loading_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/intro_card.dart';
import 'package:nubank_test/modules/home/presenter/components/url_input_card.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_title.dart';
import 'package:nubank_test/core/utils/url_launcher_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AliasCubit(GetIt.I()),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? _overlayEntry;

  void _showLoadingOverlay(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: Container(color: Colors.black.withValues(alpha: 0.7)),
          ),
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF8A05BE)),
                  strokeWidth: 3,
                ),
                SizedBox(height: 20),
                Text(
                  'Abrindo URL...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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

  void _removeLoadingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeLoadingOverlay();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'Encurtador de URL',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF8A05BE),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF8A05BE), Color(0xFFF5F5F5)],
            stops: [0.0, 0.3],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            const SizedBox(height: 20),

            IntroCard(),

            UrlInputCard(
              controller: _controller,
              onShorten: () {
                final cubit = context.read<AliasCubit>();
                cubit.shorten(_controller.text);
                _controller.clear();
                FocusScope.of(context).unfocus();
              },
            ),

            BlocBuilder<AliasCubit, AliasState>(
              builder: (context, state) {
                if (state is AliasLoading) {
                  return const AliasLoadingWidget();
                }

                if (state is AliasError) {
                  return AliasErrorWidget(
                    message: state.message,
                    onRetry: () {
                      context.read<AliasCubit>().clearError();
                    },
                  );
                }

                if (state is AliasesLoaded) {
                  if (state.aliases.isEmpty) {
                    return AliasEmptyWidget();
                  }

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
                        itemCount: state.aliases.length,
                        itemBuilder: (context, index) {
                          final alias = state.aliases[index];
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
                                _showLoadingOverlay(context);

                                final cubit = context.read<AliasCubit>();
                                try {
                                  final originalUrl = await cubit
                                      .getOriginalUrl(alias.alias);

                                  if (context.mounted) {
                                    await UrlLauncherHelper.openUrl(
                                      context,
                                      originalUrl,
                                    );
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
                                            Expanded(
                                              child: Text(
                                                'Erro ao abrir URL: $e',
                                              ),
                                            ),
                                          ],
                                        ),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                } finally {
                                  _removeLoadingOverlay();
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }

                return const AliasDefaultWidget();
              },
            ),
          ],
        ),
      ),
    );
  }
}
