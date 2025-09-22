import 'package:nubank_test/modules/home/data/models/alias_model.dart';

abstract class AliasRepository {
  Future<AliasModel> createAlias(String url);
}
