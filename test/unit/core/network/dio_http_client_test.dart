import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_test/core/network/dio_http_client.dart';
import 'package:nubank_test/core/network/http_exceptions.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late DioHttpClient client;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    client = DioHttpClient(dio: mockDio);
  });

  group('DioHttpClient', () {
    group('get', () {
      test(
        'should return Map<String, dynamic> when request is successful',
        () async {
          // Arrange
          const path = '/test';
          const queryParameters = {'param': 'value'};
          const responseData = {'success': true, 'data': 'test'};

          final response = Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: path),
            statusCode: 200,
            data: responseData,
          );

          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenAnswer((_) async => response);

          // Act
          final result = await client.get(
            path,
            queryParameters: queryParameters,
          );

          // Assert
          expect(result, equals(responseData));
          verify(
            () => mockDio.get(path, queryParameters: queryParameters),
          ).called(1);
        },
      );

      test(
        'should throw ServerException when DioException has response',
        () async {
          // Arrange
          const path = '/test';
          final dioException = DioException(
            requestOptions: RequestOptions(path: path),
            response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: 500,
              data: {'error': 'Internal server error'},
            ),
          );

          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenThrow(dioException);

          // Act & Assert
          expect(
            () async => await client.get(path),
            throwsA(
              isA<ServerException>().having(
                (e) => e.statusCode,
                'statusCode',
                equals(500),
              ),
            ),
          );
        },
      );

      test(
        'should throw NetworkException when DioException has no response',
        () async {
          // Arrange
          const path = '/test';
          final dioException = DioException(
            requestOptions: RequestOptions(path: path),
            message: 'Connection timeout',
          );

          when(
            () => mockDio.get(
              any(),
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenThrow(dioException);

          // Act & Assert
          expect(
            () async => await client.get(path),
            throwsA(isA<NetworkException>()),
          );
        },
      );
    });

    group('post', () {
      test(
        'should return Map<String, dynamic> when request is successful',
        () async {
          // Arrange
          const path = '/test';
          const data = {'name': 'test'};
          const queryParameters = {'param': 'value'};
          const responseData = {'success': true, 'id': 1};

          final response = Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: path),
            statusCode: 201,
            data: responseData,
          );

          when(
            () => mockDio.post(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenAnswer((_) async => response);

          // Act
          final result = await client.post(
            path,
            data: data,
            queryParameters: queryParameters,
          );

          // Assert
          expect(result, equals(responseData));
          verify(
            () => mockDio.post(
              path,
              data: data,
              queryParameters: queryParameters,
            ),
          ).called(1);
        },
      );

      test(
        'should throw ServerException when DioException has response',
        () async {
          // Arrange
          const path = '/test';
          const data = {'invalid': 'data'};
          final dioException = DioException(
            requestOptions: RequestOptions(path: path),
            response: Response(
              requestOptions: RequestOptions(path: path),
              statusCode: 400,
              data: {'error': 'Bad request'},
            ),
          );

          when(
            () => mockDio.post(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenThrow(dioException);

          // Act & Assert
          expect(
            () async => await client.post(path, data: data),
            throwsA(
              isA<ServerException>().having(
                (e) => e.statusCode,
                'statusCode',
                equals(400),
              ),
            ),
          );
        },
      );

      test(
        'should throw NetworkException when DioException has no response',
        () async {
          // Arrange
          const path = '/test';
          const data = {'name': 'test'};
          final dioException = DioException(
            requestOptions: RequestOptions(path: path),
            message: 'Network error',
          );

          when(
            () => mockDio.post(
              any(),
              data: any(named: 'data'),
              queryParameters: any(named: 'queryParameters'),
            ),
          ).thenThrow(dioException);

          // Act & Assert
          expect(
            () async => await client.post(path, data: data),
            throwsA(isA<NetworkException>()),
          );
        },
      );
    });
  });
}
