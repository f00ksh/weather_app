import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/routes/app_routes.dart';
import 'package:weather_app/core/services/geocoding_service.dart';
import 'package:weather_app/viewmodels/saved_cities_provider.dart';
import 'package:weather_app/viewmodels/search_provider.dart';
import 'package:weather_app/viewmodels/weather_view_model.dart';
import 'package:weather_app/views/widgets/cities_page/weather_location_tile.dart';

class SavedCityItem extends ConsumerWidget {
  final CityLocation city;

  const SavedCityItem({super.key, required this.city});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get weather data for this city
    final weatherAsync = ref.watch(
      CityWeatherProviderProvider(city.latitude, city.longitude),
    );
    final errorColor = Theme.of(context).colorScheme.errorContainer;
    final onErrorContainer = Theme.of(context).colorScheme.onErrorContainer;
    final borderRadius = BorderRadius.circular(28);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),

      child: Dismissible(
        key: Key(city.name),
        background: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: errorColor,
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 24.0),
          child: Icon(Icons.delete_outlined, color: onErrorContainer),
        ),

        secondaryBackground: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: errorColor,
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24.0),
          child: Icon(Icons.delete_outlined, color: onErrorContainer),
        ),
        direction: DismissDirection.horizontal,

        confirmDismiss: (_) async => _handleDissmis(ref, context),

        child: weatherAsync.when(
          data:
              (weather) => WeatherLocationTile(
                locationName: city.name,
                weatherCode: weather.weatherCode,
                isDay: weather.isDay,
                temperature: weather.temperature,
                onTap: () => _navigateToHome(context, ref),
                borderRadius: borderRadius, // Pass the same borderRadius
              ),

          loading:
              () => const ListTile(
                leading: SizedBox(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
                title: Text('Loading...'),
                subtitle: Text('Fetching weather data'),
                trailing: Text('--°'),
              ),
          error:
              (error, _) => ListTile(
                leading: const Icon(Icons.error_outline, size: 40),
                title: Text(city.name),
                subtitle: const Text('Unable to load weather data'),
                trailing: Text('--°'),
                onTap: () => _navigateToHome(context, ref),
              ),
        ),
      ),
    );
  }

  bool _handleDissmis(WidgetRef ref, BuildContext context) {
    // Capture the ref and context values before the async operation
    final savedCitiesNotifier = ref.read(savedCitiesProvider.notifier);
    final messenger = ScaffoldMessenger.of(context);

    // Store the city for potential restoration
    final dismissedCity = city;

    // Get the current index of the city before removing it
    final cityIndex = ref
        .read(savedCitiesProvider)
        .indexWhere((c) => c.id == city.id);

    // Remove the city immediately
    savedCitiesNotifier.removeCity(city.id);

    // Show snackbar with undo option
    final snackBar = SnackBar(
      content: Text('${city.name} removed from saved locations'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          // Add the city back at its original index
          savedCitiesNotifier.addCityAtIndex(dismissedCity, cityIndex);
        },
      ),
    );

    messenger.showSnackBar(snackBar);
    return true;
  }

  void _navigateToHome(BuildContext context, WidgetRef ref) {
    // Select the city
    ref.read(selectedCityFromSearchProvider.notifier).selectCity(city);

    // Navigate to home page
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }
}
