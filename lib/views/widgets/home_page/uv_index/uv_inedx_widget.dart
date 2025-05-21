import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/index.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/custom_paint.dart';
import 'package:weather_app/core/theme/app_dimension.dart';

class UvIndexWidget extends StatelessWidget {
  final WeatherModel weather;

  const UvIndexWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final surfaceContainer = Theme.of(context).colorScheme.surfaceContainer;

    // Find the current hour in the hourly forecast
    final now = DateTime.now();

    // Find the current hour's UV index
    int uvIndexValue;

    final currentHourForecast = weather.hourlyForecast.firstWhere(
      (hourly) => hourly.time.hour == now.hour,
      orElse: () => weather.hourlyForecast.first,
    );
    uvIndexValue = currentHourForecast.uvIndex?.round() ?? 0;

    final category = WeatherVisuals.getUvCategory(uvIndexValue);
    final activeDotIndex = _getActiveDotIndex(uvIndexValue);

    return CustomPaint(
      painter: FlowerShapePainter(
        pointCount: 12,
        innerRadiusPercent: .87,
        cornerRadius: 20,
        color: surfaceContainer,
      ),
      child: CustomPaint(
        painter: UVIndexIndicatorPainter(selectedIndex: activeDotIndex),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.wb_sunny_outlined, size: 18),
                SizedBox(width: 8),
                Text(
                  'UV Index',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              '$uvIndexValue',
              style: TextStyle(fontSize: AppDimension.cardContentLarge),
            ),
            const SizedBox(height: 2),
            Text(
              category,
              style: TextStyle(fontSize: AppDimension.cardContentSmall),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ), // Empty container for sizing
    );
  }

  // Helper method to determine which dot should be active
  int _getActiveDotIndex(int uvIndex) {
    if (uvIndex <= 2) return 0; // Green
    if (uvIndex <= 5) return 1; // Yellow
    if (uvIndex <= 7) return 2; // Orange
    if (uvIndex <= 10) return 3; // Red
    return 4; // Purple
  }
}
