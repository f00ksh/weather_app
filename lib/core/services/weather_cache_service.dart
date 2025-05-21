import 'dart:convert';
import 'package:flutter/foundation.dart';
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
    try {
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

      debugPrint(
        'WeatherCacheService: ✅ Successfully cached weather data for location: $locationId',
      );
      debugPrint('WeatherCacheService: Cache timestamp: ${DateTime.now()}');
    } catch (e) {
      debugPrint('WeatherCacheService: ❌ Error caching weather data - $e');
    }
  }

  // Get cached weather data if available and not expired
  Future<WeatherModel?> getCachedWeatherData(String locationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheJson = prefs.getString(_weatherCacheKey);

      if (cacheJson == null) {
        debugPrint('WeatherCacheService: No cache found in SharedPreferences');
        return null;
      }

      final cacheMap = jsonDecode(cacheJson) as Map<String, dynamic>;
      final locationCache = cacheMap[locationId];

      if (locationCache == null) {
        debugPrint(
          'WeatherCacheService: No cache entry found for location: $locationId',
        );
        return null;
      }

      // Check if cache is expired
      final timestamp = DateTime.fromMillisecondsSinceEpoch(
        locationCache['timestamp'],
      );
      final now = DateTime.now();
      final difference = now.difference(timestamp);

      debugPrint(
        'WeatherCacheService: Cache age for $locationId: ${difference.inMinutes} minutes',
      );

      if (difference > _cacheExpiration) {
        debugPrint(
          'WeatherCacheService: ⚠️ Cache EXPIRED for location $locationId (older than ${_cacheExpiration.inHours} hours)',
        );
        return null;
      }

      // Cache is valid, return the data
      final weatherData = WeatherModel.fromJson(locationCache['data']);
      debugPrint(
        'WeatherCacheService: ✅ Using VALID CACHE for location $locationId',
      );
      debugPrint('WeatherCacheService: Cache timestamp: $timestamp');
      return weatherData;
    } catch (e) {
      debugPrint(
        'WeatherCacheService: ❌ Error retrieving cached weather data - $e',
      );
      return null;
    }
  }

  // Clear all cached weather data
  Future<void> clearCache() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_weatherCacheKey);
      debugPrint('WeatherCacheService: 🗑️ ALL cache cleared');
    } catch (e) {
      debugPrint('WeatherCacheService: ❌ Error clearing cache - $e');
    }
  }

  // Clear cached data for a specific location
  Future<void> clearLocationCache(String locationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cacheJson = prefs.getString(_weatherCacheKey);

      if (cacheJson != null) {
        final cacheMap = jsonDecode(cacheJson) as Map<String, dynamic>;
        final hadLocation = cacheMap.containsKey(locationId);
        cacheMap.remove(locationId);
        await prefs.setString(_weatherCacheKey, jsonEncode(cacheMap));

        if (hadLocation) {
          debugPrint(
            'WeatherCacheService: 🗑️ Cache cleared for location: $locationId',
          );
        } else {
          debugPrint(
            'WeatherCacheService: No cache entry found to clear for location: $locationId',
          );
        }
      }
    } catch (e) {
      debugPrint('WeatherCacheService: ❌ Error clearing location cache - $e');
    }
  }
}
