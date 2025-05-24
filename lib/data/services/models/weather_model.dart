import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class Weather {
  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  String? cityName;
  double? temperature;
  String? mainCondition;

  factory Weather.fromJson(Map<String, Object?> json) =>
      _$WeatherFromJson(json);
}
