import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/models/city_location.dart';
import 'package:weather_app/services/geocoding_service.dart';

part 'search_provider.g.dart';

// Provider for search query
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() {
    return '';
  }

  void updateQuery(String query) {
    state = query;
  }
}

// Provider for search results
@riverpod
Future<List<CityLocation>> searchResults(Ref ref) async {
  final query = ref.watch(searchQueryProvider);
  final geocodingService = ref.watch(geocodingServiceProvider);

  if (query.isEmpty) {
    return [];
  }

  return await geocodingService.searchCities(query);
}

// Provider for selected city
@riverpod
class SelectedCityFromSearch extends _$SelectedCityFromSearch {
  @override
  CityLocation? build() {
    return null;
  }

  void selectCity(CityLocation city) {
    state = city;
  }

  void clearSelection() {
    state = null;
  }
}
