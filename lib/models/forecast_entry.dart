import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast_entry.freezed.dart';

@freezed
sealed class ForecastEntry with _$ForecastEntry {
  const factory ForecastEntry({
    required String city,
    required double temp,
    required String description,
    required String icon,
    required int humidity,
    required double windSpeed,
    required DateTime timestamp,
  }) = _ForecastEntry;

  factory ForecastEntry.fromJson(Map<String, dynamic> json, String cityName) {
    final weatherList = json['weather'] as List<dynamic>;
    final weather =
        weatherList.isNotEmpty ? weatherList[0] as Map<String, dynamic> : {};

    return ForecastEntry(
      city: cityName,
      temp: (json['main']['temp'] as num).toDouble(),
      description: weather['description'] as String,
      icon: weather['icon'] as String,
      humidity: (json['main']['humidity'] as num).toInt(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(
        (json['dt'] as int) * 1000,
      ),
    );
  }
}
