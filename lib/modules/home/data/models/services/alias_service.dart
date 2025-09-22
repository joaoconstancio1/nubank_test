import 'package:dio/dio.dart';
import 'package:nubank_test/modules/home/data/models/alias_model.dart';

class AliasService {
  final Dio _dio;
  final String baseUrl;

  AliasService({
    Dio? dio,
    this.baseUrl = 'https://url-shortener-server.onrender.com/api',
  }) : _dio = dio ?? Dio();

  Future<AliasModel> createAlias(String url) async {
    final payload = {'url': url};
    try {
      final resp = await _dio.post('$baseUrl/alias', data: payload);
      if (resp.statusCode == 201 || resp.statusCode == 200) {
        return AliasModel.fromJson(resp.data as Map<String, dynamic>);
      }
      throw Exception('Erro ao encurtar a URL: HTTP ${resp.statusCode}');
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          'Erro do servidor: \n ${e.response?.statusCode} \n ${e.response?.data}',
        );
      }
      throw Exception('Erro de conexão: ${e.message}');
    }
  }
}
