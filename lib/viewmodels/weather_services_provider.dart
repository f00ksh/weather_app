import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/models/current_weather.dart';
import 'package:weather_app/models/forecast_entry.dart';
import '../services/weather_service.dart';

part 'weather_services_provider.g.dart';

// Provider for the WeatherService
@riverpod
WeatherService weatherService(ref) {
  return WeatherService();
}

// FutureProvider.family for current weather data
@riverpod
Future<CurrentWeather> currentWeather(ref, String city) async {
  final weatherService = ref.watch(weatherServiceProvider);
  return weatherService.getCurrentWeather(city);
}

@riverpod
Future<List<ForecastEntry>> forecast(ref, String city) async {
  final weatherService = ref.watch(weatherServiceProvider);
  return weatherService.getFiveDayForecast(city);
}
