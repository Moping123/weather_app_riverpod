import 'package:dartz/dartz.dart';
import '../../../../core/error/falure.dart';

import '../entities/weather_entitie.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName);
}
