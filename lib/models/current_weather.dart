import 'package:freezed_annotation/freezed_annotation.dart';

part 'current_weather.freezed.dart';

@freezed
sealed class CurrentWeather with _$CurrentWeather {
  const factory CurrentWeather({
    required String city,
    required double temp,
    required String description,
    required String icon,
    required int humidity,
    required double windSpeed,
  }) = _CurrentWeather;

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    final weatherList = json['weather'] as List<dynamic>;
    final weather =
        weatherList.isNotEmpty ? weatherList[0] as Map<String, dynamic> : {};

    return CurrentWeather(
      city: json['name'] as String,
      temp: (json['main']['temp'] as num).toDouble(),
      description: weather['description'] as String,
      icon: weather['icon'] as String,
      humidity: (json['main']['humidity'] as num).toInt(),
      windSpeed: (json['wind']['speed'] as num).toDouble(),
    );
  }
}
