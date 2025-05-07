import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:location/location.dart';
import '../services/location_service.dart';

part 'location_provider.g.dart';

// Provider for the LocationService
@riverpod
LocationService locationService(ref) {
  return LocationService();
}

// Provider for current location data
@riverpod
Future<LocationData?> currentLocation(ref) async {
  final locationService = ref.read(locationServiceProvider);
  return locationService.getCurrentLocation();
}

// Provider for current city name
@riverpod
Future<String> currentCity(ref) async {
  final locationService = ref.read(locationServiceProvider);
  return locationService.getCurrentCity();
}
