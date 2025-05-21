import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_meteo/open_meteo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/models/city_location.dart';

part 'geocoding_service.g.dart';

@riverpod
GeocodingService geocodingService(Ref ref) {
  return GeocodingService();
}

class GeocodingService {
  final _geocoding = GeocodingApi();

  Future<List<CityLocation>> searchCities(String query) async {
    if (query.isEmpty) {
      return [];
    }

    try {
      // Use the GeocodingApi from open_meteo package
      final response = await _geocoding.requestJson(name: query, count: 5);

      if (response.containsKey('results')) {
        final List<dynamic> results = response['results'];
        return results.map((result) => CityLocation.fromJson(result)).toList();
      }
      return [];
    } catch (e) {
      if (kDebugMode) {
        print('Error searching cities: $e');
      }
      return [];
    }
  }
}
