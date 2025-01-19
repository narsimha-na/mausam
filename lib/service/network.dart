import 'package:dio/dio.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  final Dio _dio = Dio();

  factory NetworkService() {
    return _instance;
  }

  NetworkService._internal();

  Future<Response> get(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.get(url, queryParameters: queryParameters);
  }

  Future<Response> post(String url,
      {Map<String, dynamic>? queryParameters}) async {
    return await _dio.post(url, queryParameters: queryParameters);
  }
}
