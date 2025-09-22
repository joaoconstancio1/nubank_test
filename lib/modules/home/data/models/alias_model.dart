class AliasModel {
  final String alias;
  final String original;
  final String short;

  AliasModel({
    required this.alias,
    required this.original,
    required this.short,
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
