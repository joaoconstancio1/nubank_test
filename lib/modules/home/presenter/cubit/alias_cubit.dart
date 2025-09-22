import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nubank_test/modules/home/data/models/services/alias_service.dart';
import 'package:nubank_test/modules/home/presenter/cubit/alias_state.dart';

class AliasCubit extends Cubit<AliasState> {
  final AliasService _service;

  AliasCubit(this._service) : super(AliasState(aliases: []));

  Future<void> shorten(String url) async {
    if (url.trim().isEmpty) return;
    emit(state.copyWith(loading: true, error: null));
    try {
      final alias = await _service.createAlias(url);
      final newList = [alias, ...state.aliases];
      emit(state.copyWith(aliases: newList, loading: false));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void clearError() => emit(state.copyWith(error: null));
}
