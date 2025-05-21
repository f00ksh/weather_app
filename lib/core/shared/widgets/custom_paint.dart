import 'dart:math' as math;

import 'package:flutter/material.dart';

// Visibility shape painter

class FlowerShapePainter extends CustomPainter {
  final int pointCount;
  final double innerRadiusPercent;
  final double cornerRadius;
  final Color color;

  FlowerShapePainter({
    required this.pointCount,
    required this.innerRadiusPercent,
    required this.cornerRadius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = math.min(size.width, size.height) / 2;
    final innerRadius = outerRadius * innerRadiusPercent;

    final path = Path();

    // Create the points for our flower shape
    List<Offset> points = [];

    // Starting angle adjustment to ensure first petal points upward
    double startAngle = -math.pi / 2;

    for (int i = 0; i < pointCount * 2; i++) {
      // Calculate angle - distribute 2π radians evenly around the circle
      // We multiply by 2 because we have inner and outer points
      final angle = startAngle + (i * math.pi / pointCount);

      // Alternate between outer and inner radius
      final radius = i.isEven ? outerRadius : innerRadius;

      final x = center.dx + radius * math.cos(angle);
      final y = center.dy + radius * math.sin(angle);
      points.add(Offset(x, y));
    }

    if (cornerRadius <= 0 || points.isEmpty) {
      // If no corner radius, just connect the points directly
      path.moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx, points[i].dy);
      }
      path.close();
    } else {
      // With rounded corners
      for (int i = 0; i < points.length; i++) {
        final current = points[i];
        final next = points[(i + 1) % points.length];
        final prev = points[(i - 1 + points.length) % points.length];

        // Calculate vectors to previous and next points
        final toPrev = Offset(prev.dx - current.dx, prev.dy - current.dy);
        final toNext = Offset(next.dx - current.dx, next.dy - current.dy);

        // Calculate distances
        final toPrevLength = math.sqrt(
          toPrev.dx * toPrev.dx + toPrev.dy * toPrev.dy,
        );
        final toNextLength = math.sqrt(
          toNext.dx * toNext.dx + toNext.dy * toNext.dy,
        );

        // Normalized vectors
        final toPrevNorm = Offset(
          toPrev.dx / toPrevLength,
          toPrev.dy / toPrevLength,
        );
        final toNextNorm = Offset(
          toNext.dx / toNextLength,
          toNext.dy / toNextLength,
        );

        // Calculate radius for this corner (can't be more than half the shorter edge)
        final maxRadius = math.min(toPrevLength, toNextLength) / 2.5;
        final actualCornerRadius = math.min(cornerRadius, maxRadius);

        // Corner points
        final cornerPrevPoint = Offset(
          current.dx + toPrevNorm.dx * actualCornerRadius,
          current.dy + toPrevNorm.dy * actualCornerRadius,
        );

        final cornerNextPoint = Offset(
          current.dx + toNextNorm.dx * actualCornerRadius,
          current.dy + toNextNorm.dy * actualCornerRadius,
        );

        // For the first point, we need to move to the first corner point
        if (i == 0) {
          path.moveTo(cornerPrevPoint.dx, cornerPrevPoint.dy);
        } else {
          path.lineTo(cornerPrevPoint.dx, cornerPrevPoint.dy);
        }

        // Add the rounded corner using a quadratic bezier curve
        path.quadraticBezierTo(
          current.dx,
          current.dy,
          cornerNextPoint.dx,
          cornerNextPoint.dy,
        );
      }

      path.close();
    }

    // Draw the shape
    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// Humidity wave painter

class WavePainter extends CustomPainter {
  final Color waveColor;
  final double fillPercent;

  WavePainter({required this.waveColor, required this.fillPercent});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = waveColor
          ..style = PaintingStyle.fill;

    final path = Path();

    // Calculate fill height based on percentage
    final fillHeight = size.height * fillPercent;

    // Start at bottom left
    path.moveTo(0, size.height);

    // Line to the starting point of the wave on the left
    path.lineTo(0, size.height - fillHeight);

    // Wave height
    final waveHeight = 8.0;

    // Create a horizontal wave pattern
    for (int i = 0; i < size.width / 20; i++) {
      path.quadraticBezierTo(
        10 + (i * 40),
        (size.height - fillHeight) - waveHeight,
        20 + (i * 40),
        size.height - fillHeight,
      );
      path.quadraticBezierTo(
        30 + (i * 40),
        (size.height - fillHeight) + waveHeight,
        40 + (i * 40),
        size.height - fillHeight,
      );
    }

    // Complete the path to bottom right
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Pressure gauge painter
class PressureGaugePainter extends CustomPainter {
  final double value; // Value between 0 and 1
  final Color backgroundColor;
  final Color foregroundColor;

  PressureGaugePainter({
    required this.value,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final strokeWidth = radius * 0.15;

    // Draw background arc (full circle with gap at bottom)
    final backgroundPaint =
        Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    // Draw from 135 degrees to 405 degrees (leaving a 60 degree gap at the bottom)
    // 135 degrees is at the bottom-left, 405 degrees (or 45 degrees) is at the bottom-right
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      135 * math.pi / 180, // Start angle in radians
      270 * math.pi / 180, // Sweep angle in radians
      false,
      backgroundPaint,
    );

    // Draw foreground arc based on value
    final foregroundPaint =
        Paint()
          ..color = foregroundColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    // Calculate the sweep angle based on the value (0 to 1)
    // Map the value to the range of 0 to 270 degrees
    final sweepAngle = value * 270 * math.pi / 180;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      135 * math.pi / 180, // Start angle in radians
      sweepAngle, // Sweep angle in radians
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant PressureGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.foregroundColor != foregroundColor;
  }
}

class SunriseSunset extends CustomPainter {
  final Color waveColor;
  final DateTime? currentTime;
  final DateTime? sunriseTime;
  final DateTime? sunsetTime;
  final double mHeight;

  SunriseSunset({
    required this.waveColor,
    this.currentTime,
    this.sunriseTime,
    this.sunsetTime,
    this.mHeight = 0.32,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = waveColor
          ..style = PaintingStyle.fill;

    final path = Path();

    // Fixed mountain height
    final mountainHeight = size.height * mHeight;
    // final horizonY = size.height * 0.6;

    // Start at bottom left
    path.moveTo(0, size.height);

    // Line to the starting point on the left edge
    path.lineTo(0, size.height - mountainHeight * 0.8);

    // Create a mountain with rounded edges
    // First curve from left edge to peak
    path.cubicTo(
      size.width * 0.25,
      size.height - mountainHeight * 1, // First control point
      size.width * 0.3,
      size.height - mountainHeight * 2, // Second control point
      size.width * 0.5,
      size.height - mountainHeight * 1.9, // End point (peak)
    );

    // Second curve from peak to right edge
    path.cubicTo(
      size.width * 0.7,
      size.height - mountainHeight * 1.9, // First control point
      size.width * 0.7,
      size.height - mountainHeight * 1, // Second control point
      size.width,
      size.height - mountainHeight * 0.8, // End point (right edge)
    );

    // Complete the path to bottom right
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);

    // Draw sun if time parameters are provided
    if (currentTime != null && sunriseTime != null && sunsetTime != null) {
      // Convert times to minutes since midnight for calculation
      final currentMinutes = currentTime!.hour * 60 + currentTime!.minute;
      final sunriseMinutes = sunriseTime!.hour * 60 + sunriseTime!.minute;
      final sunsetMinutes = sunsetTime!.hour * 60 + sunsetTime!.minute;

      // Handle case where sunset is on the next day
      final adjustedSunsetMinutes =
          sunsetMinutes < sunriseMinutes
              ? sunsetMinutes + 24 * 60
              : sunsetMinutes;

      // Calculate daylight duration
      final daylightDuration = adjustedSunsetMinutes - sunriseMinutes;

      // Calculate sun progress (0.0 to 1.0)
      double sunProgress;

      if (currentMinutes < sunriseMinutes) {
        // Before sunrise
        sunProgress = 0.0;
      } else if (currentMinutes > adjustedSunsetMinutes) {
        // After sunset
        sunProgress = 1.0;
      } else {
        // During daylight
        sunProgress = (currentMinutes - sunriseMinutes) / daylightDuration;
      }

      // Only draw sun if it's visible (above horizon)
      if (sunProgress > 0.0 && sunProgress < 1.0) {
        // Define the horizon line Y position
        final horizonY = size.height * 0.6;

        // Calculate the intersection points of the horizon with the mountain curve
        // These are approximate values based on the curve parameters
        // Left intersection point (where horizon meets left side of mountain)
        final leftIntersectionX = size.width * 0.15;

        // Right intersection point (where horizon meets right side of mountain)
        final rightIntersectionX = size.width * 0.85;

        // Adjust the sun's X position to stay within the intersection points
        final adjustedSunX =
            leftIntersectionX +
            (rightIntersectionX - leftIntersectionX) * sunProgress;

        // Calculate Y position using the same curve formula as the mountain
        double sunY;

        // Use different curve calculations based on which half of the path we're on
        if (sunProgress <= 0.5) {
          // Left half - use first cubic curve
          final t = sunProgress * 2; // Scale to 0-1 for this half

          // Cubic Bezier formula for Y coordinate
          final p0y = horizonY; // Start point at horizon intersection
          final p1y = size.height - mountainHeight * 1.2; // Control point 1
          final p2y = size.height - mountainHeight * 2; // Control point 2
          final p3y = size.height - mountainHeight * 1.9; // End point (peak)

          sunY =
              (1 - t) * (1 - t) * (1 - t) * p0y +
              3 * (1 - t) * (1 - t) * t * p1y +
              3 * (1 - t) * t * t * p2y +
              t * t * t * p3y;
        } else {
          // Right half - use second cubic curve
          final t = (sunProgress - 0.5) * 2; // Scale to 0-1 for this half

          // Cubic Bezier formula for Y coordinate
          final p0y = size.height - mountainHeight * 1.9; // Start point (peak)
          final p1y = size.height - mountainHeight * 2; // Control point 1
          final p2y = size.height - mountainHeight * 1.2; // Control point 2
          final p3y = horizonY; // End point at horizon intersection

          sunY =
              (1 - t) * (1 - t) * (1 - t) * p0y +
              3 * (1 - t) * (1 - t) * t * p1y +
              3 * (1 - t) * t * t * p2y +
              t * t * t * p3y;
        }

        // Draw white border around the sun
        final sunBorderPaint =
            Paint()
              ..color = Colors.white
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2.0;

        // Draw sun with orange fill
        final sunPaint =
            Paint()
              ..color = Colors.orange
              ..style = PaintingStyle.fill;

        // Draw sun circle with fill
        canvas.drawCircle(
          Offset(adjustedSunX, sunY),
          size.width * 0.05, // Sun radius
          sunPaint,
        );

        // Draw white border around the sun
        canvas.drawCircle(
          Offset(adjustedSunX, sunY),
          size.width * 0.05, // Same radius as the sun
          sunBorderPaint,
        );

        // Draw sun rays
        final rayPaint =
            Paint()
              ..color = Colors.orange
              ..style = PaintingStyle.stroke
              ..strokeWidth = 2;

        // Draw simple rays around the sun
        final rayLength = size.width * 0.02;
        for (int i = 0; i < 8; i++) {
          final angle = i * math.pi / 4;
          final startX = adjustedSunX + math.cos(angle) * size.width * 0.05;
          final startY = sunY + math.sin(angle) * size.width * 0.05;
          final endX =
              adjustedSunX + math.cos(angle) * (size.width * 0.05 + rayLength);
          final endY = sunY + math.sin(angle) * (size.width * 0.05 + rayLength);

          canvas.drawLine(Offset(startX, startY), Offset(endX, endY), rayPaint);
        }

        // Optional: Draw the horizon line for debugging
        // final horizonPaint = Paint()
        //   ..color = Colors.white.withOpacity(0.3)
        //   ..style = PaintingStyle.stroke
        //   ..strokeWidth = 1;
        // canvas.drawLine(
        //   Offset(0, horizonY),
        //   Offset(size.width, horizonY),
        //   horizonPaint,
        // );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class UVIndexIndicatorPainter extends CustomPainter {
  final int?
  selectedIndex; // 0-4 representing which indicator is selected, null for none

  // UV index levels and their respective colors
  final List<Color> levelColors = [
    const Color(0xFF4CAF50), // Strong green
    const Color(0xFFFFC107), // Strong yellow
    const Color(0xFFFF9800), // Strong orange
    const Color(0xFFF44336), // Strong red/pink
    const Color(0xFF9C27B0), // Strong purple
  ];

  UVIndexIndicatorPainter({this.selectedIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.04; // Circle size

    // Calculate positions for the five circles
    final positions = [
      Offset(
        center.dx - size.width * 0.33,
        center.dy + size.height * 0.17,
      ), // Left
      Offset(
        center.dx - size.width * 0.18,
        center.dy + size.height * 0.32,
      ), // Bottom left
      Offset(center.dx, center.dy + size.height * 0.39), // Bottom center
      Offset(
        center.dx + size.width * 0.18,
        center.dy + size.height * 0.32,
      ), // Bottom right
      Offset(
        center.dx + size.width * 0.33,
        center.dy + size.height * .17,
      ), // Right
    ];

    // Draw each circle
    for (int i = 0; i < 5; i++) {
      // Apply opacity to unselected colors
      final color =
          selectedIndex == i
              ? levelColors[i] // Full opacity for selected
              : levelColors[i].withValues(
                alpha: 0.3,
              ); // Add opacity to unselected

      final paint =
          Paint()
            ..color = color
            ..style = PaintingStyle.fill;

      // Draw bigger circle with shadow if selected
      if (selectedIndex == i) {
        // Draw shadow with full opacity color
        final shadowPaint = Paint()..color = levelColors[i];
        canvas.drawCircle(positions[i], radius * 1.1, shadowPaint);

        // Draw the selected circle slightly larger
        canvas.drawCircle(positions[i], radius * 1.25, paint);
      } else {
        canvas.drawCircle(positions[i], radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(UVIndexIndicatorPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex;
  }
}
