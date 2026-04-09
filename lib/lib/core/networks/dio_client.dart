import 'package:dio/dio.dart';

class DioClient {
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/';
  static const String _apiKey = 'f7d3732ada5531b7496e59a97b5ab027';

  final Dio _dio;

  DioClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          queryParameters: {'appid': _apiKey, 'units': 'metric', 'lang': 'ar'},
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

  Dio get dio => _dio;
}
