import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/views/pages/cities_page.dart';
import 'package:weather_app/views/pages/home_page.dart';
import 'package:weather_app/views/pages/search_page.dart';
import 'package:weather_app/views/pages/weather_detail_factory.dart';

class AppRoutes {
  static const String cities = '/';
  static const String home = '/home';
  static const String search = '/search';
  static const String weatherDetail = '/home/detail';
}

class AppRouter {
  static Map<String, Widget Function(BuildContext)> routes = {
    AppRoutes.cities:
        (context) => PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, _) async {
            // Exit the app when back is pressed from cities page
            SystemNavigator.pop();
          },
          child: const CitiesPage(),
        ),
    AppRoutes.home: (context) => const HomePage(),
    AppRoutes.search: (context) => const SearchPage(),
    AppRoutes.weatherDetail: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final detailType = args['detailType'] as WeatherDetailType;
      final weather = args['weather'] as WeatherModel;

      return WeatherDetailFactory.createDetailPage(detailType, weather);
    },
  };

  // Handle back button behavior for HomePage
  static void handleHomePageBackButton(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoutes.cities);
  }
}
