import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/routes/app_routes.dart';

import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/src/drag_callbacks.dart';
import 'package:weather_app/src/drag_gridview.dart';
import 'package:weather_app/src/models.dart';
import 'package:weather_app/viewmodels/dashboard_layout_provider.dart';
import 'package:weather_app/views/pages/weather_detail_factory.dart';
import 'package:weather_app/views/widgets/home_page/air_quality/air_quality_widget.dart';
import 'package:weather_app/views/widgets/home_page/daily/daily_forecast_card.dart';
import 'package:weather_app/views/widgets/home_page/humidity/humidity_widget.dart';
import 'package:weather_app/views/widgets/home_page/precipitation/precipitation_widget.dart';
import 'package:weather_app/views/widgets/home_page/pressure/pressure_widget.dart';
import 'package:weather_app/views/widgets/home_page/sunrise_sunset/sunrise_sunset_widget.dart';
import 'package:weather_app/views/widgets/home_page/uv_index/uv_inedx_widget.dart';
import 'package:weather_app/views/widgets/home_page/visibility/visibility_widget.dart';
import 'package:weather_app/views/widgets/home_page/wind/wind_widget.dart';

class WeatherDashboard extends ConsumerWidget {
  final WeatherModel weather;

  const WeatherDashboard({super.key, required this.weather});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Add a key based on the weather timestamp to force rebuild when weather changes
    final dashboardKey = ValueKey(
      'dashboard-${weather.timestamp.millisecondsSinceEpoch}-${MediaQuery.of(context).orientation}',
    );

    // Get the layout from the provider
    final widgetLayout = ref.watch(dashboardLayoutProvider);
    final layoutNotifier = ref.read(dashboardLayoutProvider.notifier);

    return DragGridView(
      key: dashboardKey,
      enableReordering: true,
      draggingWidgetOpacity: 0,

      edgeScroll: .3,
      buildFeedback:
          (item, widget, size) => Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            child: widget,
          ),
      dragCallbacks: DragCallbacks(
        onAccept: (moveData, data, isFront, {acceptDetails}) {
          if (moveData == null || acceptDetails == null) return;
          final oldIndex = acceptDetails.oldIndex;
          final newIndex = acceptDetails.newIndex;

          if (oldIndex != newIndex) {
            // Reorder the items
            layoutNotifier.reorderItems(oldIndex, newIndex);
          }
        },
      ),
      crossAxisCount: 2,
      children:
          widgetLayout.map((item) {
            // Create widget based on the key
            return DragGridCountItem(
              key: ValueKey(item.key),
              widget: GestureDetector(
                child: _buildWidgetForKey(item.key),
                onTap: () => _navigateToDetailPage(context, item.key),
              ),
              mainAxisCellCount: item.mainAxisCellCount,
              crossAxisCellCount: item.crossAxisCellCount,
            );
          }).toList(),
    );
  }

  // Helper method to build the appropriate widget based on the key
  Widget _buildWidgetForKey(String key) {
    switch (key) {
      case 'daily_forecast':
        return DailyForecastCard(weather: weather);
      case 'precipitation':
        return PrecipitationWidget(weather: weather);
      case 'wind':
        return WindWidget(weather: weather);
      case 'sunrise_sunset':
        return SunriseSunsetWidget(weather: weather);
      case 'air_quality':
        return AirQualityWidget(weather: weather);
      case 'visibility':
        return VisibilityWidget(weather: weather);
      case 'uv_index':
        return UvIndexWidget(weather: weather);
      case 'humidity':
        return HumidityWidget(weather: weather);
      case 'pressure':
        return PressureWidget(weather: weather);
      default:
        return Container(color: Colors.grey.shade200);
    }
  }

  void _navigateToDetailPage(BuildContext context, String key) {
    // Map the string key to the appropriate detail type
    WeatherDetailType? detailType;

    switch (key) {
      case 'precipitation':
        detailType = WeatherDetailType.precipitation;
        break;
      case 'wind':
        detailType = WeatherDetailType.wind;
        break;
      case 'visibility':
        detailType = WeatherDetailType.visibility;
        break;
      case 'uv_index':
        detailType = WeatherDetailType.uvIndex;
        break;
      case 'humidity':
        detailType = WeatherDetailType.humidity;
        break;
      case 'pressure':
        detailType = WeatherDetailType.pressure;
        break;
      case 'air_quality':
        detailType = WeatherDetailType.airQuality;
        break;
      case 'sunrise_sunset':
        detailType = WeatherDetailType.sunriseSunset;
        break;

      default:
        return;
    }

    // Only navigate if we have a valid detail type
    Navigator.pushNamed(
      context,
      AppRoutes.weatherDetail,
      arguments: {'detailType': detailType, 'weather': weather},
    );
  }
}
