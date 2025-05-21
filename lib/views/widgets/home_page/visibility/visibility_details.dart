import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/index.dart';
import 'package:weather_app/models/weather_model.dart';

class VisibillityDetailsCard extends StatelessWidget {
  const VisibillityDetailsCard({super.key, required this.weather});
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final visibilityValue = WeatherVisuals.getVisibilityValue(weather);
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
              visibilityValue,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(width: 10),
            Text('mi', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
