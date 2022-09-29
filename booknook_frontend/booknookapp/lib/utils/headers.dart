import 'package:dio/dio.dart';

Future<Options> headerOptions(token) async {
  return Options(headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token '
  });
}