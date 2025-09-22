import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';
import 'package:nubank_test/modules/home/presenter/pages/alias_title.dart';
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

            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF8A05BE).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.link,
                      size: 32,
                      color: Color(0xFF8A05BE),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Transforme seus links longos em URLs curtas e elegantes',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cole sua URL aqui',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'https://exemplo.com/sua-url-muito-longa',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF8A05BE),
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                    keyboardType: TextInputType.url,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        final cubit = context.read<AliasCubit>();
                        cubit.shorten(_controller.text);
                        _controller.clear();
                        FocusScope.of(context).unfocus();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF8A05BE),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.content_cut, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Encurtar URL',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            BlocBuilder<AliasCubit, AliasState>(
              builder: (context, state) {
                if (state is AliasLoading) {
                  return Container(
                    padding: const EdgeInsets.all(32),
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color(0xFF8A05BE),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Encurtando sua URL...',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }

                if (state is AliasError) {
                  return Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.red[300]!),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red[400],
                          size: 48,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Ops! Algo deu errado',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.red[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          state.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<AliasCubit>().clearError(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is AliasesLoaded) {
                  if (state.aliases.isEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(32),
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.link_off,
                            size: 48,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Nenhuma URL encurtada ainda',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Cole uma URL acima para começar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    );
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
                                }
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }

                return Container(
                  padding: const EdgeInsets.all(32),
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.link_off, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhuma URL encurtada ainda',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
