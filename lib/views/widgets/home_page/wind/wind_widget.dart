import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/custom_paint.dart';
import 'dart:math' as math;

import 'package:weather_app/core/theme/app_dimension.dart';

class WindWidget extends StatelessWidget {
  final WeatherModel weather;

  const WindWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final surfaceContainer = Theme.of(context).colorScheme.surfaceContainer;

    // Get wind direction in degrees (default to 90 for East if not available)
    final windDirection = weather.windDirection;

    // Calculate rotation angle in radians
    // Add 90 degrees to make the arrow point where the wind is going
    // Convert to radians for the Transform.rotate widget
    final rotationAngle = (windDirection + 90) * (math.pi / 180);

    // Get cardinal direction text
    final directionText = WeatherVisuals.getWindDirectionText(windDirection);

    return CustomPaint(
      painter: FlowerShapePainter(
        pointCount: 25,
        innerRadiusPercent: .95,
        cornerRadius: 20,
        color: surfaceContainer,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Position the arrow with a slight offset to the right to account for SVG centering issues
          Positioned(
            child: Transform.rotate(
              angle: rotationAngle,
              alignment: Alignment.center,
              child: SizedBox(
                // Make the arrow slightly bigger than the defined size
                width: AppDimension.windArrowSvgSize * 1.15,
                height: AppDimension.windArrowSvgSize * 1.15,
                child: Padding(
                  // Add a slight padding to shift the arrow right for better centering
                  padding: EdgeInsets.only(left: 25.0),
                  child: SvgPicture.asset(
                    'assets/icons/arrow.svg',
                    fit: BoxFit.contain,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.secondaryContainer,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Content
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.air, size: AppDimension.cardTitleIconSize),
                  const SizedBox(width: 10),
                  Text(
                    'Wind',
                    style: TextStyle(fontSize: AppDimension.cardContentSmall),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weather.windSpeed.toStringAsFixed(0),
                    style: TextStyle(fontSize: AppDimension.cardContentLarge),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    ' mph',
                    style: TextStyle(fontSize: AppDimension.cardContentSmall),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'From $directionText',
                style: TextStyle(fontSize: AppDimension.cardContentSmall),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
