import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/views/widgets/home_page/air_quality/air_quality_bar.dart';

class AirQualityDetailsCard extends StatelessWidget {
  const AirQualityDetailsCard({super.key, required this.weather});
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    // Assuming the weather model has an airQualityIndex property
    // If not, you'll need to add it to your model
    final int aqi =
        weather.airQualityIndex?.toInt() ??
        50; // Default to 50 if not available
    final qualityText = WeatherVisuals.getAirQualityInfo(aqi);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Condetion',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text('$aqi', style: Theme.of(context).textTheme.displayMedium),
            const SizedBox(width: 10),
            Text(qualityText, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: 8),

        // AQI visualization
        AirQualityBar(aqi: aqi),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Good', style: Theme.of(context).textTheme.bodySmall),
            Text('Hazardous', style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ],
    );
  }
}
