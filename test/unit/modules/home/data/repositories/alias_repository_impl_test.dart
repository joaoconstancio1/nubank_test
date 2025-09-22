import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/data/repositories/alias_repository_impl.dart';
import 'package:nubank_test/modules/home/data/services/alias_service.dart';
import 'package:nubank_test/modules/home/domain/repositories/alias_repository.dart';

class MockAliasService extends Mock implements AliasService {}

void main() {
  late AliasRepositoryImpl repository;
  late MockAliasService mockService;

  setUp(() {
    mockService = MockAliasService();
    repository = AliasRepositoryImpl(mockService);
  });

  group('AliasRepositoryImpl', () {
    test('should be an implementation of AliasRepository', () {
      expect(repository, isA<AliasRepository>());
    });

    group('createAlias', () {
      test(
        'should return AliasModel when service call is successful',
        () async {
          const url = 'https://example.com';
          const expectedModel = AliasModel(
            alias: 'test-alias',
            original: 'https://example.com',
            short: 'https://short.ly/test',
          );

          when(
            () => mockService.createAlias(url),
          ).thenAnswer((_) async => expectedModel);

          final result = await repository.createAlias(url);

          expect(result, equals(expectedModel));
          verify(() => mockService.createAlias(url)).called(1);
        },
      );

      test('should throw exception when service throws exception', () async {
        const url = 'https://example.com';
        final exception = Exception('Service error');

        when(() => mockService.createAlias(url)).thenThrow(exception);

        expect(
          () async => await repository.createAlias(url),
          throwsA(equals(exception)),
        );
        verify(() => mockService.createAlias(url)).called(1);
      });
    });

    group('getOriginalUrl', () {
      test(
        'should return original URL when service call is successful',
        () async {
          const aliasId = 'test-alias';
          const expectedUrl = 'https://example.com/original';

          when(
            () => mockService.getOriginalUrl(aliasId),
          ).thenAnswer((_) async => expectedUrl);

          final result = await repository.getOriginalUrl(aliasId);

          expect(result, equals(expectedUrl));
          verify(() => mockService.getOriginalUrl(aliasId)).called(1);
        },
      );

      test('should throw exception when service throws exception', () async {
        const aliasId = 'test-alias';
        final exception = Exception('Alias not found');

        when(() => mockService.getOriginalUrl(aliasId)).thenThrow(exception);

        expect(
          () async => await repository.getOriginalUrl(aliasId),
          throwsA(equals(exception)),
        );
        verify(() => mockService.getOriginalUrl(aliasId)).called(1);
      });
    });
  });
}
