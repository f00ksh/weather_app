import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/weather_icons.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';

class WeatherLocationTile extends StatelessWidget {
  final String locationName;
  final int weatherCode;
  final bool isDay;
  final double temperature;
  final VoidCallback onTap;
  final BorderRadius borderRadius;

  const WeatherLocationTile({
    super.key,
    required this.locationName,
    required this.weatherCode,
    required this.isDay,
    required this.temperature,
    required this.onTap,
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).colorScheme.secondaryContainer.withValues(alpha: .9),
          borderRadius: borderRadius,
        ),

        child: Row(
          children: [
            // Weather icon
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(4),
              child: WeatherIcons.getIcon(weatherCode, isDay: isDay),
            ),

            const SizedBox(width: 16),

            // Location name and weather description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    locationName,
                    style: Theme.of(context).textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    WeatherVisuals.getDescription(weatherCode),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Temperature
            Text(
              '${temperature.round()}°',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }

  // Factory constructor for loading state
  factory WeatherLocationTile.loading({
    required VoidCallback onTap,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(28)),
  }) {
    return WeatherLocationTile(
      locationName: 'Loading...',
      weatherCode: 0,
      isDay: true,
      temperature: 0,
      onTap: onTap,
      borderRadius: borderRadius,
    );
  }

  // Factory constructor for error state
  factory WeatherLocationTile.error({
    required String locationName,
    required VoidCallback onTap,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(28)),
  }) {
    return WeatherLocationTile(
      locationName: locationName,
      weatherCode: 0,
      isDay: true,
      temperature: 0,
      onTap: onTap,
      borderRadius: borderRadius,
    );
  }
}
