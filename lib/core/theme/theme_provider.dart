import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/viewmodels/weather_view_model.dart';

// Generate the code
part 'theme_provider.g.dart';

/// Enum to define the theme selection mode
enum ThemeSelectionMode { dayNight, system, manual }

/// Provider for the user's theme selection mode preference
@riverpod
class ThemeSelectionModeNotifier extends _$ThemeSelectionModeNotifier {
  @override
  ThemeSelectionMode build() => ThemeSelectionMode.dayNight;
}

/// Provider for manually selected theme (only used when in manual mode)
@riverpod
class ManualThemeMode extends _$ManualThemeMode {
  @override
  ThemeMode build() => ThemeMode.system;
}

/// Helper function to determine if it's daytime based on weather data
bool _isDaytime(dynamic weather) {
  final now = DateTime.now();

  // Get sunrise and sunset times
  DateTime? sunrise, sunset;
  if (weather.dailyForecast.isNotEmpty) {
    sunrise = weather.dailyForecast[0].sunrise;
    sunset = weather.dailyForecast[0].sunset;
  }

  // Default to day if we can't determine
  if (sunrise == null || sunset == null) return true;

  // Check if current time is between sunrise and sunset
  return now.isAfter(sunrise) && now.isBefore(sunset);
}

/// Provider that determines the app theme mode based on various factors
@riverpod
ThemeMode themeMode(Ref ref) {
  final selectionMode = ref.watch(themeSelectionModeNotifierProvider);

  // Handle system or manual modes
  if (selectionMode == ThemeSelectionMode.system) return ThemeMode.system;
  if (selectionMode == ThemeSelectionMode.manual) {
    return ref.watch(manualThemeModeProvider);
  }

  // Handle day/night mode based on weather
  return ref
      .watch(weatherViewModelProvider)
      .when(
        data:
            (weather) => _isDaytime(weather) ? ThemeMode.light : ThemeMode.dark,
        loading: () => ThemeMode.system,
        error: (_, __) => ThemeMode.system,
      );
}

/// Provider that determines the app theme based on sunrise and sunset times
@riverpod
ThemeData theme(Ref ref) {
  return ref
      .watch(weatherViewModelProvider)
      .when(
        data:
            (weather) =>
                _isDaytime(weather) ? ThemeData.light() : ThemeData.dark(),
        loading: () => ThemeData.light(),
        error: (_, __) => ThemeData.light(),
      );
}
