import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/models/city_location.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/core/routes/app_routes.dart';
import 'package:weather_app/core/theme/weather_visuals.dart';
import 'package:weather_app/viewmodels/saved_cities_provider.dart';
import 'package:weather_app/viewmodels/search_provider.dart';
import 'package:weather_app/viewmodels/weather_view_model.dart';
import 'package:weather_app/views/pages/cities_page.dart';
import 'package:weather_app/views/pages/error_view.dart';
import 'package:weather_app/views/widgets/home_page/hourly_forecast_card.dart';
import 'package:weather_app/views/widgets/home_page/weather_dashboard.dart';
import 'package:weather_app/views/widgets/home_page/weather_header.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  // Breakpoint for tablet/desktop layouts
  static const double _tabletBreakpoint = 700;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherAsync = ref.watch(weatherProvider);
    final selectedCity = ref.watch(selectedCityFromSearchProvider);
    final savedCities = ref.watch(savedCitiesProvider);

    // Check if the current city is saved
    final bool isCitySaved =
        selectedCity != null &&
        savedCities.any((city) => city.id == selectedCity.id);

    // Wrap with WillPopScope to handle back button
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        AppRouter.handleHomePageBackButton(context);
      },
      child: weatherAsync.when(
        data:
            (weather) => _buildWeatherContent(
              context,
              ref,
              weather,
              selectedCity,
              isCitySaved,
            ),
        loading: () => _buildLoadingView(),
        error: (error, stack) => _buildErrorView(ref, error),
      ),
    );
  }

  /// Builds the main weather content with appropriate layout
  Widget _buildWeatherContent(
    BuildContext context,
    WidgetRef ref,
    WeatherModel weather,
    CityLocation? selectedCity,
    bool isCitySaved,
  ) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: WeatherVisuals.getGradient(
            weather.weatherCode,
            isDay: weather.isDay,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator.adaptive(
            edgeOffset: 25,
            displacement: 75,
            onRefresh: () async => ref.invalidate(weatherProvider),
            child:
                _isTabletLayout(context)
                    ? _buildTabletLayout(
                      context,
                      ref,
                      weather,
                      selectedCity,
                      isCitySaved,
                    )
                    : _buildMobileLayout(
                      context,
                      ref,
                      weather,
                      selectedCity,
                      isCitySaved,
                    ),
          ),
        ),
      ),
    );
  }

  /// Checks if the current layout should use tablet mode
  bool _isTabletLayout(BuildContext context) {
    return MediaQuery.of(context).size.width > _tabletBreakpoint ||
        MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// Builds loading state view
  Widget _buildLoadingView() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: WeatherVisuals.getGradient(0)),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }

  /// Builds error state view
  Widget _buildErrorView(WidgetRef ref, Object error) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: WeatherVisuals.getGradient(0)),
        child: ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(weatherProvider),
        ),
      ),
    );
  }

  /// Builds the mobile layout for smaller screens
  Widget _buildMobileLayout(
    BuildContext context,
    WidgetRef ref,
    WeatherModel weather,
    CityLocation? selectedCity,
    bool isCitySaved,
  ) {
    return CustomScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      slivers: [
        _buildAppBar(context, ref, weather, selectedCity, isCitySaved),
        WeatherHeader(weather: weather),
        SliverList(
          delegate: SliverChildListDelegate([
            HourlyForecastCard(weather: weather),
            WeatherDashboard(weather: weather),
            const SizedBox(height: 25),
            _buildFooter(context),
            const SizedBox(height: 20),
          ]),
        ),
      ],
    );
  }

  /// Builds the tablet/desktop layout for larger screens
  Widget _buildTabletLayout(
    BuildContext context,
    WidgetRef ref,
    WeatherModel weather,
    CityLocation? selectedCity,
    bool isCitySaved,
  ) {
    return Row(
      children: [
        // Left panel - Header information and hourly forecast
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.475,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              _buildAppBar(context, ref, weather, selectedCity, isCitySaved),
              WeatherHeader(weather: weather, isTabletLayout: true),
            ],
          ),
        ),
        // Right panel - Weather dashboard
        Expanded(
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(child: WeatherDashboard(weather: weather)),
              SliverToBoxAdapter(child: _buildFooter(context)),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds the AppBar with location and actions
  SliverAppBar _buildAppBar(
    BuildContext context,
    WidgetRef ref,
    WeatherModel weather,
    CityLocation? selectedCity,
    bool isCitySaved,
  ) {
    return SliverAppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      clipBehavior: Clip.none,
      title: Text(
        selectedCity?.name ?? weather.locationName,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      actions: [
        if (selectedCity != null && !isCitySaved)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: FilledButton.icon(
              icon: const Icon(Icons.bookmark_add),
              label: const Text('Save'),
              onPressed: () => _saveCity(context, ref, selectedCity),
            ),
          ),
      ],
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => _navigateToCitiesPage(context),
      ),
    );
  }

  /// Handle saving a city to favorites
  void _saveCity(BuildContext context, WidgetRef ref, CityLocation city) {
    ref.read(savedCitiesProvider.notifier).addCity(city);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${city.name} added to saved locations'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// Navigate to the cities page
  void _navigateToCitiesPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const CitiesPage()),
    );
  }

  /// Builds the footer with credits
  Widget _buildFooter(BuildContext context) {
    return Center(
      child: Text(
        'By Mhmd Fouda',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
