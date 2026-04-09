import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app_riverpod/lib/features/weather/data/datasource/weathera_remote_datasource.dart';
import 'package:weather_app_riverpod/lib/features/weather/presentation/bloc/weather_state.dart';

import '../../../../core/error/falure.dart';
import '../../../../core/networks/dio_client.dart';
import '../../data/repositories/weather_repo_imp.dart';
import '../../domain/entities/weather_entitie.dart';
import '../../domain/usecases/get_weather_usecase.dart';

final dioClientProvider = Provider((ref) => DioClient());
final remoteDatasourceProvider = Provider(
  (ref) => WeatherRemoteDataSourceImpl(ref.watch(dioClientProvider)),
);
final weatherRepository = Provider(
  (ref) => WeatherRepositoryImpl(ref.watch(remoteDatasourceProvider)),
);
final getWeatherUsecase = Provider(
  (ref) => GetWeatherUseCase(ref.watch(weatherRepository)),
);

class WeatherNotifier extends StateNotifier<WeatherState> {
  final GetWeatherUseCase getWeatherUsecase;

  WeatherNotifier(this.getWeatherUsecase) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    if (cityName.trim().isEmpty) return;
    state = WeatherLoading();
    final weather = await getWeatherUsecase(cityName);
    weather.fold(
      (failure) => state = WeatherError((failure as Failure).message),
      (weather) => state = WeatherLoaded(weather as WeatherEntity),
    );
  }
}

// ناقص الـ weatherProvider نفسه!
final weatherProvider = StateNotifierProvider<WeatherNotifier, WeatherState>(
  (ref) => WeatherNotifier(ref.watch(getWeatherUsecase)),
);
