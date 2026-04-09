import 'package:flutter/material.dart';

import '../bloc/weather_provider.dart';
import '../bloc/weather_events.dart';
import '../bloc/weather_state.dart';
import '../widgets/weather_widget.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherPage extends ConsumerStatefulWidget {
  const WeatherPage({super.key});

  @override
  ConsumerState<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends ConsumerState<WeatherPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(weatherProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('تطبيق الطقس')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'ادخل اسم المدينة',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    ref
                        .read(weatherProvider.notifier)
                        .getWeather(_controller.text);
                  },
                  child: const Text('بحث'),
                ),
              ],
            ),
          ),
          if (state is WeatherInitial)
            const Center(child: Text('ابحث عن مدينة')),
          if (state is WeatherLoading)
            const Center(child: CircularProgressIndicator()),
          if (state is WeatherLoaded) WeatherWidget(weather: state.weather),
          if (state is WeatherError) Center(child: Text(state.message)),
        ],
      ),
    );
  }
}
