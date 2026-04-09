import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/falure.dart';
import '../../domain/entities/weather_entitie.dart';
import '../../domain/repositories/weather_repo.dart';
import '../datasource/weathera_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, WeatherEntity>> getWeather(String cityName) async {
    try {
      final weather = await remoteDataSource.getWeather(cityName);
      return Right(weather);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
