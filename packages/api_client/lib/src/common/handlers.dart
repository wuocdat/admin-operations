import 'package:dio/dio.dart';

class NotFoundFailure implements Exception {}

class RequestFailure implements Exception {}

class Handler {
  static Map<String, dynamic> parseResponse(Response<dynamic> response) {
    if (response.statusCode != 200) throw RequestFailure();

    final data = response.data as Map<String, dynamic>;

    if (!data.containsKey("data")) throw NotFoundFailure();

    final result = data['data'] as Map<String, dynamic>;

    return result;
  }
}
