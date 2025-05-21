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
String _$weatherViewModelHash() => r'94d33da83b541ed5c8abf72d008c78b00baa7c01';

/// See also [WeatherViewModel].
@ProviderFor(WeatherViewModel)
final weatherViewModelProvider =
    AutoDisposeAsyncNotifierProvider<WeatherViewModel, WeatherModel>.internal(
      WeatherViewModel.new,
      name: r'weatherViewModelProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$weatherViewModelHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WeatherViewModel = AutoDisposeAsyncNotifier<WeatherModel>;
String _$cityWeatherProviderHash() =>
    r'5a91c6e407504ef513619096bbfbb5f25c579f63';

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

abstract class _$CityWeatherProvider
    extends BuildlessAutoDisposeAsyncNotifier<WeatherModel> {
  late final double latitude;
  late final double longitude;

  FutureOr<WeatherModel> build(double latitude, double longitude);
}

///// Provider for the cities weather service//////
///
/// Copied from [CityWeatherProvider].
@ProviderFor(CityWeatherProvider)
const cityWeatherProviderProvider = CityWeatherProviderFamily();

///// Provider for the cities weather service//////
///
/// Copied from [CityWeatherProvider].
class CityWeatherProviderFamily extends Family<AsyncValue<WeatherModel>> {
  ///// Provider for the cities weather service//////
  ///
  /// Copied from [CityWeatherProvider].
  const CityWeatherProviderFamily();

  ///// Provider for the cities weather service//////
  ///
  /// Copied from [CityWeatherProvider].
  CityWeatherProviderProvider call(double latitude, double longitude) {
    return CityWeatherProviderProvider(latitude, longitude);
  }

  @override
  CityWeatherProviderProvider getProviderOverride(
    covariant CityWeatherProviderProvider provider,
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
  String? get name => r'cityWeatherProviderProvider';
}

///// Provider for the cities weather service//////
///
/// Copied from [CityWeatherProvider].
class CityWeatherProviderProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          CityWeatherProvider,
          WeatherModel
        > {
  ///// Provider for the cities weather service//////
  ///
  /// Copied from [CityWeatherProvider].
  CityWeatherProviderProvider(double latitude, double longitude)
    : this._internal(
        () =>
            CityWeatherProvider()
              ..latitude = latitude
              ..longitude = longitude,
        from: cityWeatherProviderProvider,
        name: r'cityWeatherProviderProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$cityWeatherProviderHash,
        dependencies: CityWeatherProviderFamily._dependencies,
        allTransitiveDependencies:
            CityWeatherProviderFamily._allTransitiveDependencies,
        latitude: latitude,
        longitude: longitude,
      );

  CityWeatherProviderProvider._internal(
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
  FutureOr<WeatherModel> runNotifierBuild(
    covariant CityWeatherProvider notifier,
  ) {
    return notifier.build(latitude, longitude);
  }

  @override
  Override overrideWith(CityWeatherProvider Function() create) {
    return ProviderOverride(
      origin: this,
      override: CityWeatherProviderProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<CityWeatherProvider, WeatherModel>
  createElement() {
    return _CityWeatherProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CityWeatherProviderProvider &&
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
mixin CityWeatherProviderRef
    on AutoDisposeAsyncNotifierProviderRef<WeatherModel> {
  /// The parameter `latitude` of this provider.
  double get latitude;

  /// The parameter `longitude` of this provider.
  double get longitude;
}

class _CityWeatherProviderProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          CityWeatherProvider,
          WeatherModel
        >
    with CityWeatherProviderRef {
  _CityWeatherProviderProviderElement(super.provider);

  @override
  double get latitude => (origin as CityWeatherProviderProvider).latitude;
  @override
  double get longitude => (origin as CityWeatherProviderProvider).longitude;
}

String _$currentLocationWeatherProviderHash() =>
    r'c4814129ab684378a2240136caea31cb22b866e4'; //// Provider for the current location weather service //////
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
