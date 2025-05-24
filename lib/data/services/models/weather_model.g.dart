// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
  cityName: json['cityName'] as String,
  temperature: (json['temperature'] as num).toDouble(),
  mainCondition: json['mainCondition'] as String,
);

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
  'cityName': instance.cityName,
  'temperature': instance.temperature,
  'mainCondition': instance.mainCondition,
};
