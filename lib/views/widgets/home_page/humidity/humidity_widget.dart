import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/custom_paint.dart';
import 'package:weather_app/core/theme/app_dimension.dart';

class HumidityWidget extends StatelessWidget {
  final WeatherModel weather;

  const HumidityWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final tertiaryContainer = Theme.of(context).colorScheme.tertiaryContainer;
    final tertiaryFixed = Theme.of(context).colorScheme.tertiaryFixed;
    final surfaceContainer = Theme.of(context).colorScheme.surfaceContainer;
    final onTertiaryFixed = Theme.of(context).colorScheme.onTertiaryFixed;
    // Calculate dew point (this is a simplified calculation)
    final dewPoint =
        (weather.temperature - ((100 - weather.humidity) / 5)).round();
    final currentHumidity = weather.humidity.round();
    return Container(
      width: double.infinity,
      margin: AppDimension.cardMargin,
      padding: EdgeInsets.only(top: 10),

      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(26),
      ),

      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
        child: CustomPaint(
          painter: WavePainter(
            waveColor: tertiaryContainer,
            fillPercent: weather.humidity / 100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.water_drop,
                      size: AppDimension.cardTitleIconSize,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Humidity',
                      style: TextStyle(fontSize: AppDimension.cardContentSmall),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  '$currentHumidity%',
                  style: TextStyle(fontSize: AppDimension.cardContentLarge),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: tertiaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$dewPoint°',
                    style: TextStyle(
                      fontSize: AppDimension.cardContentSmall,
                      color: onTertiaryFixed,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
