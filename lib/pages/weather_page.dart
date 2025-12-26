import 'package:flutter/material.dart';
import 'package:simple_weather_app_using_flutter/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key
  //website: https://home.openweathermap.org/api_keys
  final _weatherService = WeatherService('YOUR_API_KEY_HERE');
  Weather? _currentWeather;

  //fetch weather
  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _currentWeather = weather;
      });
    } catch (e) {
      // Handle error, e.g., show a snackbar or dialog
      print('Error fetching weather: $e');
    }
  }
  //weather animation

  //init state
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //city name
            Text(_currentWeather?.cityName ?? 'loading city...'),

            //temperature
            Text('${_currentWeather?.temperature.round()} °C'),
          ],
        ),
      ),
    );
  }
}
