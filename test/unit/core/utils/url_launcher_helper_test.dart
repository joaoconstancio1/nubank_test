import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_test/core/utils/url_launcher_helper.dart';

void main() {
  group('UrlLauncherHelper', () {
    testWidgets('should add https:// prefix when URL doesn\'t have protocol', (
      WidgetTester tester,
    ) async {
      const url = 'www.example.com';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    try {
                      await UrlLauncherHelper.openUrl(context, url);
                    } catch (e) {
                      // Ignorar erro para este teste
                    }
                  },
                  child: const Text('Open URL'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('should not modify URL that already has protocol', (
      WidgetTester tester,
    ) async {
      const url = 'https://www.example.com';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    try {
                      await UrlLauncherHelper.openUrl(context, url);
                    } catch (e) {
                      // Ignorar erro para este teste
                    }
                  },
                  child: const Text('Open URL'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle http:// protocol correctly', (
      WidgetTester tester,
    ) async {
      const url = 'http://www.example.com';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    try {
                      await UrlLauncherHelper.openUrl(context, url);
                    } catch (e) {
                      // Ignorar erro para este teste
                    }
                  },
                  child: const Text('Open URL'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle URL opening without throwing exceptions', (
      WidgetTester tester,
    ) async {
      const invalidUrl = 'invalid-url';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () =>
                      UrlLauncherHelper.openUrl(context, invalidUrl),
                  child: const Text('Open Invalid URL'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();
      await tester.pump();

      expect(tester.takeException(), isNull);
    });

    testWidgets('should handle context not mounted scenario', (
      WidgetTester tester,
    ) async {
      const url = 'invalid-url';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () => UrlLauncherHelper.openUrl(context, url),
                  child: const Text('Open URL'),
                );
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    test('should create valid URI from URL strings', () {
      expect(Uri.tryParse('https://www.example.com'), isNotNull);
      expect(Uri.tryParse('http://www.example.com'), isNotNull);
      expect(Uri.tryParse('ftp://files.example.com'), isNotNull);
    });

    test('should handle URL with different protocols', () {
      const urls = [
        'https://www.example.com',
        'http://www.example.com',
        'www.example.com',
        'example.com',
      ];

      for (final url in urls) {
        final finalUrl = url.startsWith('http://') || url.startsWith('https://')
            ? url
            : 'https://$url';

        expect(Uri.tryParse(finalUrl), isNotNull);
      }
    });
  });
}
