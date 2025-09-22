import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/domain/repositories/alias_repository.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_default_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_empty_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_error_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_loaded_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_loading_widget.dart';
import 'package:nubank_test/modules/home/presenter/components/intro_card.dart';
import 'package:nubank_test/modules/home/presenter/components/url_input_card.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';
import 'package:nubank_test/modules/home/presenter/pages/home_page.dart';

class MockAliasRepository extends Mock implements AliasRepository {}

void main() {
  late MockAliasRepository mockRepository;
  late AliasCubit aliasCubit;

  setUp(() {
    mockRepository = MockAliasRepository();
    aliasCubit = AliasCubit(mockRepository);

    // Register fallback values for mocktail
    registerFallbackValue(Uri.parse('https://example.com'));

    // Mock GetIt registration
    if (GetIt.I.isRegistered<AliasRepository>()) {
      GetIt.I.unregister<AliasRepository>();
    }
    GetIt.I.registerSingleton<AliasRepository>(mockRepository);
  });

  tearDown(() {
    aliasCubit.close();
    if (GetIt.I.isRegistered<AliasRepository>()) {
      GetIt.I.unregister<AliasRepository>();
    }
  });

  group('HomePage', () {
    testWidgets('should create HomePage with BlocProvider', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(BlocProvider<AliasCubit>), findsOneWidget);
      expect(find.byType(HomeView), findsOneWidget);
    });
  });

  group('HomeView', () {
    Widget buildTestWidget({AliasCubit? cubit}) {
      return MaterialApp(
        home: BlocProvider<AliasCubit>(
          create: (_) => cubit ?? aliasCubit,
          child: const HomeView(),
        ),
      );
    }

    testWidgets('should render AppBar with correct title and styling', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);

      final title = find.text('Encurtador de URL');
      expect(title, findsOneWidget);

      final appBarWidget = tester.widget<AppBar>(appBar);
      expect(appBarWidget.backgroundColor, const Color(0xFF8A05BE));
      expect(appBarWidget.elevation, 0);
      expect(appBarWidget.centerTitle, true);
    });

    testWidgets('should render main layout structure', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(ListView), findsOneWidget);

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, const Color(0xFFF5F5F5));
    });

    testWidgets('should render intro card and url input card', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(IntroCard), findsOneWidget);
      expect(find.byType(UrlInputCard), findsOneWidget);
    });

    testWidgets('should display default state initially', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      expect(find.byType(AliasDefaultWidget), findsOneWidget);
      expect(find.byType(AliasLoadingWidget), findsNothing);
      expect(find.byType(AliasErrorWidget), findsNothing);
      expect(find.byType(AliasLoadedWidget), findsNothing);
      expect(find.byType(AliasEmptyWidget), findsNothing);
    });

    testWidgets('should display loading state when cubit is loading', (
      tester,
    ) async {
      final testCubit = AliasCubit(mockRepository);
      await tester.pumpWidget(buildTestWidget(cubit: testCubit));

      testCubit.emit(AliasLoading());
      await tester.pump();

      expect(find.byType(AliasLoadingWidget), findsOneWidget);
      expect(find.byType(AliasDefaultWidget), findsNothing);

      testCubit.close();
    });

    testWidgets('should display error state when cubit has error', (
      tester,
    ) async {
      const errorMessage = 'Failed to shorten URL';
      final testCubit = AliasCubit(mockRepository);
      await tester.pumpWidget(buildTestWidget(cubit: testCubit));

      testCubit.emit(AliasError(errorMessage));
      await tester.pump();

      expect(find.byType(AliasErrorWidget), findsOneWidget);
      expect(find.byType(AliasDefaultWidget), findsNothing);

      testCubit.close();
    });

    testWidgets('should display empty state when aliases list is empty', (
      tester,
    ) async {
      final testCubit = AliasCubit(mockRepository);
      await tester.pumpWidget(buildTestWidget(cubit: testCubit));

      testCubit.emit(AliasesLoaded([]));
      await tester.pump();

      expect(find.byType(AliasEmptyWidget), findsOneWidget);
      expect(find.byType(AliasDefaultWidget), findsNothing);

      testCubit.close();
    });

    testWidgets('should display loaded state when aliases exist', (
      tester,
    ) async {
      final testCubit = AliasCubit(mockRepository);
      final aliases = [
        const AliasModel(
          alias: 'abc123',
          original: 'https://example.com',
          short: 'https://short.ly/abc123',
        ),
      ];

      await tester.pumpWidget(buildTestWidget(cubit: testCubit));

      testCubit.emit(AliasesLoaded(aliases));
      await tester.pump();

      expect(find.byType(AliasLoadedWidget), findsOneWidget);
      expect(find.byType(AliasDefaultWidget), findsNothing);

      testCubit.close();
    });

    testWidgets(
      'should call cubit.shorten when UrlInputCard onShorten is triggered',
      (tester) async {
        final testCubit = AliasCubit(mockRepository);
        const testUrl = 'https://example.com';

        when(() => mockRepository.createAlias(any())).thenAnswer(
          (_) async => const AliasModel(
            alias: 'abc123',
            original: testUrl,
            short: 'https://short.ly/abc123',
          ),
        );

        await tester.pumpWidget(buildTestWidget(cubit: testCubit));

        // Find the text field and enter URL
        final textField = find.byType(TextField);
        expect(textField, findsOneWidget);

        await tester.enterText(textField, testUrl);
        await tester.pump();

        // Find and tap the shorten button
        final shortenButton = find.byType(ElevatedButton);
        expect(shortenButton, findsOneWidget);

        await tester.tap(shortenButton);
        await tester.pump();

        // Verify the repository was called
        verify(() => mockRepository.createAlias(testUrl)).called(1);

        testCubit.close();
      },
    );

    testWidgets('should clear text field after successful shortening', (
      tester,
    ) async {
      final testCubit = AliasCubit(mockRepository);
      const testUrl = 'https://example.com';

      when(() => mockRepository.createAlias(any())).thenAnswer(
        (_) async => const AliasModel(
          alias: 'abc123',
          original: testUrl,
          short: 'https://short.ly/abc123',
        ),
      );

      await tester.pumpWidget(buildTestWidget(cubit: testCubit));

      // Enter URL and submit
      final textField = find.byType(TextField);
      await tester.enterText(textField, testUrl);
      await tester.pump();

      final shortenButton = find.byType(ElevatedButton);
      await tester.tap(shortenButton);
      await tester.pumpAndSettle();

      // Check that text field is cleared
      final textFieldWidget = tester.widget<TextField>(textField);
      expect(textFieldWidget.controller?.text, isEmpty);

      testCubit.close();
    });

    testWidgets(
      'should call clearError when retry is pressed on error widget',
      (tester) async {
        final testCubit = AliasCubit(mockRepository);

        // Use a simpler widget structure for this test
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider<AliasCubit>(
              create: (_) => testCubit,
              child: Scaffold(
                body: Center(
                  child: AliasErrorWidget(
                    message: 'Test error',
                    onRetry: () => testCubit.clearError(),
                  ),
                ),
              ),
            ),
          ),
        );

        // Verify error widget is displayed
        expect(find.byType(AliasErrorWidget), findsOneWidget);
        expect(find.text('Test error'), findsOneWidget);

        // Find and tap retry button
        final retryButton = find.byType(ElevatedButton);
        expect(retryButton, findsOneWidget);

        // Emit error state first
        testCubit.emit(AliasError('Test error'));
        await tester.pump();

        await tester.tap(retryButton);
        await tester.pump();

        // Verify clearError was called (state should change to initial)
        expect(testCubit.state, isA<AliasInitial>());

        testCubit.close();
      },
    );

    testWidgets('should have proper widget structure and accessibility', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget());

      // Check that main components exist
      expect(find.text('Encurtador de URL'), findsOneWidget);
      expect(find.byType(IntroCard), findsOneWidget);
      expect(find.byType(UrlInputCard), findsOneWidget);
      expect(find.byType(AliasDefaultWidget), findsOneWidget);

      // Verify widgets are semantically accessible
      expect(find.byType(Semantics), findsWidgets);
    });

    testWidgets('should display different widgets for different states', (
      tester,
    ) async {
      final testCubit = AliasCubit(mockRepository);
      await tester.pumpWidget(buildTestWidget(cubit: testCubit));

      // Test loading state
      testCubit.emit(AliasLoading());
      await tester.pump();
      expect(find.byType(AliasLoadingWidget), findsOneWidget);

      // Test error state
      testCubit.emit(AliasError('Test error'));
      await tester.pump();
      expect(find.byType(AliasErrorWidget), findsOneWidget);

      // Test empty state
      testCubit.emit(AliasesLoaded([]));
      await tester.pump();
      expect(find.byType(AliasEmptyWidget), findsOneWidget);

      // Test loaded state
      final aliases = [
        const AliasModel(
          alias: 'abc123',
          original: 'https://example.com',
          short: 'https://short.ly/abc123',
        ),
      ];
      testCubit.emit(AliasesLoaded(aliases));
      await tester.pump();
      expect(find.byType(AliasLoadedWidget), findsOneWidget);

      // Test default state
      testCubit.emit(AliasInitial());
      await tester.pump();
      expect(find.byType(AliasDefaultWidget), findsOneWidget);

      testCubit.close();
    });

    testWidgets('should dispose controller properly', (tester) async {
      await tester.pumpWidget(buildTestWidget());

      // Verify the widget exists
      expect(find.byType(HomeView), findsOneWidget);

      // Remove the widget to trigger dispose
      await tester.pumpWidget(const MaterialApp(home: Scaffold()));

      // No assertion needed here, just ensuring dispose doesn't throw
    });
  });
}
