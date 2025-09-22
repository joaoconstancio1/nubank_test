import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_default_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_empty_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_error_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_loading_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_loaded_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/intro_card.dart';
import 'package:nubank_test/modules/home/presenter/components/url_input_card.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';

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

                  return AliasLoadedWidget(aliases: state.aliases);
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
