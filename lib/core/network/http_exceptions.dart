abstract class HttpException implements Exception {
  final String message;
  final int? statusCode;

  HttpException(this.message, {this.statusCode});
}

class NetworkException extends HttpException {
  NetworkException(super.message);
}

class ServerException extends HttpException {
  final dynamic data;

  ServerException(super.message, {super.statusCode, this.data});
}
