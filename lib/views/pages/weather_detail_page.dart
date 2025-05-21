import 'package:flutter/material.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherDetailPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final WeatherModel weather;
  final Widget buildVisualization;
  final Widget? infoRow;
  final String info;
  final EdgeInsets? padding;

  const WeatherDetailPage({
    super.key,
    required this.title,
    required this.icon,
    required this.weather,
    required this.buildVisualization,
    required this.info,
    this.padding,
    this.infoRow,
  });

  @override
  Widget build(BuildContext context) {
    final surfaceContainer = Theme.of(
      context,
    ).colorScheme.outlineVariant.withValues(alpha: .5);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 8),
            Text(title),
          ],
        ),

        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Data visualization section
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    width: double.infinity,

                    padding: padding ?? const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: surfaceContainer,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: buildVisualization,
                  ),
                ),
                const SizedBox(height: 24),
                // Info row section
                if (infoRow != null)
                  Padding(padding: const EdgeInsets.all(6.0), child: infoRow!),
                // Detail text section
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    info,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
