import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  // Simple mapping for reverse geocoding (in a real app, you'd use a geocoding API)
  final Map<String, String> _coordinatesToCity = {
    '51.5074,-0.1278': 'London',
    '40.7128,-74.0060': 'New York',
    '35.6762,139.6503': 'Tokyo',
    '48.8566,2.3522': 'Paris',
    '55.7558,37.6173': 'Moscow',
  };

  // Request location permissions
  Future<bool> requestPermission() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    // Check if location services are enabled
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    // Check if permission is granted
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    return true;
  }

  // Get current location (latitude and longitude)
  Future<LocationData?> getCurrentLocation() async {
    try {
      if (!await requestPermission()) {
        return null;
      }

      return await _location.getLocation();
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location: $e');
      }
      return null;
    }
  }

  // Reverse geocode coordinates to city name
  // In a real app, you would use a geocoding API like Google Maps or OpenStreetMap
  String getCityFromCoordinates(double latitude, double longitude) {
    // Round coordinates to simplify matching
    // final String key = '${latitude.toStringAsFixed(4)},${longitude.toStringAsFixed(4)}';

    // Find the closest match in our simple mapping
    String? closestCity;
    double closestDistance = double.infinity;

    for (final entry in _coordinatesToCity.entries) {
      final coords = entry.key.split(',');
      final lat = double.parse(coords[0]);
      final lon = double.parse(coords[1]);

      // Calculate simple distance (not actual geographic distance)
      final distance = (lat - latitude).abs() + (lon - longitude).abs();

      if (distance < closestDistance) {
        closestDistance = distance;
        closestCity = entry.value;
      }
    }

    // Return the closest city or a default
    return closestCity ?? 'Unknown City';
  }

  // Get current city name
  Future<String> getCurrentCity() async {
    final location = await getCurrentLocation();

    if (location != null) {
      return getCityFromCoordinates(location.latitude!, location.longitude!);
    }

    return 'Unknown City';
  }
}
