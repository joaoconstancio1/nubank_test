import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_test/modules/home/domain/entities/alias_entity.dart';

void main() {
  group('AliasEntity', () {
    test('should create entity with correct properties', () {
      const alias = 'test-alias';
      const original = 'https://example.com/original';
      const short = 'https://short.ly/test';

      const entity = AliasEntity(
        alias: alias,
        original: original,
        short: short,
      );

      expect(entity.alias, equals(alias));
      expect(entity.original, equals(original));
      expect(entity.short, equals(short));
    });

    test('should support equality based on properties', () {
      const entity1 = AliasEntity(
        alias: 'test-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      const entity2 = AliasEntity(
        alias: 'test-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      const entity3 = AliasEntity(
        alias: 'different-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      expect(entity1, equals(entity2));
      expect(entity1, isNot(equals(entity3)));
      expect(entity1.hashCode, equals(entity2.hashCode));
      expect(entity1.hashCode, isNot(equals(entity3.hashCode)));
    });

    test('should have correct props for Equatable', () {
      const entity = AliasEntity(
        alias: 'test-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      final props = entity.props;

      expect(props, hasLength(3));
      expect(props, contains('test-alias'));
      expect(props, contains('https://example.com/original'));
      expect(props, contains('https://short.ly/test'));
    });

    test('should support different property combinations', () {
      const entity1 = AliasEntity(
        alias: 'alias1',
        original: 'https://example1.com',
        short: 'https://short.ly/1',
      );

      const entity2 = AliasEntity(
        alias: 'alias2',
        original: 'https://example2.com',
        short: 'https://short.ly/2',
      );

      expect(entity1.alias, isNot(equals(entity2.alias)));
      expect(entity1.original, isNot(equals(entity2.original)));
      expect(entity1.short, isNot(equals(entity2.short)));
      expect(entity1, isNot(equals(entity2)));
    });

    test('should handle empty strings', () {
      const entity = AliasEntity(alias: '', original: '', short: '');

      expect(entity.alias, equals(''));
      expect(entity.original, equals(''));
      expect(entity.short, equals(''));
      expect(entity.props, equals(['', '', '']));
    });

    test('should maintain immutability', () {
      const entity = AliasEntity(
        alias: 'test-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      expect(() => entity.alias, returnsNormally);
      expect(() => entity.original, returnsNormally);
      expect(() => entity.short, returnsNormally);

      expect(entity.alias, isA<String>());
      expect(entity.original, isA<String>());
      expect(entity.short, isA<String>());
    });
  });
}
