import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nubank_test/core/extensions/semantics_extension.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_default_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_empty_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_error_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_loading_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_loaded_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/intro_card.dart';
import 'package:nubank_test/modules/home/presenter/components/url_input_card.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTokens.surfaceSecondary,
      appBar: AppBar(
        title: Text(
          'Encurtador de URL',
          style: TypographyTokens.headline6.copyWith(
            color: ColorTokens.textInverse,
          ),
        ).withSemantics(label: 'Encurtador de URL - Aplicativo principal'),
        backgroundColor: ColorTokens.primaryPurple,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [ColorTokens.primaryPurple, ColorTokens.surfaceSecondary],
            stops: [0.0, 0.3],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(SpacingTokens.pageMargin),
          semanticChildCount: 3,
          children: [
            SizedBox(height: SpacingTokens.marginSm),

            IntroCard().withSemantics(label: 'Seção de introdução'),

            UrlInputCard(
              controller: _controller,
              onShorten: () {
                final cubit = context.read<AliasCubit>();
                cubit.shorten(_controller.text);
                _controller.clear();
                FocusScope.of(context).unfocus();
              },
            ).withSemantics(
              label: 'Seção de entrada de URL',
              hint: 'Digite uma URL para encurtar',
            ),

            BlocBuilder<AliasCubit, AliasState>(
              builder: (context, state) {
                if (state is AliasLoading) {
                  return const AliasLoadingWidget().withSemantics(
                    label: 'Carregando resultado',
                  );
                }

                if (state is AliasError) {
                  return AliasErrorWidget(
                    message: state.message,
                    onRetry: () {
                      context.read<AliasCubit>().clearError();
                    },
                  ).withSemantics(label: 'Erro: ${state.message}');
                }

                if (state is AliasesLoaded) {
                  if (state.aliases.isEmpty) {
                    return AliasEmptyWidget().withSemantics(
                      label: 'Nenhuma URL encurtada ainda',
                    );
                  }

                  return AliasLoadedWidget(
                    aliases: state.aliases,
                  ).withSemantics(
                    label: 'Lista com ${state.aliases.length} URLs encurtadas',
                  );
                }

                return const AliasDefaultWidget().withSemantics(
                  label: 'Estado inicial - pronto para usar',
                );
              },
            ).withSemantics(label: 'Seção de resultados'),
          ],
        ).withSemantics(label: 'Conteúdo principal'),
      ).withSemantics(label: 'Tela principal do encurtador de URLs'),
    );
  }
}
