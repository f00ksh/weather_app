// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$themeModeHash() => r'd6b0711529f33053d8add048796bbdd0f86cfcc7';

/// Provider that determines the app theme mode based on various factors
///
/// Copied from [themeMode].
@ProviderFor(themeMode)
final themeModeProvider = AutoDisposeProvider<ThemeMode>.internal(
  themeMode,
  name: r'themeModeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeModeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeModeRef = AutoDisposeProviderRef<ThemeMode>;
String _$themeHash() => r'eca54a9293e5ad077ab643729af96c5eb2d106ea';

/// Provider that determines the app theme based on sunrise and sunset times
///
/// Copied from [theme].
@ProviderFor(theme)
final themeProvider = AutoDisposeProvider<ThemeData>.internal(
  theme,
  name: r'themeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$themeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ThemeRef = AutoDisposeProviderRef<ThemeData>;
String _$themeSelectionModeNotifierHash() =>
    r'dd812f42e7612869af16838c978f6535f55e92ea';

/// Provider for the user's theme selection mode preference
///
/// Copied from [ThemeSelectionModeNotifier].
@ProviderFor(ThemeSelectionModeNotifier)
final themeSelectionModeNotifierProvider = AutoDisposeNotifierProvider<
  ThemeSelectionModeNotifier,
  ThemeSelectionMode
>.internal(
  ThemeSelectionModeNotifier.new,
  name: r'themeSelectionModeNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$themeSelectionModeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeSelectionModeNotifier = AutoDisposeNotifier<ThemeSelectionMode>;
String _$manualThemeModeHash() => r'fd78985466062ba21a70ebfc7f0c74a43b842458';

/// Provider for manually selected theme (only used when in manual mode)
///
/// Copied from [ManualThemeMode].
@ProviderFor(ManualThemeMode)
final manualThemeModeProvider =
    AutoDisposeNotifierProvider<ManualThemeMode, ThemeMode>.internal(
      ManualThemeMode.new,
      name: r'manualThemeModeProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$manualThemeModeHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ManualThemeMode = AutoDisposeNotifier<ThemeMode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
