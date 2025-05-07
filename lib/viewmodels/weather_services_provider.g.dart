// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_services_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherServiceHash() => r'33c87f2deaa2c0bda3a71662a3eefe8ac49fd1d4';

/// See also [weatherService].
@ProviderFor(weatherService)
final weatherServiceProvider = AutoDisposeProvider<WeatherService>.internal(
  weatherService,
  name: r'weatherServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$weatherServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeatherServiceRef = AutoDisposeProviderRef<WeatherService>;
String _$currentWeatherHash() => r'91252821ca996e82abf0765544db39d24be0aaa5';

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

/// See also [currentWeather].
@ProviderFor(currentWeather)
const currentWeatherProvider = CurrentWeatherFamily();

/// See also [currentWeather].
class CurrentWeatherFamily extends Family<AsyncValue<CurrentWeather>> {
  /// See also [currentWeather].
  const CurrentWeatherFamily();

  /// See also [currentWeather].
  CurrentWeatherProvider call(String city) {
    return CurrentWeatherProvider(city);
  }

  @override
  CurrentWeatherProvider getProviderOverride(
    covariant CurrentWeatherProvider provider,
  ) {
    return call(provider.city);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'currentWeatherProvider';
}

/// See also [currentWeather].
class CurrentWeatherProvider extends AutoDisposeFutureProvider<CurrentWeather> {
  /// See also [currentWeather].
  CurrentWeatherProvider(String city)
    : this._internal(
        (ref) => currentWeather(ref as CurrentWeatherRef, city),
        from: currentWeatherProvider,
        name: r'currentWeatherProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$currentWeatherHash,
        dependencies: CurrentWeatherFamily._dependencies,
        allTransitiveDependencies:
            CurrentWeatherFamily._allTransitiveDependencies,
        city: city,
      );

  CurrentWeatherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.city,
  }) : super.internal();

  final String city;

  @override
  Override overrideWith(
    FutureOr<CurrentWeather> Function(CurrentWeatherRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CurrentWeatherProvider._internal(
        (ref) => create(ref as CurrentWeatherRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        city: city,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<CurrentWeather> createElement() {
    return _CurrentWeatherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CurrentWeatherProvider && other.city == city;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, city.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CurrentWeatherRef on AutoDisposeFutureProviderRef<CurrentWeather> {
  /// The parameter `city` of this provider.
  String get city;
}

class _CurrentWeatherProviderElement
    extends AutoDisposeFutureProviderElement<CurrentWeather>
    with CurrentWeatherRef {
  _CurrentWeatherProviderElement(super.provider);

  @override
  String get city => (origin as CurrentWeatherProvider).city;
}

String _$forecastHash() => r'e0a125f394e09e489a29dfbefa7daf6ca2c74378';

/// See also [forecast].
@ProviderFor(forecast)
const forecastProvider = ForecastFamily();

/// See also [forecast].
class ForecastFamily extends Family<AsyncValue<List<ForecastEntry>>> {
  /// See also [forecast].
  const ForecastFamily();

  /// See also [forecast].
  ForecastProvider call(String city) {
    return ForecastProvider(city);
  }

  @override
  ForecastProvider getProviderOverride(covariant ForecastProvider provider) {
    return call(provider.city);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'forecastProvider';
}

/// See also [forecast].
class ForecastProvider extends AutoDisposeFutureProvider<List<ForecastEntry>> {
  /// See also [forecast].
  ForecastProvider(String city)
    : this._internal(
        (ref) => forecast(ref as ForecastRef, city),
        from: forecastProvider,
        name: r'forecastProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$forecastHash,
        dependencies: ForecastFamily._dependencies,
        allTransitiveDependencies: ForecastFamily._allTransitiveDependencies,
        city: city,
      );

  ForecastProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.city,
  }) : super.internal();

  final String city;

  @override
  Override overrideWith(
    FutureOr<List<ForecastEntry>> Function(ForecastRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ForecastProvider._internal(
        (ref) => create(ref as ForecastRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        city: city,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ForecastEntry>> createElement() {
    return _ForecastProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ForecastProvider && other.city == city;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, city.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ForecastRef on AutoDisposeFutureProviderRef<List<ForecastEntry>> {
  /// The parameter `city` of this provider.
  String get city;
}

class _ForecastProviderElement
    extends AutoDisposeFutureProviderElement<List<ForecastEntry>>
    with ForecastRef {
  _ForecastProviderElement(super.provider);

  @override
  String get city => (origin as ForecastProvider).city;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
