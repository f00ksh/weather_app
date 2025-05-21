import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/models/weather_model.dart';

import 'package:weather_app/core/shared/widgets/card_container.dart';
import 'package:weather_app/core/shared/widgets/custom_paint.dart';
import 'package:weather_app/core/theme/app_dimension.dart';

class SunriseSunsetWidget extends StatelessWidget {
  final WeatherModel? weather;

  const SunriseSunsetWidget({super.key, this.weather});

  // Helper method _parseTimeString is no longer needed as we work with DateTime directly

  @override
  Widget build(BuildContext context) {
    final surfaceContainer = Theme.of(context).colorScheme.surfaceContainer;
    final primaryColor = Theme.of(context).colorScheme.primary;
    // Directly use DateTime objects from the weather model
    final DateTime? sunriseDateTime = weather!.dailyForecast[0].sunrise;

    final DateTime? sunsetDateTime = weather!.dailyForecast[0].sunset;

    // Format DateTime objects for display, with fallback
    final sunriseString = WeatherVisuals.formatSunTime(sunriseDateTime);
    final sunsetString = WeatherVisuals.formatSunTime(sunsetDateTime);

    // Current time as DateTime for the painter
    final DateTime currentTime = DateTime.now();

    return CardContainer(
      padding: EdgeInsets.all(0),
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: CustomPaint(
                painter: SunriseSunset(
                  waveColor: primaryColor,
                  currentTime: currentTime,
                  sunriseTime: sunriseDateTime,
                  sunsetTime: sunsetDateTime,
                  mHeight: .31,
                ),
              ),
            ),
          ),

          // Semi-transparent grey rectangle (middle layer)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height:
                AppDimension.nightHight, // Fixed height for the bottom section
            child: Container(
              decoration: BoxDecoration(
                color: surfaceContainer.withValues(alpha: 0.65),
                border: Border(
                  top: BorderSide(width: 2, color: Colors.grey[400]!),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(26),
                  bottomRight: Radius.circular(26),
                ),
              ),
            ),
          ),

          // Content layer (top layer)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header Section
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.wb_sunny,
                        size: AppDimension.cardTitleIconSize,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Sunrise & sunset',
                        style: TextStyle(
                          fontSize: AppDimension.cardContentSmall,
                        ),
                      ),
                    ],
                  ),

                  // Time Display
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Sunrise Time
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.wb_sunny_outlined,
                            size: AppDimension.cardTitleIconSize,
                          ),
                          SizedBox(width: 8),
                          Text(
                            sunriseString, // Use the formatted string
                            style: TextStyle(
                              fontSize: AppDimension.cardContentMedium - 5,
                            ),
                          ),
                        ],
                      ),

                      // Sunset Time
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.nightlight_outlined,

                            size: AppDimension.cardTitleIconSize,
                          ),
                          SizedBox(width: 8),
                          Text(
                            sunsetString, // Use the formatted string
                            style: TextStyle(
                              fontSize: AppDimension.cardContentMedium - 5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
