import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_test/modules/home/data/models/services/alias_service.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/modules/home/presenter/pages/home_page.dart';

void main() {
  final service = AliasService();
  runApp(MyApp(service: service));
}

class MyApp extends StatelessWidget {
  final AliasService service;
  const MyApp({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nubank URL Shortener',
      home: BlocProvider(
        create: (_) => AliasCubit(service),
        child: const HomeScreen(),
      ),
    );
  }
}
