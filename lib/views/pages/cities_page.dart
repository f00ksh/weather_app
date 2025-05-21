import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/routes/app_routes.dart';
import 'package:weather_app/models/city_location.dart';
import 'package:weather_app/viewmodels/saved_cities_provider.dart';
import 'package:weather_app/viewmodels/search_provider.dart';
import 'package:weather_app/viewmodels/weather_view_model.dart';
import 'package:weather_app/views/pages/search_page.dart';
import 'package:weather_app/core/shared/widgets/section_header.dart';
import 'package:weather_app/views/widgets/cities_page/saved_city_item.dart';
import 'package:weather_app/views/widgets/cities_page/weather_location_tile.dart';

class CitiesPage extends ConsumerWidget {
  const CitiesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final savedCities = ref.watch(savedCitiesProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Weather',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildCurrentLocationSection(context, ref),
            _buildSavedLocationsSection(context, savedCities, ref),
          ],
        ),
      ),
      floatingActionButton: _buildSearchButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildCurrentLocationSection(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(icon: Icons.my_location, title: 'Current location'),
        ref
            .watch(currentLocationWeatherProviderProvider)
            .when(
              data: (weather) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: WeatherLocationTile(
                    locationName: weather.locationName,
                    weatherCode: weather.weatherCode,
                    isDay: weather.isDay,
                    temperature: weather.temperature,
                    onTap:
                        () => _navigateToHomeWithCurrentLocation(context, ref),
                  ),
                );
              },
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
                    title: const Text('Current location'),
                    subtitle: const Text('Unable to load weather data'),
                    trailing: const Text('--°'),
                    onTap:
                        () => _navigateToHomeWithCurrentLocation(context, ref),
                  ),
            ),
      ],
    );
  }

  Widget _buildSavedLocationsSection(
    BuildContext context,
    List<CityLocation> savedCities,
    WidgetRef ref,
  ) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.bookmark_border,
            title: 'Saved locations',
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          ),
          Expanded(
            child:
                savedCities.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Search to save a location',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    )
                    : ReorderableListView(
                      proxyDecorator: (child, index, animation) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          child: child,
                        );
                      },
                      clipBehavior: Clip.antiAlias,
                      children:
                          savedCities.map((city) {
                            return SavedCityItem(
                              key: ValueKey(city.id),
                              city: city,
                            );
                          }).toList(),
                      onReorder: (int oldIndex, int newIndex) {
                        // Adjust the newIndex if it's after the removal point
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        // Update the order in the provider
                        ref
                            .read(savedCitiesProvider.notifier)
                            .reorderCities(oldIndex, newIndex);
                      },
                    ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: FloatingActionButton.large(
        heroTag: 'search',
        shape: const CircleBorder(),
        onPressed: () => _navigateToSearch(context),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: Icon(
          Icons.search,
          color: Theme.of(context).colorScheme.onTertiary,
        ),
      ),
    );
  }

  void _navigateToHomeWithCurrentLocation(BuildContext context, WidgetRef ref) {
    // Select the city
    ref.read(selectedCityFromSearchProvider.notifier).clearSelection();
    // Navigate to home page
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  void _navigateToSearch(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SearchPage()),
    );
  }
}
