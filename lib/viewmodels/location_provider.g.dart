// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationServiceHash() => r'38d15292e1d1d4553c8f07a36b00411aa0a8d30e';

/// See also [locationService].
@ProviderFor(locationService)
final locationServiceProvider = AutoDisposeProvider<LocationService>.internal(
  locationService,
  name: r'locationServiceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$locationServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationServiceRef = AutoDisposeProviderRef<LocationService>;
String _$currentLocationHash() => r'ed640916be2f525d5ba70dc55e016fe93cd59c3e';

/// See also [currentLocation].
@ProviderFor(currentLocation)
final currentLocationProvider = AutoDisposeFutureProvider<Position?>.internal(
  currentLocation,
  name: r'currentLocationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$currentLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentLocationRef = AutoDisposeFutureProviderRef<Position?>;
String _$currentCityHash() => r'b487fcd8a9e0030489b0fba14467ef8d45c3cfbb';

/// See also [currentCity].
@ProviderFor(currentCity)
final currentCityProvider = AutoDisposeFutureProvider<String>.internal(
  currentCity,
  name: r'currentCityProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentCityHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentCityRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
