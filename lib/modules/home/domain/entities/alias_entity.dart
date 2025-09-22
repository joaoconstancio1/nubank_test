import 'package:equatable/equatable.dart';

class AliasEntity extends Equatable {
  final String alias;
  final String original;
  final String short;

  const AliasEntity({
    required this.alias,
    required this.original,
    required this.short,
  });

  @override
  List<Object?> get props => [alias, original, short];
}
