// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherCacheServiceHash() =>
    r'1a0fca8f26e99776690ab3c28b19ab644dc810c7'; ///// Provider for the weather cache service//////
///
/// Copied from [weatherCacheService].
@ProviderFor(weatherCacheService)
final weatherCacheServiceProvider =
    AutoDisposeProvider<WeatherCacheService>.internal(
      weatherCacheService,
      name: r'weatherCacheServiceProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$weatherCacheServiceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeatherCacheServiceRef = AutoDisposeProviderRef<WeatherCacheService>;
String _$weatherHash() => r'e0b04f7282ff15cb48bdde5def75847fdaad4204';

/// See also [Weather].
@ProviderFor(Weather)
final weatherProvider =
    AutoDisposeAsyncNotifierProvider<Weather, WeatherModel>.internal(
      Weather.new,
      name: r'weatherProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product') ? null : _$weatherHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Weather = AutoDisposeAsyncNotifier<WeatherModel>;
String _$cityWeatherHash() => r'356b5f2a1819aa790aac9104b1e41e8cf1f438dc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$CityWeather
    extends BuildlessAutoDisposeAsyncNotifier<WeatherModel> {
  late final double latitude;
  late final double longitude;

  FutureOr<WeatherModel> build(double latitude, double longitude);
}

///// Provider for the cities weather service//////
///
/// Copied from [CityWeather].
@ProviderFor(CityWeather)
const cityWeatherProvider = CityWeatherFamily();

///// Provider for the cities weather service//////
///
/// Copied from [CityWeather].
class CityWeatherFamily extends Family<AsyncValue<WeatherModel>> {
  ///// Provider for the cities weather service//////
  ///
  /// Copied from [CityWeather].
  const CityWeatherFamily();

  ///// Provider for the cities weather service//////
  ///
  /// Copied from [CityWeather].
  CityWeatherProvider call(double latitude, double longitude) {
    return CityWeatherProvider(latitude, longitude);
  }

  @override
  CityWeatherProvider getProviderOverride(
    covariant CityWeatherProvider provider,
  ) {
    return call(provider.latitude, provider.longitude);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cityWeatherProvider';
}

///// Provider for the cities weather service//////
///
/// Copied from [CityWeather].
class CityWeatherProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CityWeather, WeatherModel> {
  ///// Provider for the cities weather service//////
  ///
  /// Copied from [CityWeather].
  CityWeatherProvider(double latitude, double longitude)
    : this._internal(
        () =>
            CityWeather()
              ..latitude = latitude
              ..longitude = longitude,
        from: cityWeatherProvider,
        name: r'cityWeatherProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$cityWeatherHash,
        dependencies: CityWeatherFamily._dependencies,
        allTransitiveDependencies: CityWeatherFamily._allTransitiveDependencies,
        latitude: latitude,
        longitude: longitude,
      );

  CityWeatherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.latitude,
    required this.longitude,
  }) : super.internal();

  final double latitude;
  final double longitude;

  @override
  FutureOr<WeatherModel> runNotifierBuild(covariant CityWeather notifier) {
    return notifier.build(latitude, longitude);
  }

  @override
  Override overrideWith(CityWeather Function() create) {
    return ProviderOverride(
      origin: this,
      override: CityWeatherProvider._internal(
        () =>
            create()
              ..latitude = latitude
              ..longitude = longitude,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CityWeather, WeatherModel>
  createElement() {
    return _CityWeatherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CityWeatherProvider &&
        other.latitude == latitude &&
        other.longitude == longitude;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, latitude.hashCode);
    hash = _SystemHash.combine(hash, longitude.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CityWeatherRef on AutoDisposeAsyncNotifierProviderRef<WeatherModel> {
  /// The parameter `latitude` of this provider.
  double get latitude;

  /// The parameter `longitude` of this provider.
  double get longitude;
}

class _CityWeatherProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CityWeather, WeatherModel>
    with CityWeatherRef {
  _CityWeatherProviderElement(super.provider);

  @override
  double get latitude => (origin as CityWeatherProvider).latitude;
  @override
  double get longitude => (origin as CityWeatherProvider).longitude;
}

String _$currentLocationWeatherProviderHash() =>
    r'0fa302be63e4f2fe6377a2e672177ceed9bc9ea1'; //// Provider for the current location weather service //////
///
/// Copied from [CurrentLocationWeatherProvider].
@ProviderFor(CurrentLocationWeatherProvider)
final currentLocationWeatherProviderProvider = AutoDisposeAsyncNotifierProvider<
  CurrentLocationWeatherProvider,
  WeatherModel
>.internal(
  CurrentLocationWeatherProvider.new,
  name: r'currentLocationWeatherProviderProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentLocationWeatherProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentLocationWeatherProvider =
    AutoDisposeAsyncNotifier<WeatherModel>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
