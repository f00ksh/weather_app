import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';

class SunTimesRow extends StatelessWidget {
  const SunTimesRow({
    super.key,
    required this.sunriseDateTime,
    required this.sunsetDateTime,
  });

  final DateTime? sunriseDateTime;
  final DateTime? sunsetDateTime;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final titleMedium = Theme.of(context).textTheme.titleMedium;
    final titleSmall = Theme.of(context).textTheme.titleSmall;
    // Calculate dawn time (26 minutes before sunrise)
    final DateTime? dawnDateTime = sunriseDateTime?.subtract(
      const Duration(minutes: 26),
    );
    // Calculate dusk time (26 minutes after sunset)
    final DateTime? duskDateTime = sunsetDateTime?.add(
      const Duration(minutes: 26),
    );

    final sunriseString = WeatherVisuals.formatSunTime(sunriseDateTime);
    final sunsetString = WeatherVisuals.formatSunTime(sunsetDateTime);
    final dawnString = WeatherVisuals.formatSunTime(dawnDateTime);
    final duskString = WeatherVisuals.formatSunTime(duskDateTime);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Dawn', style: titleSmall?.copyWith(color: primaryColor)),
            Text(dawnString, style: titleMedium?.copyWith(color: primaryColor)),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Sunrise', style: titleSmall?.copyWith(color: primaryColor)),
            Text(
              sunriseString,
              style: titleMedium?.copyWith(color: primaryColor),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Sunset', style: titleSmall),
            Text(sunsetString, style: titleMedium),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Dusk', style: titleSmall),
            Text(duskString, style: titleMedium),
          ],
        ),
      ],
    );
  }
}
