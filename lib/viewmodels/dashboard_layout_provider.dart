import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a class to represent a dashboard widget item
class DashboardWidgetItem {
  final String key;
  final int mainAxisCellCount;
  final int crossAxisCellCount;

  DashboardWidgetItem({
    required this.key,
    required this.mainAxisCellCount,
    required this.crossAxisCellCount,
  });

  // Convert to and from JSON
  Map<String, dynamic> toJson() => {
    'key': key,
    'mainAxisCellCount': mainAxisCellCount,
    'crossAxisCellCount': crossAxisCellCount,
  };

  factory DashboardWidgetItem.fromJson(Map<String, dynamic> json) {
    return DashboardWidgetItem(
      key: json['key'],
      mainAxisCellCount: json['mainAxisCellCount'],
      crossAxisCellCount: json['crossAxisCellCount'],
    );
  }
}

// Define the provider
class DashboardLayoutNotifier extends StateNotifier<List<DashboardWidgetItem>> {
  static const String _prefsKey = 'dashboard_layout';

  DashboardLayoutNotifier() : super([]) {
    // Initialize with empty list, then immediately load saved layout or default
    _initializeLayout();
  }

  // Initialize layout - first try to load saved, fallback to default
  Future<void> _initializeLayout() async {
    final savedLayout = await _loadSavedLayout();
    if (savedLayout != null && savedLayout.isNotEmpty) {
      // Use saved layout if available
      state = savedLayout;
    } else {
      // Fallback to default layout
      state = _getDefaultLayout();
    }
  }

  // Default layout - matches your current order
  static List<DashboardWidgetItem> _getDefaultLayout() {
    return [
      DashboardWidgetItem(
        key: 'daily_forecast',
        mainAxisCellCount: 1,
        crossAxisCellCount: 2,
      ),
      DashboardWidgetItem(
        key: 'precipitation',
        mainAxisCellCount: 1,
        crossAxisCellCount: 1,
      ),
      DashboardWidgetItem(
        key: 'wind',
        mainAxisCellCount: 1,
        crossAxisCellCount: 1,
      ),
      DashboardWidgetItem(
        key: 'sunrise_sunset',
        mainAxisCellCount: 1,
        crossAxisCellCount: 1,
      ),
      DashboardWidgetItem(
        key: 'air_quality',
        mainAxisCellCount: 1,
        crossAxisCellCount: 1,
      ),
      DashboardWidgetItem(
        key: 'visibility',
        mainAxisCellCount: 1,
        crossAxisCellCount: 1,
      ),
      DashboardWidgetItem(
        key: 'uv_index',
        mainAxisCellCount: 1,
        crossAxisCellCount: 1,
      ),
      DashboardWidgetItem(
        key: 'humidity',
        mainAxisCellCount: 1,
        crossAxisCellCount: 1,
      ),
      DashboardWidgetItem(
        key: 'pressure',
        mainAxisCellCount: 1,
        crossAxisCellCount: 1,
      ),
    ];
  }

  // Update layout when widgets are reordered
  void reorderItems(int oldIndex, int newIndex) {
    // Handle the reordering logic
    if (oldIndex != newIndex) {
      final newState = List<DashboardWidgetItem>.from(state);
      final newItem = newState.removeAt(oldIndex);
      newState.insert(newIndex, newItem);
      state = newState;

      // Save the updated layout
      _saveLayout();
    }
  }

  // Save the current layout to SharedPreferences
  Future<void> _saveLayout() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((item) => item.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await prefs.setString(_prefsKey, jsonString);
  }

  // Load saved layout from SharedPreferences
  Future<List<DashboardWidgetItem>?> _loadSavedLayout() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);

    if (jsonString != null) {
      final jsonList = jsonDecode(jsonString) as List;
      final loadedItems =
          jsonList.map((json) => DashboardWidgetItem.fromJson(json)).toList();

      if (loadedItems.isNotEmpty) {
        return loadedItems;
      }
    }
    return null;
  }

  // Reset to default layout
  void resetToDefault() {
    state = _getDefaultLayout();
    _saveLayout();
  }
}

// Create the provider
final dashboardLayoutProvider =
    StateNotifierProvider<DashboardLayoutNotifier, List<DashboardWidgetItem>>(
      (ref) => DashboardLayoutNotifier(),
    );
