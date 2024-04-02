import 'package:dio/dio.dart';

class NotFoundFailure implements Exception {}

class RequestFailure implements Exception {}

class Handler {
  static parseResponse(Response<dynamic> response) {
    if (response.statusCode != 200) throw RequestFailure();

    final data = response.data as Map<String, dynamic>;

    if (!data.containsKey("data")) throw NotFoundFailure();

    return data['data'];
  }
}
