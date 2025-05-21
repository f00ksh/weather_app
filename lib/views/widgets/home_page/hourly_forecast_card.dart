import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/shared/widgets/custom_paint.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/core/shared/widgets/card_container.dart';

class HourlyForecastCard extends StatelessWidget {
  final WeatherModel weather;

  const HourlyForecastCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          const Row(
            children: [
              Icon(Icons.access_time, size: 18),
              SizedBox(width: 8),
              Text(
                'Hourly forecast',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 15),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children:
                  weather.hourlyForecast.map((hourly) {
                    final isNow = hourly.time.hour == DateTime.now().hour;
                    // Convert to 12-hour format with AM/PM
                    final timeText = WeatherVisuals.formatHour(hourly.time);
                    return _buildHourlyItem(
                      timeText,
                      '${hourly.temperature.round()}°',
                      WeatherVisuals.getIcon(
                        hourly.weatherCode,
                        isDay: hourly.isDay!,
                      ),
                      isNow ? Theme.of(context).colorScheme.primary : null,

                      isNow ? Theme.of(context).colorScheme.onPrimary : null,
                    );
                  }).toList(),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _buildHourlyItem(
    String time,
    String temp,
    Widget icon,
    Color? color,
    Color? textColor,
  ) {
    return Container(
      height: 120,
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomPaint(
            size: const Size(50, 50),
            painter: FlowerShapePainter(
              pointCount: 8,
              cornerRadius: 30,
              innerRadiusPercent: .8,
              color: color ?? Colors.transparent,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                temp,
                style: TextStyle(fontWeight: FontWeight.bold, color: textColor),
              ),
            ),
          ),
          icon,
          Text(time, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
