import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/city_location.dart';

part 'saved_cities_provider.g.dart';

@riverpod
class SavedCities extends _$SavedCities {
  static const String _prefsKey = 'saved_cities';

  @override
  List<CityLocation> build() {
    _loadSavedCities();
    return [];
  }

  // Load saved cities from SharedPreferences
  Future<void> _loadSavedCities() async {
    final prefs = await SharedPreferences.getInstance();
    final citiesJson = prefs.getStringList(_prefsKey) ?? [];

    final cities =
        citiesJson
            .map((json) => CityLocation.fromJson(jsonDecode(json)))
            .toList();

    state = cities;
  }

  // Save cities to SharedPreferences
  Future<void> _saveCitiesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final citiesJson = state.map((city) => jsonEncode(city.toJson())).toList();

    await prefs.setStringList(_prefsKey, citiesJson);
  }

  // Add a city to saved cities
  Future<void> addCity(CityLocation city) async {
    // Check if city already exists
    if (!state.any((c) => c.id == city.id)) {
      state = [...state, city];
      await _saveCitiesToPrefs();
    }
  }

  // Add a city at a specific index
  Future<void> addCityAtIndex(CityLocation city, int index) async {
    // Check if city already exists
    if (!state.any((c) => c.id == city.id)) {
      final newList = List<CityLocation>.from(state);
      // Make sure index is within bounds
      final insertIndex = index.clamp(0, newList.length);
      newList.insert(insertIndex, city);
      state = newList;
      await _saveCitiesToPrefs();
    }
  }

  // Remove a city from saved cities
  Future<void> removeCity(int cityId) async {
    state = state.where((city) => city.id != cityId).toList();
    await _saveCitiesToPrefs();
  }

  // Check if a city is saved
  bool isCitySaved(int cityId) {
    return state.any((city) => city.id == cityId);
  }

  // Reorder cities in the list
  Future<void> reorderCities(int oldIndex, int newIndex) async {
    // Create a new list to avoid direct state mutation
    final List<CityLocation> newList = List.from(state);

    // Remove the item from the old position
    final CityLocation city = newList.removeAt(oldIndex);

    // Insert the item at the new position
    newList.insert(newIndex, city);

    // Update the state with the new order
    state = newList;

    // Save the updated order to persistent storage
    await _saveCitiesToPrefs();
  }
}
