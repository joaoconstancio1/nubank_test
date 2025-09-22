import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_test/core/network/custom_http_client.dart';
import 'package:nubank_test/core/network/http_exceptions.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/data/services/alias_service.dart';

class MockCustomHttpClient extends Mock implements CustomHttpClient {}

void main() {
  late AliasServiceImpl service;
  late MockCustomHttpClient mockClient;

  setUp(() {
    mockClient = MockCustomHttpClient();
    service = AliasServiceImpl(client: mockClient);
  });

  group('AliasServiceImpl', () {
    group('createAlias', () {
      test('should return AliasModel when request is successful', () async {
        const url = 'https://example.com';
        final responseData = {
          'alias': 'test-alias',
          '_links': {
            'self': 'https://example.com',
            'short': 'https://short.ly/test',
          },
        };

        when(
          () => mockClient.post('/alias', data: {'url': url}),
        ).thenAnswer((_) async => responseData);

        final result = await service.createAlias(url);

        expect(result, isA<AliasModel>());
        expect(result.alias, equals('test-alias'));
        expect(result.original, equals('https://example.com'));
        expect(result.short, equals('https://short.ly/test'));
        verify(() => mockClient.post('/alias', data: {'url': url})).called(1);
      });

      test('should throw Exception when ServerException occurs', () async {
        const url = 'https://example.com';
        final serverException = ServerException(
          'Internal server error',
          statusCode: 500,
        );

        when(
          () => mockClient.post('/alias', data: {'url': url}),
        ).thenThrow(serverException);

        expect(
          () async => await service.createAlias(url),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Erro do servidor: 500'),
            ),
          ),
        );
      });

      test('should throw Exception when NetworkException occurs', () async {
        const url = 'https://example.com';
        final networkException = NetworkException('Connection timeout');

        when(
          () => mockClient.post('/alias', data: {'url': url}),
        ).thenThrow(networkException);

        expect(
          () async => await service.createAlias(url),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Erro de conexão: Connection timeout'),
            ),
          ),
        );
      });

      test('should throw Exception when unexpected error occurs', () async {
        const url = 'https://example.com';
        const unexpectedException = 'Unexpected error';

        when(
          () => mockClient.post('/alias', data: {'url': url}),
        ).thenThrow(unexpectedException);

        expect(
          () async => await service.createAlias(url),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Erro inesperado: $unexpectedException'),
            ),
          ),
        );
      });
    });

    group('getOriginalUrl', () {
      test('should return original URL when request is successful', () async {
        const aliasId = 'test-alias';
        const expectedUrl = 'https://example.com/original';
        final responseData = {'url': expectedUrl};

        when(
          () => mockClient.get('/alias/$aliasId'),
        ).thenAnswer((_) async => responseData);

        final result = await service.getOriginalUrl(aliasId);

        expect(result, equals(expectedUrl));
        verify(() => mockClient.get('/alias/$aliasId')).called(1);
      });

      test(
        'should throw "Alias não encontrado" when 404 error occurs',
        () async {
          const aliasId = 'non-existent-alias';
          final serverException = ServerException('Not found', statusCode: 404);

          when(
            () => mockClient.get('/alias/$aliasId'),
          ).thenThrow(serverException);

          expect(
            () async => await service.getOriginalUrl(aliasId),
            throwsA(
              isA<Exception>().having(
                (e) => e.toString(),
                'message',
                contains('Alias não encontrado'),
              ),
            ),
          );
        },
      );

      test(
        'should throw server error when non-404 ServerException occurs',
        () async {
          const aliasId = 'test-alias';
          final serverException = ServerException(
            'Internal server error',
            statusCode: 500,
          );

          when(
            () => mockClient.get('/alias/$aliasId'),
          ).thenThrow(serverException);

          expect(
            () async => await service.getOriginalUrl(aliasId),
            throwsA(
              isA<Exception>().having(
                (e) => e.toString(),
                'message',
                contains('Erro do servidor: 500'),
              ),
            ),
          );
        },
      );

      test('should throw Exception when NetworkException occurs', () async {
        const aliasId = 'test-alias';
        final networkException = NetworkException('No internet connection');

        when(
          () => mockClient.get('/alias/$aliasId'),
        ).thenThrow(networkException);

        expect(
          () async => await service.getOriginalUrl(aliasId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Erro de conexão: No internet connection'),
            ),
          ),
        );
      });

      test('should throw Exception when unexpected error occurs', () async {
        const aliasId = 'test-alias';
        const unexpectedException = 'Parsing error';

        when(
          () => mockClient.get('/alias/$aliasId'),
        ).thenThrow(unexpectedException);

        expect(
          () async => await service.getOriginalUrl(aliasId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Erro inesperado: $unexpectedException'),
            ),
          ),
        );
      });
    });
  });
}
