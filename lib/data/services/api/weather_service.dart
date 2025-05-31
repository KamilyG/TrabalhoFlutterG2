import 'dart:convert';

import 'package:flutter_weather_app/result.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class WeatherService {
  static const _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  static const _apiKey =
      '62910d3673df834f284cb3cf1d56507b'; // <-- sua chave mantida aqui

  Future<Result<Weather>> getWeather(String cityName) async {
    try {
      final uri = Uri.parse(
        '$_baseUrl?q=$cityName&appid=$_apiKey&units=metric',
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return Result.ok(Weather.fromJson(jsonDecode(response.body)));
      } else {
        return Result.error(Exception('Erro da API: ${response.statusCode}'));
      }
    } catch (error) {
      return Result.error(error as Exception);
    }
  }

  Future<Result<String>> getCurrentCity() async {
    try {
      // Solicita permissão de localização
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

      // Pega o nome da cidade mais confiável
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final city = placemarks.first.locality;

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
