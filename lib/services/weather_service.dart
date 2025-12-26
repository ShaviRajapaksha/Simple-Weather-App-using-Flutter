import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_weather_app_using_flutter/models/weather_model.dart';
import 'package:geolocator/geolocator.dart'; // Add this import
import 'package:geocoding/geocoding.dart'; // Add this import for Placemark

class WeatherService {
  static const BaseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http.get(
      Uri.parse('$BaseUrl?q=$cityName&appid=$apiKey&units=metric'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied');
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String cityName = placemarks[0].locality ?? 'Unknown City';
    return cityName; // Remove null-aware operator
  }
}
