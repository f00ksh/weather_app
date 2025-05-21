import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/theme/weather_descriptions.dart';
import 'package:weather_app/core/theme/weather_gradients.dart';
import 'package:weather_app/core/theme/weather_icons.dart';
import 'package:weather_app/models/weather_model.dart';

/// A central class for accessing all weather theme related functionality
class WeatherVisuals {
  /// Get the appropriate weather icon for a given weather code
  static Widget getIcon(
    int code, {
    bool isDay = true,
    bool isHeader = false,
    bool isDaily = false,
  }) {
    return WeatherIcons.getIcon(
      code,
      isDay: isDay,
      isHeader: isHeader,
      isDaily: isDaily,
    );
  }

  /// Get the text description for a weather code
  static String getDescription(int code) {
    return WeatherDescriptions.getDescription(code);
  }

  /// Get the appropriate gradient background for a weather code
  static LinearGradient getGradient(int code, {bool isDay = true}) {
    return WeatherGradients.getGradientForCode(code, isDay: isDay);
  }

  // Convert wind direction degrees to cardinal direction
  static String getWindDirectionText(double direction) {
    const directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((direction + 22.5) % 360 / 45).floor();
    return directions[index];
  }

  static String getDayName(DateTime date) {
    final now = DateTime.now();
    if (date.year == now.year &&
        date.month == now.month &&
        date.day == now.day) {
      return 'Today';
    }

    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return weekdays[date.weekday - 1];
  }

  // Format hour to 12-hour format with AM/PM
  static String formatHour(DateTime time) {
    final hour = time.hour;
    final isNow = hour == DateTime.now().hour;

    if (isNow) {
      return 'Now';
    } else {
      final hourIn12 = hour % 12 == 0 ? 12 : hour % 12;
      final amPm = hour >= 12 ? 'PM' : 'AM';
      return '$hourIn12 $amPm';
    }
  }

  // Format time with hours and minutes
  static String formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? 'PM' : 'AM';
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute $period';
  }

  static double calculateBarHeight({
    required double value,
    required double minHeight,
    required double maxHeight,
    required double maxValue,
  }) {
    final double factor = (value / maxValue).clamp(0.0, 1.0);
    return minHeight + (factor * (maxHeight - minHeight));
  }

  static double calculatePressure(double pressure) {
    const double minPressure = 970;
    const double maxPressure = 1050;
    final double normalizedValue =
        (pressure - minPressure) / (maxPressure - minPressure);
    return normalizedValue.clamp(0.0, 1.0);
  }

  // Helper method to get current hour visibility
  static String getVisibilityValue(WeatherModel weather) {
    if (weather.hourlyForecast.isEmpty) {
      return "N/A";
    }

    // Find the current hour in the hourly forecast
    final now = DateTime.now();
    final currentHourForecast = weather.hourlyForecast.firstWhere(
      (hourly) => hourly.time.hour == now.hour,
      orElse: () => weather.hourlyForecast.first,
    );

    // Convert visibility from meters to miles (1 meter = 0.000621371 miles)
    // Cap visibility between 1 and 10 miles
    double visibilityInMiles = currentHourForecast.visibility! * 0.000621371;

    // Apply the 10 mile cap
    if (visibilityInMiles > 10.0) {
      visibilityInMiles = 10.0;
    }

    // Apply the 1 mile minimum
    if (visibilityInMiles < 1.0) {
      visibilityInMiles = 1.0;
    }

    return visibilityInMiles.toStringAsFixed(0);
  }

  // Helper method to get visibility description
  static String getVisibilityDescription(double visibility) {
    if (visibility >= 8.0) {
      return 'Excellent visibility';
    } else if (visibility >= 5.0) {
      return 'Good visibility';
    } else if (visibility >= 2.0) {
      return 'Moderate visibility';
    } else if (visibility >= 0.5) {
      return 'Poor visibility';
    } else {
      return 'Very poor visibility';
    }
  }

  // Helper method to get air quality text and color based on AQI value
  static String getAirQualityInfo(int aqi) {
    if (aqi <= 50) {
      return ('Good air quality');
    } else if (aqi <= 100) {
      return ('Moderate air quality');
    } else if (aqi <= 150) {
      return ('Unhealthy for sensitive groups');
    } else if (aqi <= 200) {
      return ('Unhealthy air quality');
    } else if (aqi <= 300) {
      return ('Very unhealthy air quality');
    } else {
      return ('Hazardous air quality');
    }
  }

  /// Formats a DateTime for sunrise/sunset display
  static String formatSunTime(DateTime? dateTime) {
    return dateTime != null
        ? DateFormat('h:mm a').format(dateTime.toLocal())
        : '--:-- --';
  }

  // Helper method to determine UV index category
  static String getUvCategory(int uvIndex) {
    if (uvIndex <= 2) return 'Low';
    if (uvIndex <= 5) return 'Moderate';
    if (uvIndex <= 7) return 'High';
    if (uvIndex <= 10) return 'Very High';
    return 'Extreme';
  }

  // Helper method to format precipitation value
  static String formatPrecipitation(double value) {
    if (value < 0.01) {
      return '<0.01';
    }
    // Format to 2 decimal places
    return value.toStringAsFixed(2);
  }
}
