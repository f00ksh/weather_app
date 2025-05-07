// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'forecast_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ForecastEntry {

 String get city; double get temp; String get description; String get icon; int get humidity; double get windSpeed; DateTime get timestamp;
/// Create a copy of ForecastEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ForecastEntryCopyWith<ForecastEntry> get copyWith => _$ForecastEntryCopyWithImpl<ForecastEntry>(this as ForecastEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ForecastEntry&&(identical(other.city, city) || other.city == city)&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,city,temp,description,icon,humidity,windSpeed,timestamp);

@override
String toString() {
  return 'ForecastEntry(city: $city, temp: $temp, description: $description, icon: $icon, humidity: $humidity, windSpeed: $windSpeed, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ForecastEntryCopyWith<$Res>  {
  factory $ForecastEntryCopyWith(ForecastEntry value, $Res Function(ForecastEntry) _then) = _$ForecastEntryCopyWithImpl;
@useResult
$Res call({
 String city, double temp, String description, String icon, int humidity, double windSpeed, DateTime timestamp
});




}
/// @nodoc
class _$ForecastEntryCopyWithImpl<$Res>
    implements $ForecastEntryCopyWith<$Res> {
  _$ForecastEntryCopyWithImpl(this._self, this._then);

  final ForecastEntry _self;
  final $Res Function(ForecastEntry) _then;

/// Create a copy of ForecastEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? temp = null,Object? description = null,Object? icon = null,Object? humidity = null,Object? windSpeed = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,temp: null == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc


class _ForecastEntry implements ForecastEntry {
  const _ForecastEntry({required this.city, required this.temp, required this.description, required this.icon, required this.humidity, required this.windSpeed, required this.timestamp});
  

@override final  String city;
@override final  double temp;
@override final  String description;
@override final  String icon;
@override final  int humidity;
@override final  double windSpeed;
@override final  DateTime timestamp;

/// Create a copy of ForecastEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ForecastEntryCopyWith<_ForecastEntry> get copyWith => __$ForecastEntryCopyWithImpl<_ForecastEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ForecastEntry&&(identical(other.city, city) || other.city == city)&&(identical(other.temp, temp) || other.temp == temp)&&(identical(other.description, description) || other.description == description)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.humidity, humidity) || other.humidity == humidity)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}


@override
int get hashCode => Object.hash(runtimeType,city,temp,description,icon,humidity,windSpeed,timestamp);

@override
String toString() {
  return 'ForecastEntry(city: $city, temp: $temp, description: $description, icon: $icon, humidity: $humidity, windSpeed: $windSpeed, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ForecastEntryCopyWith<$Res> implements $ForecastEntryCopyWith<$Res> {
  factory _$ForecastEntryCopyWith(_ForecastEntry value, $Res Function(_ForecastEntry) _then) = __$ForecastEntryCopyWithImpl;
@override @useResult
$Res call({
 String city, double temp, String description, String icon, int humidity, double windSpeed, DateTime timestamp
});




}
/// @nodoc
class __$ForecastEntryCopyWithImpl<$Res>
    implements _$ForecastEntryCopyWith<$Res> {
  __$ForecastEntryCopyWithImpl(this._self, this._then);

  final _ForecastEntry _self;
  final $Res Function(_ForecastEntry) _then;

/// Create a copy of ForecastEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? temp = null,Object? description = null,Object? icon = null,Object? humidity = null,Object? windSpeed = null,Object? timestamp = null,}) {
  return _then(_ForecastEntry(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,temp: null == temp ? _self.temp : temp // ignore: cast_nullable_to_non_nullable
as double,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,humidity: null == humidity ? _self.humidity : humidity // ignore: cast_nullable_to_non_nullable
as int,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
