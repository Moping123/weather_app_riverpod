import 'package:get_it/get_it.dart';

import '../features/weather/data/datasource/weathera_remote_datasource.dart';
import '../features/weather/data/repositories/weather_repo_imp.dart';
import '../features/weather/domain/repositories/weather_repo.dart';
import '../features/weather/domain/usecases/get_weather_usecase.dart';

import 'networks/dio_client.dart';

final sl = GetIt.instance;

void init() {
  // BLoC

  // UseCase
  sl.registerLazySingleton(() => GetWeatherUseCase(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(sl()),
  );

  // DataSource
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(sl()),
  );

  // DioClient
  sl.registerLazySingleton(() => DioClient());
}
