import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/hourly_bar_chart.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';

class HumidityDetailsCard extends StatelessWidget {
  const HumidityDetailsCard({super.key, required this.weather});
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final todayAverageHumidity =
        weather.hourlyForecast
            .map((hourly) => hourly.humidity?.round() ?? 0)
            .reduce((a, b) => a + b) /
        weather.hourlyForecast.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Current humidity section
        Text('Today Average', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todayAverageHumidity.toStringAsFixed(0),
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(width: 2),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text('%', style: Theme.of(context).textTheme.displayLarge),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Hourly humidity forecast using HourlyBarChart
        HourlyBarChart(
          height: 0.15,
          items:
              weather.hourlyForecast.map((hourly) {
                final timeText = WeatherVisuals.formatHour(hourly.time);
                final hourlyHumidity = hourly.humidity?.round() ?? 0;

                // Calculate bar height based on humidity percentage
                final double barHeight = 30 + (hourlyHumidity * 0.5);

                return HourlyBarChartItem(
                  time: timeText,
                  value: barHeight,
                  color: primary,
                  topLabel: '$hourlyHumidity%',
                  bottomLabel: timeText,
                );
              }).toList(),
        ),
      ],
    );
  }
}
