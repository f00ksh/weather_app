import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/card_container.dart';
import 'package:weather_app/core/shared/widgets/custom_paint.dart';
import 'package:weather_app/core/theme/app_dimension.dart';

class VisibilityWidget extends StatelessWidget {
  final WeatherModel weather;

  const VisibilityWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final tertiaryContainer = Theme.of(context).colorScheme.tertiaryContainer;
    final onTertiaryContainer =
        Theme.of(context).colorScheme.onTertiaryContainer;
    // Get the current visibility value
    final visibilityValue = WeatherVisuals.getVisibilityValue(weather);

    return RoundCardContainer(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: CustomPaint(
          painter: FlowerShapePainter(
            pointCount: 18,
            innerRadiusPercent: .9,
            cornerRadius: 20,
            color: tertiaryContainer,
            // Pass visibility value
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.visibility_outlined,
                    size: AppDimension.cardTitleIconSize,
                    color: onTertiaryContainer,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Visibility',
                    style: TextStyle(
                      color: onTertiaryContainer,
                      fontSize: AppDimension.cardContentSmall,
                    ),
                  ),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    visibilityValue,
                    style: TextStyle(
                      fontSize: AppDimension.cardContentLarge,
                      color: onTertiaryContainer,
                    ),
                  ),
                  Text(
                    ' mi',
                    style: TextStyle(fontSize: 24, color: onTertiaryContainer),
                  ),
                ],
              ),

              Text(
                WeatherVisuals.getVisibilityDescription(
                  double.tryParse(visibilityValue) ?? 0,
                ),
                style: TextStyle(
                  fontSize: AppDimension.cardContentSmall - 3,
                  color: onTertiaryContainer,
                ),
              ),
              const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
