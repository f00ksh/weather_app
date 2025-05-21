import 'package:flutter/material.dart';
import 'package:weather_app/core/shared/widgets/custom_paint.dart';
import 'package:weather_app/models/weather_model.dart';

class SunriseSunsetDetailsCard extends StatelessWidget {
  const SunriseSunsetDetailsCard({super.key, required this.weather});
  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceContainer = Theme.of(context).colorScheme.surfaceContainer;
    final DateTime? sunriseDateTime = weather.dailyForecast[0].sunrise;
    final DateTime? sunsetDateTime = weather.dailyForecast[0].sunset;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: CustomPaint(
                painter: SunriseSunset(
                  waveColor: primaryColor,
                  currentTime: DateTime.now(),
                  sunriseTime: sunriseDateTime,
                  sunsetTime: sunsetDateTime,
                  mHeight: .4,
                ),
                child: SizedBox(height: 200, width: double.infinity),
              ),
            ),
            // Semi-transparent grey rectangle (middle layer)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 90, // Fixed height for the bottom section
              child: Container(
                decoration: BoxDecoration(
                  color: surfaceContainer.withValues(alpha: 0.65),
                  border: Border(
                    top: BorderSide(width: 2, color: Colors.grey[500]!),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(26),
                    bottomRight: Radius.circular(26),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
