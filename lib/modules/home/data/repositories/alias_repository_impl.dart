import 'package:nubank_test/modules/home/data/models/alias_model.dart';
import 'package:nubank_test/modules/home/data/services/alias_service.dart';
import 'package:nubank_test/modules/home/domain/repositories/alias_repository.dart';

class AliasRepositoryImpl implements AliasRepository {
  final AliasService service;

  AliasRepositoryImpl(this.service);

  @override
  Future<AliasModel> createAlias(String url) {
    return service.createAlias(url);
  }
}
