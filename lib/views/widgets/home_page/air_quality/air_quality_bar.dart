import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/app_dimension.dart';

class AirQualityBar extends StatelessWidget {
  final int aqi;

  const AirQualityBar({super.key, required this.aqi});

  // Helper method to build a color segment with optional indicator
  Widget _buildColorSegment(Color color, double flex, bool showIndicator) {
    return Expanded(
      flex: flex.toInt(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: AppDimension.airQualityBarHight,
            decoration: BoxDecoration(color: color),
          ),
          if (showIndicator)
            Container(
              height: AppDimension.indicatorHight,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          _buildColorSegment(
            const Color.fromARGB(255, 78, 206, 82),
            1,
            aqi >= 0 && aqi <= 50,
          ),
          _buildColorSegment(
            const Color.fromARGB(255, 248, 225, 17),
            1,
            aqi > 50 && aqi <= 100,
          ),
          _buildColorSegment(
            const Color.fromARGB(255, 218, 134, 9),
            1,
            aqi > 100 && aqi <= 150,
          ),
          _buildColorSegment(
            const Color.fromARGB(255, 214, 24, 10),
            1,
            aqi > 150 && aqi <= 200,
          ),
          _buildColorSegment(
            const Color.fromARGB(255, 126, 20, 145),
            1,
            aqi > 200 && aqi <= 300,
          ),
          _buildColorSegment(Colors.brown.shade800, 1, aqi > 300),
        ],
      ),
    );
  }
}
