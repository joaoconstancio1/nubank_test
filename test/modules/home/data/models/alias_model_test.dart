import 'package:flutter_test/flutter_test.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/domain/entities/alias_entity.dart';

void main() {
  group('AliasModel', () {
    test('should be a subclass of AliasEntity', () {
      const model = AliasModel(
        alias: 'test-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      expect(model, isA<AliasEntity>());
    });

    test('should create model from valid JSON', () {
      final json = {
        'alias': 'test-alias',
        '_links': {
          'self': 'https://example.com/original',
          'short': 'https://short.ly/test',
        },
      };

      final model = AliasModel.fromJson(json);

      expect(model.alias, equals('test-alias'));
      expect(model.original, equals('https://example.com/original'));
      expect(model.short, equals('https://short.ly/test'));
    });

    test('should handle JSON with missing alias field', () {
      final json = {
        '_links': {
          'self': 'https://example.com/original',
          'short': 'https://short.ly/test',
        },
      };

      final model = AliasModel.fromJson(json);

      expect(model.alias, equals(''));
      expect(model.original, equals('https://example.com/original'));
      expect(model.short, equals('https://short.ly/test'));
    });

    test('should handle JSON with missing _links field', () {
      final json = {'alias': 'test-alias'};

      final model = AliasModel.fromJson(json);

      expect(model.alias, equals('test-alias'));
      expect(model.original, equals(''));
      expect(model.short, equals(''));
    });

    test('should handle JSON with missing self link', () {
      final json = {
        'alias': 'test-alias',
        '_links': {'short': 'https://short.ly/test'},
      };

      final model = AliasModel.fromJson(json);

      expect(model.alias, equals('test-alias'));
      expect(model.original, equals(''));
      expect(model.short, equals('https://short.ly/test'));
    });

    test('should handle JSON with missing short link', () {
      final json = {
        'alias': 'test-alias',
        '_links': {'self': 'https://example.com/original'},
      };

      final model = AliasModel.fromJson(json);

      expect(model.alias, equals('test-alias'));
      expect(model.original, equals('https://example.com/original'));
      expect(model.short, equals(''));
    });

    test('should handle completely empty JSON', () {
      final json = <String, dynamic>{};

      final model = AliasModel.fromJson(json);

      expect(model.alias, equals(''));
      expect(model.original, equals(''));
      expect(model.short, equals(''));
    });

    test('should maintain equality based on properties', () {
      const model1 = AliasModel(
        alias: 'test-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      const model2 = AliasModel(
        alias: 'test-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      const model3 = AliasModel(
        alias: 'different-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      expect(model1, equals(model2));
      expect(model1, isNot(equals(model3)));
    });

    test('should have correct props for equality', () {
      const model = AliasModel(
        alias: 'test-alias',
        original: 'https://example.com/original',
        short: 'https://short.ly/test',
      );

      final props = model.props;

      expect(props, contains('test-alias'));
      expect(props, contains('https://example.com/original'));
      expect(props, contains('https://short.ly/test'));
      expect(props.length, equals(3));
    });
  });
}
