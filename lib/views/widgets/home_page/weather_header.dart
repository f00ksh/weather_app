import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/views/widgets/home_page/hourly_forecast_card.dart';

class WeatherHeader extends StatelessWidget {
  final WeatherModel weather;
  final bool isTabletLayout;

  const WeatherHeader({
    super.key,
    required this.weather,
    this.isTabletLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isTabletLayout) {
      return SliverToBoxAdapter(
        child: _buildHeaderContent(context, isTablet: true),
      );
    } else {
      return SliverAppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        expandedHeight: 350,
        flexibleSpace: _buildHeaderContent(context),
      );
    }
  }

  Widget _buildHeaderContent(BuildContext context, {bool isTablet = false}) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: isTablet ? 20 : 30),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Text(
            WeatherVisuals.getDescription(weather.weatherCode),
            style: const TextStyle(fontSize: 16),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${weather.temperature.round()}°',
                style: TextStyle(
                  fontSize: isTablet ? 150 : 130,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              WeatherVisuals.getIcon(
                weather.weatherCode,
                isDay: weather.isDay,
                isHeader: true,
              ),
            ],
          ),
          Text(
            'Feels like ${weather.feelsLike.round()}°',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            'High ${weather.dailyForecast[0].maxTemperature.round()}° · Low ${weather.dailyForecast[0].minTemperature.round()}°',
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 20),
          if (isTablet)
            Padding(
              padding: const EdgeInsets.all(16),
              child: HourlyForecastCard(weather: weather),
            ),
        ],
      ),
    );
  }
}
