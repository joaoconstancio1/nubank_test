import 'package:dio/dio.dart';
import 'package:nubank_test/core/network/custom_http_client.dart';
import 'package:nubank_test/core/utils/constants.dart';

class DioHttpClient implements CustomHttpClient {
  DioHttpClient({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: Constants.baseUrl));

  final Dio _dio;

  @override
  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.get(path, queryParameters: queryParameters);

    return response.data as Map<String, dynamic>;
  }

  @override
  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
    );

    return response.data as Map<String, dynamic>;
  }
}
