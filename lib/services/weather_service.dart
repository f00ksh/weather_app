import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/current_weather.dart';
import '../models/forecast_entry.dart';

class WeatherService {
  final String apiKey = 'efb87d3d7e7675817d763484ec72a682';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  // Fetch current weather data for a given city
  Future<CurrentWeather> getCurrentWeather(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        return CurrentWeather.fromJson(jsonDecode(response.body));
      } else {
        throw WeatherException(
          'Failed to load current weather data: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw WeatherException(
        'Error fetching current weather data',
        e.toString(),
      );
    }
  }

  // Fetch current weather data by coordinates
  Future<CurrentWeather> getCurrentWeatherByLocation(
    double lat,
    double lon,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        return CurrentWeather.fromJson(jsonDecode(response.body));
      } else {
        throw WeatherException(
          'Failed to load weather data for location: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw WeatherException(
        'Error fetching weather data by location',
        e.toString(),
      );
    }
  }

  // Fetch 5-day forecast data for a given city
  Future<List<ForecastEntry>> getFiveDayForecast(String city) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/forecast?q=$city&appid=$apiKey&units=metric'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> list = data['list'];
        final cityName = data['city']['name'] as String;

        return list.map((item) {
          return ForecastEntry.fromJson(item, cityName);
        }).toList();
      } else {
        throw WeatherException(
          'Failed to load forecast data: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw WeatherException('Error fetching forecast data', e.toString());
    }
  }

  // Fetch 5-day forecast data by coordinates
  Future<List<ForecastEntry>> getFiveDayForecastByLocation(
    double lat,
    double lon,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          '$baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List<dynamic> list = data['list'];
        final cityName = data['city']['name'] as String;

        return list.map((item) {
          return ForecastEntry.fromJson(item, cityName);
        }).toList();
      } else {
        throw WeatherException(
          'Failed to load forecast data for location: ${response.statusCode}',
          response.body,
        );
      }
    } catch (e) {
      throw WeatherException(
        'Error fetching forecast data by location',
        e.toString(),
      );
    }
  }
}

// Custom exception class for weather-related errors
class WeatherException implements Exception {
  final String message;
  final String details;

  WeatherException(this.message, [this.details = '']);

  @override
  String toString() =>
      'WeatherException: $message${details.isNotEmpty ? '\nDetails: $details' : ''}';
}
