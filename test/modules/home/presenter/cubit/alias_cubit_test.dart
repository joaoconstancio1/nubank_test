import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/domain/repositories/alias_repository.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_cubit.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';

class MockAliasRepository extends Mock implements AliasRepository {}

void main() {
  group('AliasCubit', () {
    late AliasCubit cubit;
    late MockAliasRepository mockRepository;

    const aliasModel = AliasModel(
      alias: 'test-alias',
      original: 'https://example.com',
      short: 'https://short.ly/test',
    );

    setUp(() {
      mockRepository = MockAliasRepository();
      cubit = AliasCubit(mockRepository);
    });

    test('initial state is AliasInitial', () {
      expect(cubit.state, isA<AliasInitial>());
    });

    group('shorten', () {
      const url = 'https://example.com';

      blocTest<AliasCubit, AliasState>(
        'should emit [AliasLoading, AliasesLoaded] when successful',
        build: () {
          when(
            () => mockRepository.createAlias(url),
          ).thenAnswer((_) async => aliasModel);
          return cubit;
        },
        act: (cubit) => cubit.shorten(url),
        expect: () => [
          isA<AliasLoading>(),
          isA<AliasesLoaded>().having((state) => state.aliases, 'aliases', [
            aliasModel,
          ]),
        ],
        verify: (_) {
          verify(() => mockRepository.createAlias(url)).called(1);
        },
      );

      blocTest<AliasCubit, AliasState>(
        'should emit [AliasLoading, AliasError] when repository throws exception',
        build: () {
          when(
            () => mockRepository.createAlias(url),
          ).thenThrow(Exception('Repository error'));
          return cubit;
        },
        act: (cubit) => cubit.shorten(url),
        expect: () => [
          isA<AliasLoading>(),
          isA<AliasError>().having(
            (state) => state.message,
            'message',
            contains('Repository error'),
          ),
        ],
        verify: (_) {
          verify(() => mockRepository.createAlias(url)).called(1);
        },
      );

      blocTest<AliasCubit, AliasState>(
        'should not emit any state when URL is empty',
        build: () => cubit,
        act: (cubit) => cubit.shorten(''),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockRepository.createAlias(any()));
        },
      );

      blocTest<AliasCubit, AliasState>(
        'should not emit any state when URL is only whitespace',
        build: () => cubit,
        act: (cubit) => cubit.shorten('   '),
        expect: () => [],
        verify: (_) {
          verifyNever(() => mockRepository.createAlias(any()));
        },
      );
    });

    group('clearError', () {
      blocTest<AliasCubit, AliasState>(
        'should emit AliasInitial when there are no aliases and current state is error',
        build: () => cubit,
        seed: () => AliasError('Some error'),
        act: (cubit) => cubit.clearError(),
        expect: () => [isA<AliasInitial>()],
      );

      blocTest<AliasCubit, AliasState>(
        'should not emit any state when current state is not error',
        build: () => cubit,
        seed: () => AliasInitial(),
        act: (cubit) => cubit.clearError(),
        expect: () => [],
      );
    });

    group('getOriginalUrl', () {
      const aliasId = 'test-alias';
      const originalUrl = 'https://example.com/original';

      test(
        'should return original URL when repository call succeeds',
        () async {
          when(
            () => mockRepository.getOriginalUrl(aliasId),
          ).thenAnswer((_) async => originalUrl);

          final result = await cubit.getOriginalUrl(aliasId);

          expect(result, equals(originalUrl));
          verify(() => mockRepository.getOriginalUrl(aliasId)).called(1);
        },
      );

      test(
        'should throw exception with custom message when repository call fails',
        () async {
          when(
            () => mockRepository.getOriginalUrl(aliasId),
          ).thenThrow(Exception('Repository error'));

          expect(
            () async => await cubit.getOriginalUrl(aliasId),
            throwsA(
              isA<Exception>().having(
                (e) => e.toString(),
                'message',
                contains('Erro ao buscar URL original'),
              ),
            ),
          );
          verify(() => mockRepository.getOriginalUrl(aliasId)).called(1);
        },
      );
    });
  });
}
