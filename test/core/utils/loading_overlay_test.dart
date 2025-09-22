import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_test/core/utils/loading_overlay.dart';

void main() {
  group('LoadingOverlay', () {
    setUp(() {
      LoadingOverlay.hide();
    });

    tearDown(() {
      LoadingOverlay.hide();
    });

    testWidgets('should show overlay with default message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => LoadingOverlay.show(context),
                  child: const Text('Show Overlay'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Carregando...'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(LoadingOverlay.isShowing, isTrue);
    });

    testWidgets('should show overlay with custom message', (
      WidgetTester tester,
    ) async {
      LoadingOverlay.hide();

      const customMessage = 'Processando...';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () =>
                      LoadingOverlay.show(context, message: customMessage),
                  child: const Text('Show Overlay'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text(customMessage), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(LoadingOverlay.isShowing, isTrue);

      LoadingOverlay.hide();
    });

    testWidgets('should hide overlay when hide is called', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => LoadingOverlay.show(context),
                      child: const Text('Show Overlay'),
                    ),
                    ElevatedButton(
                      onPressed: () => LoadingOverlay.hide(),
                      child: const Text('Hide Overlay'),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Overlay'));
      await tester.pump();
      expect(LoadingOverlay.isShowing, isTrue);

      LoadingOverlay.hide();
      await tester.pump();

      expect(find.text('Carregando...'), findsNothing);
      expect(LoadingOverlay.isShowing, isFalse);
    });

    testWidgets('should not show multiple overlays', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () {
                    LoadingOverlay.show(context, message: 'First');
                    LoadingOverlay.show(context, message: 'Second');
                  },
                  child: const Text('Show Multiple'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('First'), findsOneWidget);
      expect(find.text('Second'), findsNothing);
      expect(LoadingOverlay.isShowing, isTrue);
    });

    testWidgets('should have correct styling', (WidgetTester tester) async {
      LoadingOverlay.hide();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => LoadingOverlay.show(context),
                  child: const Text('Show Overlay'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Carregando...'), findsOneWidget);

      final textWidget = tester.widget<Text>(find.text('Carregando...'));
      expect(textWidget.style?.color, equals(Colors.white));
      expect(textWidget.style?.fontSize, equals(16));
      expect(textWidget.style?.fontWeight, equals(FontWeight.w500));
      expect(textWidget.style?.decoration, equals(TextDecoration.none));

      final progressIndicator = tester.widget<CircularProgressIndicator>(
        find.byType(CircularProgressIndicator),
      );
      expect(progressIndicator.strokeWidth, equals(3));
      expect(
        progressIndicator.valueColor,
        isA<AlwaysStoppedAnimation<Color>>(),
      );

      LoadingOverlay.hide();
    });

    test('should return correct isShowing status', () {
      LoadingOverlay.hide();

      expect(LoadingOverlay.isShowing, isFalse);

      LoadingOverlay.hide();
      expect(LoadingOverlay.isShowing, isFalse);
    });
  });
}
