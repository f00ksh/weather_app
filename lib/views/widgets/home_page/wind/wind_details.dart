import 'package:flutter/material.dart';
import 'package:weather_app/core/shared/widgets/hourly_bar_chart.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/models/weather_model.dart';

class WindDetailsCard extends StatelessWidget {
  const WindDetailsCard({super.key, required this.weather});

  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    final String todayHighestWind =
        weather.dailyForecast[0].windSpeedMaxDaily?.toStringAsFixed(0) ?? '10';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today's high", style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              todayHighestWind,
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(width: 8),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'mph',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        HourlyBarChart(
          height: 0.15,
          items:
              weather.hourlyForecast.map((hourly) {
                final timeText = WeatherVisuals.formatHour(hourly.time);
                final directionText = WeatherVisuals.getWindDirectionText(
                  hourly.windDirection ?? 0,
                );
                final windSpeed = hourly.windSpeed ?? 0;
                final double containerHeight =
                    WeatherVisuals.calculateBarHeight(
                      value: windSpeed,
                      minHeight: 30,
                      maxHeight: 80,
                      maxValue: 30,
                    );

                return HourlyBarChartItem(
                  time: timeText,
                  value: containerHeight,
                  color: primary,
                  topLabel: directionText,
                  bottomLabel: '${windSpeed.toStringAsFixed(0)}\n$timeText',
                );
              }).toList(),
        ),
      ],
    );
  }
}
