import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

part 'location_provider.g.dart';

// Provider for the LocationService
@riverpod
LocationService locationService(Ref ref) {
  return LocationService();
}

// Provider for current location data
@riverpod
Future<Position?> currentLocation(Ref ref) async {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getCurrentLocation();
}

// Provider for current city name
@riverpod
Future<String> currentCity(Ref ref) async {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getCurrentCity();
}
