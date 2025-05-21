import 'package:flutter/material.dart';
import 'package:weather_app/core/shared/widgets/hourly_bar_chart.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';

class UVIndexDetailsCard extends StatelessWidget {
  const UVIndexDetailsCard({super.key, required this.weather});
  final WeatherModel weather;

  // Helper method to get color based on UV index
  Color _getUVColor(int uvIndex) {
    if (uvIndex <= 2) return Colors.green;
    if (uvIndex <= 5) return Colors.yellow;
    if (uvIndex <= 7) return Colors.orange;
    if (uvIndex <= 10) return Colors.red;
    return Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    final uvIndexMax = weather.dailyForecast[0].uvIndexMax?.round() ?? 0;
    final category = WeatherVisuals.getUvCategory(uvIndexMax);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Today's high", style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              uvIndexMax.toString(),
              style: Theme.of(context).textTheme.displayLarge,
            ),
            const SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                category,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),

        // UV Index hourly visualization
        HourlyBarChart(
          items:
              weather.hourlyForecast.map((hourly) {
                final timeText = WeatherVisuals.formatHour(hourly.time);
                final hourlyUvIndex = hourly.uvIndex?.round() ?? 0;
                final Color uvColor = _getUVColor(hourlyUvIndex);
                final double containerHeight =
                    WeatherVisuals.calculateBarHeight(
                      value: hourlyUvIndex.toDouble(),
                      minHeight: 5,
                      maxHeight: 100,
                      maxValue: 11,
                    );

                return HourlyBarChartItem(
                  time: timeText,
                  value: containerHeight,
                  color: uvColor,
                  topLabel: '$hourlyUvIndex',
                  icon: WeatherVisuals.getIcon(hourly.weatherCode),
                  bottomLabel: timeText,
                );
              }).toList(),
        ),
      ],
    );
  }
}
