import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  // Request location permissions and check if location services are enabled
  Future<bool> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await GeolocatorPlatform.instance.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled
      return false;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        // Permission denied
        return false;
      }
    }

    // Check if permanently denied
    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    return true;
  }

  // Get current location (latitude and longitude)
  Future<Position?> getCurrentLocation() async {
    try {
      if (!await requestPermission()) {
        return null;
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 5),
        ),
      );

      return position;
    } catch (e) {
      return null;
    }
  }

  // Reverse geocode coordinates to city name using the geocoding package
  Future<String> getCityFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        // Use locality (city) if available, otherwise use subAdministrativeArea
        String cityName =
            place.locality?.isNotEmpty == true
                ? place.locality!
                : (place.subAdministrativeArea?.isNotEmpty == true
                    ? place.subAdministrativeArea!
                    : 'Unknown City');

        return cityName;
      }
    } catch (e) {
      // Handle error silently
    }

    return 'Unknown City';
  }

  // Get current city name
  Future<String> getCurrentCity() async {
    final position = await getCurrentLocation();

    if (position != null) {
      return getCityFromCoordinates(position.latitude, position.longitude);
    }

    return 'Unknown City';
  }
}
