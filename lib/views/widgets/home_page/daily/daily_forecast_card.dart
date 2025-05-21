import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/theme/app_dimension.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/core/shared/widgets/card_container.dart';

class DailyForecastCard extends ConsumerWidget {
  final WeatherModel weather;

  const DailyForecastCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final outlineVariant = Theme.of(
      context,
    ).colorScheme.outlineVariant.withValues(alpha: .5);
    final textTheme = Theme.of(context).textTheme;
    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.calendar_today, size: AppDimension.cardTitleIconSize),
              SizedBox(width: 10),
              Text('10-day forecast', style: textTheme.titleSmall),
            ],
          ),
          SizedBox(height: 15),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children:
                    weather.dailyForecast.isEmpty
                        ? [
                          _buildDailyItem(
                            'No data',
                            '--',
                            '--',
                            Icon(Icons.help_outline),
                            outlineVariant,
                            context,
                          ),
                        ]
                        : weather.dailyForecast.map((daily) {
                          final day = WeatherVisuals.getDayName(daily.date);
                          return _buildDailyItem(
                            day,
                            '${daily.maxTemperature.round()}°',
                            '${daily.minTemperature.round()}°',
                            WeatherVisuals.getIcon(
                              daily.code ?? 0,
                              isDay: true,
                              isDaily: true,
                            ),
                            outlineVariant,
                            context,
                          );
                        }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDailyItem(
    String day,
    String highTemp,
    String lowTemp,
    Widget icon,
    Color? color,
    BuildContext context,
  ) {
    final bodyMedium2 = Theme.of(context).textTheme.bodySmall;
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(highTemp, style: bodyMedium2),
              Text(lowTemp, style: bodyMedium2),
            ],
          ),
          icon,
          Text(day, style: bodyMedium2),
        ],
      ),
    );
  }
}
