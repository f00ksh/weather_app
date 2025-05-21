import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/hourly_bar_chart.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';

class PrecipitationDetailsCard extends StatelessWidget {
  const PrecipitationDetailsCard({super.key, required this.weather});
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final todayTotal = weather.dailyForecast.first.precipitationSum;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Today's total section
        Text('Today\'s total', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              todayTotal?.toStringAsFixed(0) ?? '--',
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(width: 10),
            Text('in', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 20),

        // Hourly precipitation forecast using HourlyBarChart
        HourlyBarChart(
          height: 0.15,
          items:
              weather.hourlyForecast.map((hourly) {
                final timeText = WeatherVisuals.formatHour(hourly.time);
                final precipProbability = hourly.precipitation ?? 0;

                final double barHeight = WeatherVisuals.calculateBarHeight(
                  value: precipProbability,
                  minHeight: 5,
                  maxHeight: 15,
                  maxValue: 100,
                );

                return HourlyBarChartItem(
                  time: timeText,
                  value: barHeight,
                  color: Colors.blue.withValues(alpha: 0.5),
                  topIcon: WeatherVisuals.getIcon(hourly.weatherCode),
                  topLabel: '${precipProbability.round()}%',
                  bottomLabel: timeText,
                );
              }).toList(),
        ),
      ],
    );
  }
}
