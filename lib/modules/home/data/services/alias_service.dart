import 'package:nubank_test/core/network/http_exceptions.dart';
import 'package:nubank_test/core/network/custom_http_client.dart';
import 'package:nubank_test/core/network/dio_http_client.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';

abstract class AliasService {
  Future<AliasModel> createAlias(String url);
  Future<String> getOriginalUrl(String aliasId);
}

class AliasServiceImpl implements AliasService {
  final CustomHttpClient _client;

  AliasServiceImpl({CustomHttpClient? client})
    : _client = client ?? DioHttpClient();

  @override
  Future<AliasModel> createAlias(String url) async {
    final payload = {'url': url};
    try {
      final responseData = await _client.post('/alias', data: payload);
      return AliasModel.fromJson(responseData);
    } on ServerException catch (e) {
      throw Exception('Erro do servidor: ${e.statusCode} - ${e.message}');
    } on NetworkException catch (e) {
      throw Exception('Erro de conexão: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }

  @override
  Future<String> getOriginalUrl(String aliasId) async {
    try {
      final responseData = await _client.get('/alias/$aliasId');
      return responseData['url'] as String;
    } on ServerException catch (e) {
      if (e.statusCode == 404) {
        throw Exception('Alias não encontrado');
      }
      throw Exception('Erro do servidor: ${e.statusCode} - ${e.message}');
    } on NetworkException catch (e) {
      throw Exception('Erro de conexão: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }
}
