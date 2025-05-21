import 'dart:async';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather_app/services/notification_service.dart';
import 'package:weather_app/viewmodels/weather_view_model.dart';

part 'background_service.g.dart';

class BackgroundService {
  Timer? _timer;

  void startPeriodicUpdates({
    required Function() updateCallback,
    Duration interval = const Duration(hours: 1),
  }) {
    // Cancel any existing timer
    _timer?.cancel();

    // Update immediately
    updateCallback();

    // Schedule periodic updates
    _timer = Timer.periodic(interval, (_) {
      updateCallback();
    });

    debugPrint(
      'Started periodic weather updates every ${interval.inMinutes} minutes',
    );
  }

  void stopPeriodicUpdates() {
    _timer?.cancel();
    _timer = null;
    debugPrint('Stopped periodic weather updates');
  }

  bool get isRunning => _timer != null && _timer!.isActive;
}

@riverpod
class WeatherNotifications extends _$WeatherNotifications {
  @override
  bool build() {
    // Initialize the service when first accessed
    _initializeService();
    return true; // Always enabled as per requirements
  }

  Future<void> _initializeService() async {
    final notificationService = ref.read(notificationServiceProvider);
    await notificationService.initialize();

    // Start the background service
    final backgroundService = BackgroundService();

    // Set up the update callback
    backgroundService.startPeriodicUpdates(
      updateCallback: () => _updateWeatherNotification(),
      interval: const Duration(hours: 12),
    );

    // Make sure to cancel the timer when the provider is disposed
    ref.onDispose(() {
      backgroundService.stopPeriodicUpdates();
    });
  }

  Future<void> _updateWeatherNotification() async {
    try {
      // Get the notification service
      final notificationService = ref.read(notificationServiceProvider);

      // Get the current weather data
      final weatherAsync = await ref.read(
        currentLocationWeatherProviderProvider.future,
      );

      // Show the notification
      await notificationService.showWeatherNotification(weatherAsync);

      debugPrint('Weather notification updated at ${DateTime.now()}');
    } catch (e) {
      debugPrint('Failed to update weather notification: $e');
    }
  }

  // Method to manually trigger a notification update
  Future<void> updateNow() async {
    await _updateWeatherNotification();
  }
}
