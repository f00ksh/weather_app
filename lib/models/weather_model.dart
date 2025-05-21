import 'package:open_meteo/open_meteo.dart';

class WeatherModel {
  // Weather fields
  final double temperature;
  final double feelsLike;
  final int weatherCode;
  final double windSpeed;
  final double windDirection;
  final double humidity;
  final double pressure;
  final double precipitation;
  final String locationName;
  final DateTime timestamp;
  final List<HourlyForecast> hourlyForecast;
  final List<DailyForecast> dailyForecast;
  final bool isDay;

  // Air quality fields
  final double? airQualityIndex;
  final Map<String, double>? airQualityComponents;

  WeatherModel({
    required this.temperature,
    required this.feelsLike,
    required this.weatherCode,
    required this.windSpeed,
    required this.windDirection,
    required this.humidity,
    required this.pressure,
    required this.locationName,
    required this.timestamp,
    required this.hourlyForecast,
    required this.dailyForecast,
    required this.precipitation,
    required this.isDay,

    this.airQualityIndex,
    this.airQualityComponents,
  });

  factory WeatherModel.fromApiResponse(
    ApiResponse<WeatherApi> response,
    String cityName, {
    ApiResponse<AirQualityApi>? airQualityResponse,
  }) {
    return WeatherModel(
      temperature:
          response.currentData[WeatherCurrent.temperature_2m]?.value ?? 0.0,
      feelsLike:
          response.currentData[WeatherCurrent.apparent_temperature]?.value ??
          0.0,
      weatherCode:
          response.currentData[WeatherCurrent.weather_code]?.value.toInt() ?? 0,
      windSpeed:
          response.currentData[WeatherCurrent.wind_speed_10m]?.value ?? 0.0,
      windDirection:
          response.currentData[WeatherCurrent.wind_direction_10m]?.value ??
          0.0, // Added wind direction
      humidity:
          response.currentData[WeatherCurrent.relative_humidity_2m]?.value ??
          0.0,
      pressure:
          response.currentData[WeatherCurrent.surface_pressure]?.value ?? 0.0,
      precipitation:
          response.currentData[WeatherCurrent.precipitation]?.value ??
          0.0, // Added precipitation
      locationName: cityName,
      timestamp: DateTime.now(),
      hourlyForecast: _extractHourlyForecast(response),
      dailyForecast: _extractDailyForecast(response),

      // Add air quality data if available
      airQualityIndex:
          airQualityResponse
              ?.currentData[AirQualityCurrent.european_aqi]
              ?.value,
      airQualityComponents: _extractAirQualityComponents(airQualityResponse),
      isDay: response.currentData[WeatherCurrent.is_day]?.value == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'feelsLike': feelsLike,
      'weatherCode': weatherCode,
      'windSpeed': windSpeed,
      'windDirection': windDirection,
      'humidity': humidity,
      'pressure': pressure,
      'precipitation': precipitation,
      'locationName': locationName,
      'timestamp': timestamp.millisecondsSinceEpoch,
      'isDay': isDay,
      'airQualityIndex': airQualityIndex,
      'airQualityComponents': airQualityComponents,
      'hourlyForecast': hourlyForecast.map((h) => h.toJson()).toList(),
      'dailyForecast': dailyForecast.map((d) => d.toJson()).toList(),
    };
  }

  // Create a new factory constructor for JSON
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['temperature'] as double,
      feelsLike: json['feelsLike'] as double,
      weatherCode: json['weatherCode'] as int,
      windSpeed: json['windSpeed'] as double,
      windDirection: json['windDirection'] as double,
      humidity: json['humidity'] as double,
      pressure: json['pressure'] as double,
      precipitation: json['precipitation'] as double,
      locationName: json['locationName'] as String,
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
      isDay: json['isDay'] as bool,
      airQualityIndex: json['airQualityIndex'] as double?,
      airQualityComponents:
          json['airQualityComponents'] != null
              ? Map<String, double>.from(json['airQualityComponents'] as Map)
              : null,
      hourlyForecast:
          (json['hourlyForecast'] as List)
              .map((e) => HourlyForecast.fromJson(e as Map<String, dynamic>))
              .toList(),
      dailyForecast:
          (json['dailyForecast'] as List)
              .map((e) => DailyForecast.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  // Add helper method to extract air quality components
  static Map<String, double>? _extractAirQualityComponents(
    ApiResponse<AirQualityApi>? response,
  ) {
    if (response == null) return null;

    final components = <String, double>{};

    // Extract common air quality components
    final pm10 = response.currentData[AirQualityCurrent.pm10]?.value;
    final pm25 = response.currentData[AirQualityCurrent.pm2_5]?.value;
    final no2 = response.currentData[AirQualityCurrent.nitrogen_dioxide]?.value;
    final o3 = response.currentData[AirQualityCurrent.ozone]?.value;

    if (pm10 != null) components['PM10'] = pm10;
    if (pm25 != null) components['PM2.5'] = pm25;
    if (no2 != null) components['NO2'] = no2;
    if (o3 != null) components['O3'] = o3;

    return components.isEmpty ? null : components;
  }

  static List<HourlyForecast> _extractHourlyForecast(
    ApiResponse<WeatherApi> response,
  ) {
    final List<HourlyForecast> forecasts = [];

    // Get the hourly temperature values
    final tempsMap =
        response.hourlyData[WeatherHourly.temperature_2m]?.values ?? {};
    final codesMap =
        response.hourlyData[WeatherHourly.weather_code]?.values ?? {};
    final visibilityMap =
        response.hourlyData[WeatherHourly.visibility]?.values ?? {};
    final windDirectionMap =
        response.hourlyData[WeatherHourly.wind_direction_10m]?.values ?? {};
    final windSpeedMap =
        response.hourlyData[WeatherHourly.wind_speed_10m]?.values ?? {};
    final uvIndexMap =
        response.hourlyData[WeatherHourly.uv_index]?.values ?? {};
    final isDayMap = response.hourlyData[WeatherHourly.is_day]?.values ?? {};
    final precipitationMap =
        response.hourlyData[WeatherHourly.precipitation]?.values ?? {};
    final humidityMap =
        response.hourlyData[WeatherHourly.relative_humidity_2m]?.values ?? {};
    final times = tempsMap.keys.toList();

    // Create hourly forecasts for the next 24 hours
    final int count = times.length > 24 ? 24 : times.length;

    for (int i = 0; i < count; i++) {
      final time = times[i];
      if (tempsMap.containsKey(time) && codesMap.containsKey(time)) {
        forecasts.add(
          HourlyForecast(
            time: time,
            temperature: tempsMap[time]!.toDouble(),
            weatherCode: codesMap[time]!.toInt(),
            visibility: visibilityMap[time]?.toDouble(),
            windDirection: windDirectionMap[time]?.toDouble(),
            uvIndex: uvIndexMap[time]?.toDouble(),
            isDay: isDayMap[time]?.toInt() == 1,
            windSpeed: windSpeedMap[time]?.toDouble(),
            precipitation: precipitationMap[time]?.toDouble(),
            humidity: humidityMap[time]?.toDouble(),
          ),
        );
      }
    }

    return forecasts;
  }

  static List<DailyForecast> _extractDailyForecast(
    ApiResponse<WeatherApi> response,
  ) {
    final List<DailyForecast> forecasts = [];

    // Get the daily temperature values
    final maxTempsMap =
        response.dailyData[WeatherDaily.temperature_2m_max]?.values ?? {};
    final minTempsMap =
        response.dailyData[WeatherDaily.temperature_2m_min]?.values ?? {};
    final sunriseMap = response.dailyData[WeatherDaily.sunrise]?.values ?? {};
    final sunsetMap = response.dailyData[WeatherDaily.sunset]?.values ?? {};
    final codesMap =
        response.dailyData[WeatherDaily.weather_code]?.values ?? {};
    final times = maxTempsMap.keys.toList();
    final windSpeedMaxDailyMap =
        response.dailyData[WeatherDaily.wind_speed_10m_max]?.values ?? {};
    final precipitationSumMap =
        response.dailyData[WeatherDaily.precipitation_sum]?.values ?? {};

    final uvIndexMaxMap =
        response.dailyData[WeatherDaily.uv_index_max]?.values ?? {};

    // Create daily forecasts
    final int count = times.length;

    for (int i = 0; i < count; i++) {
      final date = times[i];
      if (maxTempsMap.containsKey(date) && minTempsMap.containsKey(date)) {
        // Convert sunrise and sunset from Unix timestamps to DateTime
        DateTime? sunrise;
        DateTime? sunset;

        sunrise = DateTime.fromMillisecondsSinceEpoch(
          (sunriseMap[date] as num).toInt() * 1000,
        );
        sunset = DateTime.fromMillisecondsSinceEpoch(
          (sunsetMap[date] as num).toInt() * 1000,
        );

        forecasts.add(
          DailyForecast(
            date: date,
            maxTemperature: maxTempsMap[date]!.toDouble(),
            minTemperature: minTempsMap[date]!.toDouble(),
            sunrise: sunrise,
            sunset: sunset,
            code: codesMap[date]?.toInt(),
            windSpeedMaxDaily: windSpeedMaxDailyMap[date]?.toDouble(),
            precipitationSum: precipitationSumMap[date]?.toDouble(),
            uvIndexMax: uvIndexMaxMap[date]?.toDouble(),
          ),
        );
      }
    }

    return forecasts;
  }
}

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
