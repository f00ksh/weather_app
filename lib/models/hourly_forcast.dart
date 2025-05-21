class HourlyForecast {
  final DateTime time;
  final double temperature;
  final int weatherCode;
  final double? visibility;
  final double? windDirection;
  final double? windSpeed;
  final double? uvIndex;
  final bool? isDay;
  final double? precipitation;
  final double? humidity;

  HourlyForecast({
    required this.time,
    required this.temperature,
    required this.weatherCode,
    this.visibility,
    this.windDirection,
    this.windSpeed,
    this.uvIndex,
    this.isDay,
    this.precipitation,
    this.humidity,
  });

  Map<String, dynamic> toJson() {
    return {
      'time': time.millisecondsSinceEpoch,
      'temperature': temperature,
      'weatherCode': weatherCode,
      'visibility': visibility,
      'windDirection': windDirection,
      'windSpeed': windSpeed,
      'uvIndex': uvIndex,
      'isDay': isDay,
      'precipitation': precipitation,
      'humidity': humidity,
    };
  }

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: DateTime.fromMillisecondsSinceEpoch(json['time'] as int),
      temperature: json['temperature'] as double,
      weatherCode: json['weatherCode'] as int,
      visibility: json['visibility'] as double?,
      windDirection: json['windDirection'] as double?,
      windSpeed: json['windSpeed'] as double?,
      uvIndex: json['uvIndex'] as double?,
      isDay: json['isDay'] as bool?,
      precipitation: json['precipitation'] as double?,
      humidity: json['humidity'] as double?,
    );
  }
}
