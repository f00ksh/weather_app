import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/index.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/card_container.dart';
import 'package:weather_app/core/theme/app_dimension.dart';
import 'air_quality_bar.dart'; // Import the new widget

class AirQualityWidget extends StatelessWidget {
  final WeatherModel weather;

  const AirQualityWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    // Get AQI value and determine quality level and color
    final aqi = weather.airQualityIndex!.round();
    final qualityText = WeatherVisuals.getAirQualityInfo(aqi);

    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.waves_outlined, size: AppDimension.cardTitleIconSize),
              const SizedBox(
                width: 10,
              ), // Add some spacing between the icon and text
              Text(
                'Air quality',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: AppDimension.cardContentSmall,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '$aqi',
            style: TextStyle(fontSize: AppDimension.cardContentLarge),
          ),
          const Spacer(),

          AirQualityBar(aqi: aqi),
          const Spacer(),
          Text(
            qualityText,
            style: TextStyle(fontSize: AppDimension.cardContentSmall),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
