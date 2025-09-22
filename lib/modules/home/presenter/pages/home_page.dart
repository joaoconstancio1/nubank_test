import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';
import 'package:nubank_test/modules/home/presenter/pages/alias_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nubank URL Shortener')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Cole a URL aqui'),
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final cubit = context.read<AliasCubit>();
                      cubit.shorten(_controller.text);
                    },
                    child: const Text('Encurtar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<AliasCubit, AliasState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state.error != null) {
                    return Column(
                      children: [
                        Text('Erro: ${state.error}'),
                        ElevatedButton(
                          onPressed: () =>
                              context.read<AliasCubit>().clearError(),
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  }
                  if (state.aliases.isEmpty) {
                    return const Center(
                      child: Text('Nenhum alias gerado ainda'),
                    );
                  }
                  return ListView.builder(
                    itemCount: state.aliases.length,
                    itemBuilder: (context, index) {
                      final a = state.aliases[index];
                      return AliasTile(
                        alias: a,
                        onCopy: () async {
                          await Clipboard.setData(ClipboardData(text: a.short));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Curta copiada')),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
