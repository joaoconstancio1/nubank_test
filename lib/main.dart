import 'package:flutter/material.dart';
import 'package:nubank_test/core/injection.dart';
import 'package:nubank_test/modules/home/presenter/pages/home_page.dart';
import 'package:nubank_design_system/nubank_design_system.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nubank URL Shortener',
      theme: AppTheme.lightTheme,
      home: HomePage(),
    );
  }
}
