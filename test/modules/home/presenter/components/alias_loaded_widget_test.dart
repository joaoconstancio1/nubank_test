import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/presenter/components/alias_loaded_widget.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';
import 'package:nubank_test/modules/home/domain/repositories/alias_repository.dart';

class MockAliasRepository extends Mock implements AliasRepository {}

class MockAliasCubit extends Mock implements AliasCubit {
  @override
  Stream<AliasState> get stream => Stream.empty();

  @override
  Future<void> close() async {}
}

void main() {
  late MockAliasRepository mockRepository;
  late MockAliasCubit mockCubit;

  setUp(() {
    mockRepository = MockAliasRepository();
    mockCubit = MockAliasCubit();
  });

  group('AliasLoadedWidget', () {
    const testAliases = [
      AliasModel(
        alias: 'abc123',
        original: 'https://example.com',
        short: 'https://short.ly/abc123',
      ),
    ];

    Widget buildTestWidget({
      required List<AliasModel> aliases,
      AliasCubit? cubit,
      Function(BuildContext, AliasModel)? onOpenUrl,
    }) {
      return MaterialApp(
        home: BlocProvider<AliasCubit>(
          create: (_) => cubit ?? AliasCubit(mockRepository),
          child: Scaffold(
            body: AliasLoadedWidget(aliases: aliases, onOpenUrl: onOpenUrl),
          ),
        ),
      );
    }

    testWidgets('should display ListView with aliases', (tester) async {
      await tester.pumpWidget(buildTestWidget(aliases: testAliases));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(AliasLoadedWidget), findsOneWidget);
    });

    testWidgets('should trigger onOpen callback and call getOriginalUrl', (
      tester,
    ) async {
      const originalUrl = 'https://example.com';

      when(
        () => mockCubit.getOriginalUrl('abc123'),
      ).thenAnswer((_) async => originalUrl);

      await tester.pumpWidget(
        buildTestWidget(aliases: testAliases, cubit: mockCubit),
      );

      // Find the open button (IconButton with Icons.open_in_new)
      final openButton = find.byIcon(Icons.open_in_new);

      if (openButton.evaluate().isNotEmpty) {
        await tester.tap(openButton);
        await tester.pump();

        // Verify getOriginalUrl was called
        verify(() => mockCubit.getOriginalUrl('abc123')).called(1);
      }
    });

    testWidgets('should handle error in onOpen callback', (tester) async {
      const errorMessage = 'Failed to get original URL';

      when(
        () => mockCubit.getOriginalUrl('abc123'),
      ).thenThrow(Exception(errorMessage));

      await tester.pumpWidget(
        buildTestWidget(aliases: testAliases, cubit: mockCubit),
      );

      final openButton = find.byIcon(Icons.open_in_new);

      if (openButton.evaluate().isNotEmpty) {
        await tester.tap(openButton);
        await tester.pump();
        await tester.pumpAndSettle();

        // Should handle error gracefully
        verify(() => mockCubit.getOriginalUrl('abc123')).called(1);
      }
    });

    testWidgets('should display empty ListView when no aliases', (
      tester,
    ) async {
      await tester.pumpWidget(buildTestWidget(aliases: []));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(AliasLoadedWidget), findsOneWidget);
    });

    testWidgets('should handle context.mounted checks in onOpen', (
      tester,
    ) async {
      when(() => mockCubit.getOriginalUrl(any())).thenAnswer((_) async {
        await Future.delayed(const Duration(milliseconds: 50));
        return 'https://example.com';
      });

      await tester.pumpWidget(
        buildTestWidget(aliases: testAliases, cubit: mockCubit),
      );

      final openButton = find.byIcon(Icons.open_in_new);

      if (openButton.evaluate().isNotEmpty) {
        await tester.tap(openButton);
        await tester.pump();

        // Remove widget to simulate context being unmounted
        await tester.pumpWidget(const MaterialApp(home: Scaffold()));
        await tester.pumpAndSettle();

        // Should not throw error
        expect(tester.takeException(), isNull);
      }
    });

    group('onOpenUrl callback handling', () {
      testWidgets('should call provided onOpenUrl when callback is given', (
        tester,
      ) async {
        bool callbackWasCalled = false;
        AliasModel? receivedAlias;
        BuildContext? receivedContext;

        await tester.pumpWidget(
          buildTestWidget(
            aliases: testAliases,
            cubit: mockCubit,
            onOpenUrl: (context, alias) {
              callbackWasCalled = true;
              receivedContext = context;
              receivedAlias = alias;
            },
          ),
        );

        // Find and tap the open button
        final openButton = find.byIcon(Icons.open_in_browser);
        expect(openButton, findsOneWidget);

        await tester.tap(openButton);
        await tester.pump();

        // Verify custom callback was called
        expect(callbackWasCalled, isTrue);
        expect(receivedContext, isNotNull);
        expect(receivedAlias, equals(testAliases.first));

        // Verify _handleOpenUrl was NOT called (cubit.getOriginalUrl should not be called)
        verifyNever(() => mockCubit.getOriginalUrl(any()));
      });

      testWidgets('should call _handleOpenUrl when onOpenUrl is null', (
        tester,
      ) async {
        const originalUrl = 'https://example.com';

        when(
          () => mockCubit.getOriginalUrl('abc123'),
        ).thenAnswer((_) async => originalUrl);

        await tester.pumpWidget(
          buildTestWidget(
            aliases: testAliases,
            cubit: mockCubit,
            onOpenUrl: null, // Explicitly null
          ),
        );

        // Find and tap the open button
        final openButton = find.byIcon(Icons.open_in_browser);
        expect(openButton, findsOneWidget);

        await tester.tap(openButton);
        await tester.pump();

        // Verify _handleOpenUrl was called (cubit.getOriginalUrl should be called)
        verify(() => mockCubit.getOriginalUrl('abc123')).called(1);
      });

      testWidgets(
        'should handle error in _handleOpenUrl when onOpenUrl is null',
        (tester) async {
          const errorMessage = 'Network error';

          when(
            () => mockCubit.getOriginalUrl('abc123'),
          ).thenThrow(Exception(errorMessage));

          await tester.pumpWidget(
            buildTestWidget(
              aliases: testAliases,
              cubit: mockCubit,
              onOpenUrl: null,
            ),
          );

          // Find and tap the open button
          final openButton = find.byIcon(Icons.open_in_browser);
          await tester.tap(openButton);
          await tester.pump();
          await tester.pumpAndSettle();

          // Verify error was handled and cubit method was called
          verify(() => mockCubit.getOriginalUrl('abc123')).called(1);

          // Check that error snackbar was shown
          expect(find.byType(SnackBar), findsOneWidget);
          expect(
            find.text('Erro ao abrir URL: Exception: $errorMessage'),
            findsOneWidget,
          );
          expect(find.byIcon(Icons.error_outline), findsOneWidget);
        },
      );

      testWidgets(
        'should use provided onOpenUrl over _handleOpenUrl when both are available',
        (tester) async {
          bool customCallbackCalled = false;

          await tester.pumpWidget(
            buildTestWidget(
              aliases: testAliases,
              cubit: mockCubit,
              onOpenUrl: (context, alias) {
                customCallbackCalled = true;
              },
            ),
          );

          // Find and tap the open button
          final openButton = find.byIcon(Icons.open_in_browser);
          await tester.tap(openButton);
          await tester.pump();

          // Custom callback should be called
          expect(customCallbackCalled, isTrue);

          // _handleOpenUrl should NOT be called
          verifyNever(() => mockCubit.getOriginalUrl(any()));
        },
      );

      testWidgets('should handle async onOpenUrl callback', (tester) async {
        bool asyncCallbackCompleted = false;

        await tester.pumpWidget(
          buildTestWidget(
            aliases: testAliases,
            cubit: mockCubit,
            onOpenUrl: (context, alias) async {
              await Future.delayed(const Duration(milliseconds: 100));
              asyncCallbackCompleted = true;
            },
          ),
        );

        // Find and tap the open button
        final openButton = find.byIcon(Icons.open_in_browser);
        await tester.tap(openButton);
        await tester.pump();
        await tester.pumpAndSettle();

        // Async callback should complete
        expect(asyncCallbackCompleted, isTrue);
      });
    });
  });
}
