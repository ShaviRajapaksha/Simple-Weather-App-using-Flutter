import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:simple_weather_app_using_flutter/models/weather_model.dart';

class WeatherService {
  static const BaseUrl = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {

    final response = await http.get(Uri.parse('$BaseUrl?q=$cityName&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
