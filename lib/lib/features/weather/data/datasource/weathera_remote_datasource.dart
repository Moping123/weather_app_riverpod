import 'package:dio/dio.dart';

import '../../../../core/error/exception.dart';

import '../../../../core/networks/dio_client.dart';
import '../models/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(String cityName);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final DioClient dioClient;

  WeatherRemoteDataSourceImpl(this.dioClient);

  @override
  Future<WeatherModel> getWeather(String cityName) async {
    try {
      final response = await dioClient.dio.get(
        'weather',
        queryParameters: {'q': cityName},
      );
      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw ServerException(message: 'المدينة مش موجودة');
      } else if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw ServerException(message: 'تأكد من اتصالك بالانترنت');
      }
      throw ServerException(message: 'حدث خطأ غير متوقع');
    }
  }
}
