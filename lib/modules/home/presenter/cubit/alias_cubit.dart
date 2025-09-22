import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/domain/repositories/alias_repository.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';

class AliasCubit extends Cubit<AliasState> {
  final AliasRepository _repository;
  List<AliasModel> _aliases = [];

  AliasCubit(this._repository) : super(AliasInitial());

  Future<void> shorten(String url) async {
    if (url.trim().isEmpty) return;

    emit(AliasLoading());

    try {
      final alias = await _repository.createAlias(url);
      _aliases = [alias, ..._aliases];
      emit(AliasesLoaded(_aliases));
    } catch (e) {
      emit(AliasError(e.toString()));
    }
  }

  void clearError() {
    if (state is AliasError) {
      if (_aliases.isNotEmpty) {
        emit(AliasesLoaded(_aliases));
      } else {
        emit(AliasInitial());
      }
    }
  }

  Future<String> getOriginalUrl(String aliasId) async {
    try {
      return await _repository.getOriginalUrl(aliasId);
    } catch (e) {
      throw Exception('Erro ao buscar URL original: $e');
    }
  }
}
