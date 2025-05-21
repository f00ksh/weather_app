import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/routes/app_routes.dart';
import 'package:weather_app/core/services/geocoding_service.dart';
import 'package:weather_app/core/theme/app_dimension.dart';
import 'package:weather_app/viewmodels/search_provider.dart';
import 'package:weather_app/viewmodels/saved_cities_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _mounted = true;

  @override
  void initState() {
    super.initState();
    _mounted = true;
  }

  @override
  void dispose() {
    _mounted = false;
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery(String query) {
    if (!_mounted) return;

    setState(() {
      _searchQuery = query;
    });

    // Update the search query in the provider
    if (query.isNotEmpty) {
      ref.read(searchQueryProvider.notifier).updateQuery(query);
    }
  }

  void _selectCity(BuildContext context, WidgetRef ref, CityLocation city) {
    // Set the selected city
    ref.read(selectedCityFromSearchProvider.notifier).selectCity(city);

    // Navigate to home page
    Navigator.of(context).pushReplacementNamed(AppRoutes.home);
  }

  @override
  Widget build(BuildContext context) {
    final searchResults = ref.watch(searchResultsProvider);
    final savedCities = ref.watch(savedCitiesProvider);

    return Hero(
      tag: 'search',
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search for a location',
              border: InputBorder.none,
            ),

            onChanged: _updateSearchQuery,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child:
                  _searchQuery.isEmpty
                      ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Enter a city name',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      )
                      : searchResults.when(
                        data: (cities) {
                          if (cities.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.location_off_outlined,
                                    size: AppDimension.cardContentLarge,
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No locations found',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(color: Colors.grey.shade600),
                                  ),
                                ],
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: cities.length,
                            itemBuilder: (context, index) {
                              final city = cities[index];
                              final isSaved = savedCities.any(
                                (c) => c.id == city.id,
                              );

                              return ListTile(
                                title: Text(city.name),
                                subtitle: Text(city.displayName),
                                onTap: () => _selectCity(context, ref, city),
                                trailing:
                                    !isSaved
                                        ? FilledButton.icon(
                                          label: Icon(Icons.add),
                                          onPressed: () {
                                            ref
                                                .read(
                                                  savedCitiesProvider.notifier,
                                                )
                                                .addCity(city);
                                          },
                                        )
                                        : null,
                              );
                            },
                          );
                        },
                        loading:
                            () => const Center(
                              child: CircularProgressIndicator(),
                            ),
                        error:
                            (error, _) => Center(
                              child: Text('Error: ${error.toString()}'),
                            ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
