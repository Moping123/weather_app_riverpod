import 'package:dartz/dartz.dart';

import '../../../../core/error/falure.dart';
import '../entities/weather_entitie.dart';
import '../repositories/weather_repo.dart';

class GetWeatherUseCase {
  final WeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<Either<Failure, WeatherEntity>> call(String cityName) async {
    return await repository.getWeather(cityName);
  }
}
