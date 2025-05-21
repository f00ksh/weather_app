import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/weather_details_text.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/views/pages/weather_detail_page.dart';
import 'package:weather_app/views/widgets/home_page/pressure/pressure_details.dart';
import 'package:weather_app/views/widgets/home_page/sunrise_sunset/sun_times_row.dart';
import 'package:weather_app/views/widgets/home_page/visibility/visibility_details.dart';
import 'package:weather_app/views/widgets/home_page/wind/wind_details.dart';
import 'package:weather_app/views/widgets/home_page/humidity/humidity_details.dart';
import 'package:weather_app/views/widgets/home_page/uv_index/uv_index_details.dart';
import 'package:weather_app/views/widgets/home_page/precipitation/precipitation_details.dart';
import 'package:weather_app/views/widgets/home_page/sunrise_sunset/sunrise_sunset_details.dart';
import 'package:weather_app/views/widgets/home_page/air_quality/air_quality_details.dart';

enum WeatherDetailType {
  wind,
  pressure,
  visibility,
  uvIndex,
  precipitation,
  humidity,
  sunriseSunset,
  airQuality,
}

class WeatherDetailFactory {
  static WeatherDetailPage createDetailPage(
    WeatherDetailType type,
    WeatherModel weather,
  ) {
    switch (type) {
      case WeatherDetailType.wind:
        return WeatherDetailPage(
          title: 'Wind',
          icon: Icons.air,
          weather: weather,
          buildVisualization: WindDetailsCard(weather: weather),
          info: DetailsText.wind,
        );
      case WeatherDetailType.pressure:
        return WeatherDetailPage(
          title: 'Pressure',
          icon: Icons.compress,
          weather: weather,
          buildVisualization: PressureDetailsCard(weather: weather),
          info: DetailsText.pressure,
        );
      case WeatherDetailType.visibility:
        return WeatherDetailPage(
          title: 'Visibility',
          icon: Icons.visibility,
          weather: weather,
          buildVisualization: VisibillityDetailsCard(weather: weather),
          info: DetailsText.visibility,
        );
      case WeatherDetailType.uvIndex:
        return WeatherDetailPage(
          title: 'UV Index',
          icon: Icons.wb_sunny,
          weather: weather,
          buildVisualization: UVIndexDetailsCard(weather: weather),
          info: DetailsText.uvIndex,
        );
      case WeatherDetailType.precipitation:
        return WeatherDetailPage(
          title: 'Precipitation',
          icon: Icons.water_drop,
          weather: weather,
          buildVisualization: PrecipitationDetailsCard(weather: weather),
          info: DetailsText.precipitation,
        );
      case WeatherDetailType.humidity:
        return WeatherDetailPage(
          title: 'Humidity',
          icon: Icons.water_drop,
          weather: weather,
          buildVisualization: HumidityDetailsCard(weather: weather),
          info: DetailsText.humidity,
        );
      case WeatherDetailType.sunriseSunset:
        return WeatherDetailPage(
          title: 'Sunrise and Sunset',
          icon: Icons.sunny,
          weather: weather,
          buildVisualization: SunriseSunsetDetailsCard(weather: weather),
          info: DetailsText.sunriseSunset,
          padding: EdgeInsets.all(0),
          infoRow: SunTimesRow(
            sunriseDateTime: weather.dailyForecast[0].sunrise,
            sunsetDateTime: weather.dailyForecast[0].sunset,
          ),
        );
      case WeatherDetailType.airQuality:
        return WeatherDetailPage(
          title: 'Air Quality',
          icon: Icons.air,
          weather: weather,
          buildVisualization: AirQualityDetailsCard(weather: weather),
          info: DetailsText.airQuality,
        );
    }
  }
}
