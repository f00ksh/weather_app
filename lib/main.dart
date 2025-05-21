import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/routes/app_routes.dart';
import 'package:weather_app/core/theme/app_dimension.dart';
import 'package:weather_app/core/theme/theme_provider.dart';
import 'package:weather_app/services/background_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      observers: [
        // ... existing observers if any
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize weather notifications
    ref.watch(weatherNotificationsProvider);

    // Watch the theme mode provider to get the current theme mode
    final themeMode = ref.watch(themeModeProvider);

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        // Dynamic color is available and enabled, use it
        final lightColorScheme = lightDynamic?.harmonized();
        final darkColorScheme = darkDynamic?.harmonized();

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather App',
          theme: ThemeData(colorScheme: lightColorScheme),
          darkTheme: ThemeData(colorScheme: darkColorScheme),
          themeMode: themeMode,
          initialRoute: AppRoutes.home, // Start with home page
          routes: AppRouter.routes,
          builder: (context, child) {
            // Initialize AppDimension here
            AppDimension.init(context);
            return child ?? const SizedBox.shrink();
          },
        );
      },
    );
  }
}
