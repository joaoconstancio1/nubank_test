import 'package:nubank_test/modules/home/data/models/alias_model.dart';

class AliasState {
  final List<AliasModel> aliases;
  final bool loading;
  final String? error;

  AliasState({required this.aliases, this.loading = false, this.error});

  AliasState copyWith({
    List<AliasModel>? aliases,
    bool? loading,
    String? error,
  }) {
    return AliasState(
      aliases: aliases ?? this.aliases,
      loading: loading ?? this.loading,
      error: error,
    );
  }
}
