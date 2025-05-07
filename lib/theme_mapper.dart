import 'package:flutter/material.dart';

LinearGradient getGradientForWeather(String description) {
  final desc = description.toLowerCase();
  if (desc.contains('clear')) {
    return const LinearGradient(
      colors: [Color(0xFF56CCF2), Color(0xFF2F80ED)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  } else if (desc.contains('cloud')) {
    return const LinearGradient(
      colors: [Color(0xFF757F9A), Color(0xFFD7DDE8)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  } else if (desc.contains('rain')) {
    return const LinearGradient(
      colors: [Color(0xFF314755), Color(0xFF26A0DA)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  } else if (desc.contains('snow')) {
    return const LinearGradient(
      colors: [Color(0xFFE0EAFC), Color(0xFFCFDEF3)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  } else if (desc.contains('thunder')) {
    return const LinearGradient(
      colors: [Color(0xFF373B44), Color(0xFF4286f4)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  } else {
    // Default gradient
    return const LinearGradient(
      colors: [Color(0xFF83a4d4), Color(0xFFb6fbff)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
}