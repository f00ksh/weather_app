import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/services/weather_cache_service.dart';
import 'package:weather_app/core/services/weather_service.dart';
import 'package:weather_app/viewmodels/location_provider.dart';
import 'package:weather_app/viewmodels/search_provider.dart';

part 'weather_view_model.g.dart';

///// Provider for the weather cache service//////
@riverpod
WeatherCacheService weatherCacheService(Ref ref) {
  return WeatherCacheService();
}

@riverpod
class WeatherViewModel extends _$WeatherViewModel {
  @override
  FutureOr<WeatherModel> build() async {
    // Get the weather service
    final weatherService = ref.watch(weatherServiceProvider);

    // Get the cache service
    final cacheService = ref.watch(weatherCacheServiceProvider);

    // Check if a city has been selected from search
    final selectedCity = ref.watch(selectedCityFromSearchProvider);

    // Create a location ID for caching
    final String locationId = selectedCity?.name ?? 'current_location';

    // Try to get cached data first
    final cachedWeather = await cacheService.getCachedWeatherData(locationId);
    if (cachedWeather != null) {
      return cachedWeather;
    }

    WeatherModel weather;
    if (selectedCity != null) {
      // Use the selected city from search

      weather = await weatherService.getWeatherData(
        selectedCity.latitude,
        selectedCity.longitude,
        selectedCity.name,
      );
    } else {
      // Otherwise use current location
      // Get the city name
      final cityName = await ref.watch(currentCityProvider.future);

      // Get the location data
      final locationData = await ref.watch(currentLocationProvider.future);

      if (locationData != null) {
        weather = await weatherService.getWeatherData(
          locationData.latitude,
          locationData.longitude,
          cityName,
        );
      } else {
        // Fallback to default coordinates if location is not available

        weather = await weatherService.getWeatherData(
          31.716871,
          31.391597,
          cityName,
        );
      }
    }

    // Cache the fetched data

    await cacheService.cacheWeatherData(locationId, weather);

    return weather;
  }

  // Method to force refresh weather data
  Future<void> refreshWeather() async {
    // Get the selected city from search
    final selectedCity = ref.read(selectedCityFromSearchProvider);

    // Get the cache service
    final cacheService = ref.read(weatherCacheServiceProvider);

    // Create a location ID for caching
    final String locationId = selectedCity?.name ?? 'current_location';

    // Clear the cache for this location
    await cacheService.clearLocationCache(locationId);

    // Invalidate this provider to trigger a refresh
    ref.invalidateSelf();
  }
}

///// Provider for the cities weather service//////

@riverpod
class CityWeatherProvider extends _$CityWeatherProvider {
  @override
  FutureOr<WeatherModel> build(double latitude, double longitude) async {
    final weatherService = ref.read(weatherServiceProvider);
    final cacheService = ref.read(weatherCacheServiceProvider);

    // Create a location ID for caching based on coordinates
    final String locationId = '${latitude}_$longitude';

    // Try to get cached data first
    final cachedWeather = await cacheService.getCachedWeatherData(locationId);
    if (cachedWeather != null) {
      debugPrint('CityWeatherProvider: Using cached data for $locationId');
      return cachedWeather;
    }

    final weather = await weatherService.getWeatherData(
      latitude,
      longitude,
      '',
    );

    // Cache the fetched data
    await cacheService.cacheWeatherData(locationId, weather);

    return weather;
  }
}

//// Provider for the current location weather service //////
@riverpod
class CurrentLocationWeatherProvider extends _$CurrentLocationWeatherProvider {
  @override
  FutureOr<WeatherModel> build() async {
    final weatherService = ref.read(weatherServiceProvider);
    final cacheService = ref.read(weatherCacheServiceProvider);

    // Always use current location regardless of selected city
    final locationId = 'current_location';

    // Try to get cached data first
    final cachedWeather = await cacheService.getCachedWeatherData(locationId);
    if (cachedWeather != null) {
      debugPrint('CurrentLocationWeatherProvider: Using cached data');
      return cachedWeather;
    }

    // Get the city name
    final cityName = await ref.watch(currentCityProvider.future);

    // Get the location data
    final locationData = await ref.watch(currentLocationProvider.future);

    WeatherModel weather;
    if (locationData != null) {
      weather = await weatherService.getWeatherData(
        locationData.latitude,
        locationData.longitude,
        cityName,
      );
    } else {
      weather = await weatherService.getWeatherData(
        31.716871,
        31.391597,
        cityName,
      );
    }

    // Cache the fetched data
    await cacheService.cacheWeatherData(locationId, weather);

    return weather;
  }

  // Method to force refresh weather data
  Future<void> refreshWeather() async {
    final cacheService = ref.read(weatherCacheServiceProvider);
    const locationId = 'current_location';

    // Clear the cache for this location
    await cacheService.clearLocationCache(locationId);

    // Invalidate this provider to trigger a refresh
    ref.invalidateSelf();
  }
}
