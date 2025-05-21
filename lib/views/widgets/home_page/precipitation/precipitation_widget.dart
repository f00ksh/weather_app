import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/core/theme/index.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/card_container.dart';
import 'package:weather_app/core/theme/app_dimension.dart';

class PrecipitationWidget extends StatelessWidget {
  final WeatherModel weather;

  const PrecipitationWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final titleMedium2 = Theme.of(context).textTheme.titleMedium;
    final precipitationValue = WeatherVisuals.formatPrecipitation(
      weather.precipitation,
    );
    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.water_drop, size: AppDimension.cardTitleIconSize),
              const SizedBox(width: 10),
              Text('Precipitation', style: titleMedium2),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                precipitationValue,
                style: TextStyle(fontSize: AppDimension.cardContentLarge),
              ),
              Text(
                'in',
                style: TextStyle(fontSize: AppDimension.cardContentMedium),
              ),
            ],
          ),

          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total rain\nfor the day',
                style: TextStyle(fontSize: AppDimension.cardContentSmall),
              ),
              SvgPicture.asset(
                'assets/icons/heavy_rain.svg',
                width: AppDimension.cardSvgSize,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
