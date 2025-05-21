class DailyForecast {
  final DateTime date;
  final double maxTemperature;
  final double minTemperature;
  final DateTime? sunrise;
  final DateTime? sunset;
  final int? code;
  final double? windSpeedMaxDaily;
  final double? precipitationSum;
  final double? uvIndexMax;

  DailyForecast({
    required this.date,
    required this.maxTemperature,
    required this.minTemperature,
    this.sunrise,
    this.sunset,
    this.code,
    this.windSpeedMaxDaily,
    this.precipitationSum,
    this.uvIndexMax,
  });

  Map<String, dynamic> toJson() {
    return {
      'date': date.millisecondsSinceEpoch,
      'maxTemperature': maxTemperature,
      'minTemperature': minTemperature,
      'sunrise': sunrise?.millisecondsSinceEpoch,
      'sunset': sunset?.millisecondsSinceEpoch,
      'code': code,
      'windSpeedMaxDaily': windSpeedMaxDaily,
      'precipitationSum': precipitationSum,
      'uvIndexMax': uvIndexMax,
    };
  }

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
      maxTemperature: json['maxTemperature'] as double,
      minTemperature: json['minTemperature'] as double,
      sunrise:
          json['sunrise'] != null
              ? DateTime.fromMillisecondsSinceEpoch(json['sunrise'] as int)
              : null,
      sunset:
          json['sunset'] != null
              ? DateTime.fromMillisecondsSinceEpoch(json['sunset'] as int)
              : null,
      code: json['code'] as int?,
      windSpeedMaxDaily: json['windSpeedMaxDaily'] as double?,
      precipitationSum: json['precipitationSum'] as double?,
      uvIndexMax: json['uvIndexMax'] as double?,
    );
  }
}
