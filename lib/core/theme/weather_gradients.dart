import 'package:flutter/material.dart';

class WeatherGradients {
  static LinearGradient getGradientForCode(int code, {bool isDay = true}) {
    // Map each code directly to specific gradients for more precise control over the appearance
    switch (code) {
      // Clear sky
      case 0:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF0F2027), Color(0xFF203A43)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Mainly clear
      case 1:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF64B5F6), Color(0xFF42A5F5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF172A3A), Color(0xFF304352)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Partly cloudy
      case 2:
      case 3:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF757F9A), Color(0xFFD7DDE8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF2C3E50), Color(0xFF4C5C68)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Fog
      case 45:
      case 48:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFFB0BEC5), Color(0xFFCFD8DC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF37474F), Color(0xFF546E7A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Light drizzle
      case 51:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF78909C), Color(0xFF90A4AE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF263238), Color(0xFF37474F)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Moderate drizzle
      case 53:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF546E7A), Color(0xFF78909C)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF283593)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Dense drizzle
      case 55:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF455A64), Color(0xFF607D8B)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF303F9F)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Freezing drizzle
      case 56:
      case 57:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF78909C), Color(0xFFB0BEC5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Slight rain
      case 61:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF314755), Color(0xFF26A0DA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF1A2980), Color(0xFF26D0CE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Moderate rain
      case 63:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF2B5876), Color(0xFF4E4376)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF0F2027), Color(0xFF203A43)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Heavy rain
      case 65:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF000046), Color(0xFF1CB5E0)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Freezing rain
      case 66:
      case 67:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF3A6073), Color(0xFF16222A)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF000428), Color(0xFF004e92)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Snow
      case 71:
      case 73:
      case 75:
      case 77:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF8E9EAB), Color(0xFFEEF2F3)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Rain showers
      case 80:
      case 81:
      case 82:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF2980B9), Color(0xFF6DD5FA)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF0F2027), Color(0xFF203A43)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Snow showers
      case 85:
      case 86:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFFBDC3C7), Color(0xFF2C3E50)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Thunderstorm
      case 95:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF373B44), Color(0xFF4286f4)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF232526), Color(0xFF414345)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Thunderstorm with hail
      case 96:
      case 99:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF16222A), Color(0xFF3A6073)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF1F1C2C), Color(0xFF928DAB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );

      // Default case
      default:
        return isDay
            ? const LinearGradient(
              colors: [Color(0xFF83a4d4), Color(0xFFb6fbff)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
            : const LinearGradient(
              colors: [Color(0xFF2C3E50), Color(0xFF4CA1AF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            );
    }
  }
}
