// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$searchResultsHash() => r'1fb6548eb12d61a4f6555f687ecc4c77f19257bd';

/// See also [searchResults].
@ProviderFor(searchResults)
final searchResultsProvider =
    AutoDisposeFutureProvider<List<CityLocation>>.internal(
      searchResults,
      name: r'searchResultsProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$searchResultsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SearchResultsRef = AutoDisposeFutureProviderRef<List<CityLocation>>;
String _$searchQueryHash() => r'cfb92c9c423175bb3bca7e8f0b4dcf5117b65b2c';

/// See also [SearchQuery].
@ProviderFor(SearchQuery)
final searchQueryProvider =
    AutoDisposeNotifierProvider<SearchQuery, String>.internal(
      SearchQuery.new,
      name: r'searchQueryProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$searchQueryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SearchQuery = AutoDisposeNotifier<String>;
String _$selectedCityFromSearchHash() =>
    r'1f1df80c0d2b1c2617011bc11875463fe747e2f7';

/// See also [SelectedCityFromSearch].
@ProviderFor(SelectedCityFromSearch)
final selectedCityFromSearchProvider =
    AutoDisposeNotifierProvider<SelectedCityFromSearch, CityLocation?>.internal(
      SelectedCityFromSearch.new,
      name: r'selectedCityFromSearchProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$selectedCityFromSearchHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedCityFromSearch = AutoDisposeNotifier<CityLocation?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
