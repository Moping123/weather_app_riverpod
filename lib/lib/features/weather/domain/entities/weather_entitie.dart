import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final double windSpeed;
  final int humidity;

  const WeatherEntity({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.windSpeed,
    required this.humidity,
  });

  @override
  List<Object?> get props => [
    cityName,
    temperature,
    description,
    icon,
    windSpeed,
    humidity,
  ];
}
