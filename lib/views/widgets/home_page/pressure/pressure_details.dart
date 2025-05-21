import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/index.dart';
import 'package:weather_app/models/weather_model.dart';

class PressureDetailsCard extends StatelessWidget {
  const PressureDetailsCard({super.key, required this.weather});
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final double pressureValue = WeatherVisuals.calculatePressure(
      weather.pressure,
    );
    // Convert hPa to inHg and format with 2 decimal places
    final double inHg = weather.pressure * 0.02953;
    final String pressureText = inHg.toStringAsFixed(2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Current Condition',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              pressureText,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(width: 10),
            Text('inHg', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          backgroundColor: primary.withValues(alpha: 0.2),
          value: pressureValue, // Assuming range 29-31 inHg
          minHeight: 20,
          borderRadius: BorderRadius.circular(20),
          valueColor: AlwaysStoppedAnimation<Color>(primary),
        ),
      ],
    );
  }
}
