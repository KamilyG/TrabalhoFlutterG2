// lib/data/services/weather_service.dart

import 'dart:convert';

import 'package:flutter_weather_app/data/services/models/weather_model.dart';
import 'package:flutter_weather_app/result.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const _apiKey =
      '62910d3673df834f284cb3cf1d56507b';

  Future<Result<Weather>> getWeather(String cityName) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl?q=$cityName&appid=$_apiKey&units=metric',
      );
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = jsonDecode(response.body);
        return Result.ok(Weather.fromJson(jsonMap));
      } else {
        return Result.error(Exception('Erro da API: ${response.statusCode}'));
      }
    } catch (error) {
      return Result.error(error as Exception);
    }
  }

  Future<Result<String>> getCurrentCity() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.deniedForever) {
        return Result.error(
          Exception('Permissão de localização permanentemente negada.'),
        );
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      );

      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final city = placemarks.first.subAdministrativeArea;

      if (city != null && city.isNotEmpty) {
        return Result.ok(city);
      } else {
        return Result.error(Exception('Cidade não encontrada.'));
      }
    } catch (error) {
      return Result.error(error as Exception);
    }
  }
}
