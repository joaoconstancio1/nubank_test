import 'package:nubank_test/modules/home/domain/entities/alias_entity.dart';

class AliasModel extends AliasEntity {
  const AliasModel({
    required super.alias,
    required super.original,
    required super.short,
  });

  factory AliasModel.fromJson(Map<String, dynamic> json) {
    final alias = json['alias'] as String? ?? '';
    final links = json['_links'] as Map<String, dynamic>? ?? {};
    return AliasModel(
      alias: alias,
      original: links['self'] as String? ?? '',
      short: links['short'] as String? ?? '',
    );
  }
}
