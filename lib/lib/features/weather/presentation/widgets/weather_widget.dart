import 'package:flutter/material.dart';
import '../../domain/entities/weather_entitie.dart';

class WeatherWidget extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            weather.cityName,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Image.network(
            'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
          ),
          const SizedBox(height: 8),
          Text(
            '${weather.temperature}°C',
            style: const TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 8),
          Text(weather.description, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _InfoCard(
                icon: Icons.water_drop,
                label: 'الرطوبة',
                value: '${weather.humidity}%',
              ),
              _InfoCard(
                icon: Icons.air,
                label: 'الرياح',
                value: '${weather.windSpeed} m/s',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 4),
        Text(label),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
