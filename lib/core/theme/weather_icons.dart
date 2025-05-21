import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app/core/theme/app_dimension.dart';

class WeatherIcons {
  static Widget getIcon(
    int code, {
    bool isDay = true,
    bool isHeader = false,
    bool isDaily = false,
  }) {
    // Get the appropriate SVG file path based on weather code and day/night
    String iconPath = _getIconPath(code, isDay: isDay);

    // Return the SVG icon
    final double sizeMobile = isHeader ? 80 : (isDaily ? 30 : 24);
    final double sizeTablet = isHeader ? 150 : (isDaily ? 35 : 32);
    final double size = AppDimension.isTablet ? sizeTablet : sizeMobile;
    return SvgPicture.asset(iconPath, width: size, height: size);
  }

  static String _getIconPath(int code, {bool isDay = true}) {
    // Weather code mapping based on WMO codes
    switch (code) {
      case 0: // Clear sky
        return isDay
            ? 'assets/icons/clear_day.svg'
            : 'assets/icons/clear_night.svg';

      case 1: // Mainly clear
        return isDay
            ? 'assets/icons/mostly_clear_day.svg'
            : 'assets/icons/mostly_clear_night.svg';

      case 2: // Partly cloudy
        return isDay
            ? 'assets/icons/partly_cloudy_day.svg'
            : 'assets/icons/partly_cloudy_night.svg';

      case 3: // Overcast
        return 'assets/icons/cloudy.svg';

      case 45:
      case 48: // Fog and depositing rime fog
        return 'assets/icons/haze_fog_dust_smoke.svg';

      case 51:
      case 53:
      case 55: // Drizzle: Light, moderate, and dense intensity
        return 'assets/icons/drizzle.svg';

      case 56:
      case 57: // Freezing Drizzle: Light and dense intensity
        return 'assets/icons/sleet_hail.svg';

      case 61: // Rain: Slight
        return isDay
            ? 'assets/icons/rain_with_sunny_light.svg'
            : 'assets/icons/rain_with_cloudy_light.svg';

      case 63:
      case 65: // Rain: moderate and heavy intensity
        return isDay
            ? 'assets/icons/rain_with_sunny_dark.svg'
            : 'assets/icons/rain_with_cloudy_dark.svg';

      case 66:
      case 67: // Freezing Rain: Light and heavy intensity
        return 'assets/icons/sleet_hail.svg';

      case 71:
      case 73:
      case 75: // Snow fall: Slight, moderate, and heavy intensity
        return isDay
            ? 'assets/icons/snow_with_sunny_light.svg'
            : 'assets/icons/snow_with_cloudy_light.svg';

      case 77: // Snow grains
        return 'assets/icons/flurries.svg';

      case 80:
      case 81:
      case 82: // Rain showers: Slight, moderate, and violent
        return isDay
            ? 'assets/icons/scattered_showers_day.svg'
            : 'assets/icons/scattered_showers_night.svg';

      case 85:
      case 86: // Snow showers slight and heavy
        return isDay
            ? 'assets/icons/scattered_snow_showers_day.svg'
            : 'assets/icons/scattered_snow_showers_night.svg';

      case 95: // Thunderstorm: Slight or moderate
        return 'assets/icons/isolated_thunderstorms.svg';

      case 96:
      case 99: // Thunderstorm with hail
        return 'assets/icons/strong_thunderstorms.svg';

      default:
        return isDay
            ? 'assets/icons/clear_day.svg'
            : 'assets/icons/clear_night.svg'; // Default fallback
    }
  }
}
