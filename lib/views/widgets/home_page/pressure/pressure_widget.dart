import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/card_container.dart';
import 'package:weather_app/core/shared/widgets/custom_paint.dart';
import 'package:weather_app/core/theme/app_dimension.dart';

class PressureWidget extends StatelessWidget {
  final WeatherModel weather;

  const PressureWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    final double pressureValue = WeatherVisuals.calculatePressure(
      weather.pressure,
    );

    // Convert hPa to inHg and format with 2 decimal places
    final double inHg = weather.pressure * 0.02953;
    final String pressureText = inHg.toStringAsFixed(2);

    return RoundCardContainer(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomPaint(
          painter: PressureGaugePainter(
            value: pressureValue,
            backgroundColor: Colors.grey.shade300,
            foregroundColor: primary,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.speed, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Pressure',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pressureText,
                    style: TextStyle(
                      fontSize: AppDimension.cardContentMedium + 10,
                    ),
                  ),
                  Text('inHg', style: TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
