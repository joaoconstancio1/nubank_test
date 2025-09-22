import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';

void main() {
  group('AliasState', () {
    group('AliasInitial', () {
      test('should have empty props', () {
        final state = AliasInitial();

        expect(state.props, isEmpty);
        expect(state, isA<AliasState>());
      });

      test('should support equality', () {
        final state1 = AliasInitial();
        final state2 = AliasInitial();

        expect(state1, equals(state2));
      });
    });

    group('AliasLoading', () {
      test('should have empty props', () {
        final state = AliasLoading();

        expect(state.props, isEmpty);
        expect(state, isA<AliasState>());
      });

      test('should support equality', () {
        final state1 = AliasLoading();
        final state2 = AliasLoading();

        expect(state1, equals(state2));
      });
    });

    group('AliasesLoaded', () {
      test('should contain aliases in props', () {
        const aliases = [
          AliasModel(
            alias: 'test1',
            original: 'https://example1.com',
            short: 'https://short.ly/1',
          ),
          AliasModel(
            alias: 'test2',
            original: 'https://example2.com',
            short: 'https://short.ly/2',
          ),
        ];

        final state = AliasesLoaded(aliases);

        expect(state.aliases, equals(aliases));
        expect(state.props, equals([aliases]));
        expect(state, isA<AliasState>());
      });

      test('should support equality based on aliases', () {
        const aliases1 = [
          AliasModel(
            alias: 'test1',
            original: 'https://example1.com',
            short: 'https://short.ly/1',
          ),
        ];

        const aliases2 = [
          AliasModel(
            alias: 'test1',
            original: 'https://example1.com',
            short: 'https://short.ly/1',
          ),
        ];

        const aliases3 = [
          AliasModel(
            alias: 'test2',
            original: 'https://example2.com',
            short: 'https://short.ly/2',
          ),
        ];

        final state1 = AliasesLoaded(aliases1);
        final state2 = AliasesLoaded(aliases2);
        final state3 = AliasesLoaded(aliases3);

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });

      test('should handle empty aliases list', () {
        final state = AliasesLoaded([]);

        expect(state.aliases, isEmpty);
        expect(state.props, equals([[]]));
      });
    });

    group('AliasError', () {
      test('should contain message in props', () {
        const message = 'Something went wrong';

        final state = AliasError(message);

        expect(state.message, equals(message));
        expect(state.props, equals([message]));
        expect(state, isA<AliasState>());
      });

      test('should support equality based on message', () {
        const message1 = 'Error message 1';
        const message2 = 'Error message 1';
        const message3 = 'Error message 2';

        final state1 = AliasError(message1);
        final state2 = AliasError(message2);
        final state3 = AliasError(message3);

        expect(state1, equals(state2));
        expect(state1, isNot(equals(state3)));
      });

      test('should handle empty message', () {
        final state = AliasError('');

        expect(state.message, equals(''));
        expect(state.props, equals(['']));
      });
    });

    group('State hierarchy', () {
      test('all states should extend AliasState', () {
        final initial = AliasInitial();
        final loading = AliasLoading();
        final loaded = AliasesLoaded([]);
        final error = AliasError('Error');

        expect(initial, isA<AliasState>());
        expect(loading, isA<AliasState>());
        expect(loaded, isA<AliasState>());
        expect(error, isA<AliasState>());
      });

      test('states should be different types', () {
        final initial = AliasInitial();
        final loading = AliasLoading();
        final loaded = AliasesLoaded([]);
        final error = AliasError('Error');

        expect(initial.runtimeType, isNot(equals(loading.runtimeType)));
        expect(initial.runtimeType, isNot(equals(loaded.runtimeType)));
        expect(initial.runtimeType, isNot(equals(error.runtimeType)));
        expect(loading.runtimeType, isNot(equals(loaded.runtimeType)));
        expect(loading.runtimeType, isNot(equals(error.runtimeType)));
        expect(loaded.runtimeType, isNot(equals(error.runtimeType)));
      });
    });
  });
}
