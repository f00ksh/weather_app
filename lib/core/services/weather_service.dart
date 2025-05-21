import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/models/weather_exception.dart';
import 'package:weather_app/models/weather_model.dart';

part 'weather_service.g.dart';

// Provider for the WeatherService
@riverpod
WeatherService weatherService(Ref ref) {
  return WeatherService();
}

// Implementation of the WeatherService from open_meteo
class WeatherService {
  final _weather = WeatherApi();
  final _airQuality = AirQualityApi();

  Future<WeatherModel> getWeatherData(
    double latitude,
    double longitude,
    String cityName,
  ) async {
    try {
      // Fetch weather data
      final weatherData = await _fetchFromApi(latitude, longitude);

      // Fetch air quality data
      ApiResponse<AirQualityApi>? airQualityData;
      try {
        airQualityData = await _fetchAirQualityFromApi(latitude, longitude);
      } catch (e) {
        // If air quality fetch fails, continue with just weather data
      }

      // Create weather model with both data sets
      return WeatherModel.fromApiResponse(
        weatherData,
        cityName,
        airQualityResponse: airQualityData,
      );
    } catch (e) {
      throw WeatherServiceException('Failed to fetch weather data: $e');
    }
  }

  Future<ApiResponse<WeatherApi>> _fetchFromApi(
    double latitude,
    double longitude,
  ) async {
    return await _weather.request(
      latitude: latitude,
      longitude: longitude,
      forecastDays: 10,
      pastHours: 24,

      current: {
        WeatherCurrent.temperature_2m,
        WeatherCurrent.relative_humidity_2m,
        WeatherCurrent.apparent_temperature,
        WeatherCurrent.is_day,
        WeatherCurrent.snowfall,
        WeatherCurrent.showers,
        WeatherCurrent.rain,
        WeatherCurrent.precipitation,
        WeatherCurrent.weather_code,
        WeatherCurrent.cloud_cover,
        WeatherCurrent.pressure_msl,
        WeatherCurrent.surface_pressure,
        WeatherCurrent.wind_gusts_10m,
        WeatherCurrent.wind_direction_10m,
        WeatherCurrent.wind_speed_10m,
      },
      hourly: {
        WeatherHourly.visibility,
        WeatherHourly.temperature_2m,
        WeatherHourly.relative_humidity_2m,
        WeatherHourly.apparent_temperature,
        WeatherHourly.is_day,
        WeatherHourly.snowfall,
        WeatherHourly.showers,
        WeatherHourly.rain,
        WeatherHourly.precipitation,
        WeatherHourly.weather_code,
        WeatherHourly.cloud_cover,
        WeatherHourly.pressure_msl,
        WeatherHourly.surface_pressure,
        WeatherHourly.wind_gusts_10m,
        WeatherHourly.wind_direction_10m,
        WeatherHourly.wind_speed_10m,
        WeatherHourly.uv_index,
      },
      daily: {
        WeatherDaily.temperature_2m_max,
        WeatherDaily.temperature_2m_min,
        WeatherDaily.apparent_temperature_max,
        WeatherDaily.apparent_temperature_min,
        WeatherDaily.sunrise,
        WeatherDaily.sunset,
        WeatherDaily.precipitation_sum,
        WeatherDaily.rain_sum,
        WeatherDaily.snowfall_sum,
        WeatherDaily.weather_code,
        WeatherDaily.wind_speed_10m_max,
        WeatherDaily.uv_index_max,
      },
    );
  }

  // Add method to fetch air quality data
  Future<ApiResponse<AirQualityApi>> _fetchAirQualityFromApi(
    double latitude,
    double longitude,
  ) async {
    return await _airQuality.request(
      latitude: latitude,
      longitude: longitude,
      current: {
        AirQualityCurrent.european_aqi,
        AirQualityCurrent.pm10,
        AirQualityCurrent.pm2_5,
        AirQualityCurrent.nitrogen_dioxide,
        AirQualityCurrent.ozone,
      },
      hourly: {
        AirQualityHourly.european_aqi,
        AirQualityHourly.pm10,
        AirQualityHourly.pm2_5,
        AirQualityHourly.nitrogen_dioxide,
        AirQualityHourly.ozone,
      },
    );
  }
}
