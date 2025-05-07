import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/models/forecast_entry.dart';
import 'package:weather_app/viewmodels/weather_services_provider.dart';

class ForecastList extends ConsumerWidget {
  final String city;

  const ForecastList({required this.city, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecastAsync = ref.watch(forecastProvider(city));

    return forecastAsync.when(
      data: (forecastEntries) => _buildForecastList(forecastEntries),
      loading: () => const Center(child: CircularProgressIndicator()),
      error:
          (error, _) => Center(
            child: Text(
              'Error loading forecast: $error',
              style: const TextStyle(color: Colors.red),
            ),
          ),
    );
  }

  Widget _buildForecastList(List<ForecastEntry> forecastEntries) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        itemCount: forecastEntries.length,
        itemBuilder: (context, index) {
          final forecast = forecastEntries[index];
          return _buildForecastCard(forecast);
        },
      ),
    );
  }

  Widget _buildForecastCard(ForecastEntry forecast) {
    // Format the date
    final dateFormat = DateFormat('E, MMM d');
    final timeFormat = DateFormat('h a');
    final formattedDate = dateFormat.format(forecast.timestamp);
    final formattedTime = timeFormat.format(forecast.timestamp);

    return ListTile(
      title: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(formattedTime, style: const TextStyle(fontSize: 12)),
              const SizedBox(height: 8),
              Image.network(
                'https://openweathermap.org/img/wn/${forecast.icon}.png',
                width: 40,
                height: 40,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported, size: 40),
              ),
              const SizedBox(height: 4),
              Text(
                '${forecast.temp.toStringAsFixed(1)}°C',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
