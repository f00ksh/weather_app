import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherCacheService {
  static const String _weatherCacheKey = 'weather_cache';
  static const Duration _cacheExpiration = Duration(
    hours: 1,
  ); // Cache expires after 1 hour

  // Save weather data to cache
  Future<void> cacheWeatherData(
    String locationId,
    WeatherModel weatherData,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    // Create cache entry with timestamp and data
    final cacheEntry = {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': weatherData.toJson(),
    };

    // Get existing cache or create new one
    final existingCacheJson = prefs.getString(_weatherCacheKey);
    Map<String, dynamic> cacheMap = {};

    if (existingCacheJson != null) {
      cacheMap = jsonDecode(existingCacheJson) as Map<String, dynamic>;
    }

    // Add or update this location's data
    cacheMap[locationId] = cacheEntry;

    // Save back to shared preferences
    await prefs.setString(_weatherCacheKey, jsonEncode(cacheMap));
  }

  // Get cached weather data if available and not expired
  Future<WeatherModel?> getCachedWeatherData(String locationId) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheJson = prefs.getString(_weatherCacheKey);

    if (cacheJson == null) {
      return null;
    }

    final cacheMap = jsonDecode(cacheJson) as Map<String, dynamic>;
    final locationCache = cacheMap[locationId];

    if (locationCache == null) {
      return null;
    }

    // Check if cache is expired
    final timestamp = DateTime.fromMillisecondsSinceEpoch(
      locationCache['timestamp'],
    );
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference > _cacheExpiration) {
      return null;
    }

    // Cache is valid, return the data
    final weatherData = WeatherModel.fromJson(locationCache['data']);

    return weatherData;
  }

  // Clear all cached weather data
  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_weatherCacheKey);
  }

  // Clear cached data for a specific location
  Future<void> clearLocationCache(String locationId) async {
    final prefs = await SharedPreferences.getInstance();
    final cacheJson = prefs.getString(_weatherCacheKey);

    if (cacheJson != null) {
      final cacheMap = jsonDecode(cacheJson) as Map<String, dynamic>;

      cacheMap.remove(locationId);
      await prefs.setString(_weatherCacheKey, jsonEncode(cacheMap));
    }
  }
}
