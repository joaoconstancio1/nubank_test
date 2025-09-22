import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_test/core/utils/constants.dart';

void main() {
  group('Constants', () {
    test('should have correct baseUrl', () {
      expect(
        Constants.baseUrl,
        equals('https://url-shortener-server.onrender.com/api'),
      );
    });

    test('baseUrl should not be empty', () {
      expect(Constants.baseUrl, isNotEmpty);
    });

    test('baseUrl should be a valid URL format', () {
      final url = Constants.baseUrl;

      expect(url.startsWith('https://'), isTrue);
      expect(Uri.tryParse(url), isNotNull);
    });
  });
}
