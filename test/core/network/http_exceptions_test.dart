import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_test/core/network/http_exceptions.dart';

void main() {
  group('HttpException', () {
    test('should create NetworkException with correct message', () {
      const message = 'Network connection failed';

      final exception = NetworkException(message);

      expect(exception.message, equals(message));
      expect(exception.statusCode, isNull);
      expect(exception, isA<HttpException>());
    });

    test('should create ServerException with message and status code', () {
      const message = 'Internal server error';
      const statusCode = 500;
      const data = {'error': 'Database connection failed'};

      final exception = ServerException(
        message,
        statusCode: statusCode,
        data: data,
      );

      expect(exception.message, equals(message));
      expect(exception.statusCode, equals(statusCode));
      expect(exception.data, equals(data));
      expect(exception, isA<HttpException>());
    });

    test('should create ServerException with only message', () {
      const message = 'Server error';

      final exception = ServerException(message);

      expect(exception.message, equals(message));
      expect(exception.statusCode, isNull);
      expect(exception.data, isNull);
    });
  });
}
