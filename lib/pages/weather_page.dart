import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
  final _weatherService = WeatherService('api key');
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
  String _getWeatherAnimation(String mainCondition) {
    switch (mainCondition.toLowerCase()) {
      case 'clear':
        return 'assets/Weather-sunny.json';
      case 'thunderstorm':
        return 'assets/Weather-stormy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Weather-rainy.json';
      case 'windy':
      case 'clouds':
      case 'fog':
      case 'haze':
      case 'mist':
      case 'smoke':
      case 'dust':
        return 'assets/Weather-windy.json';
      default:
        return 'assets/Weather-sunny.json';
    }
  }

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

            //animations
            Lottie.asset(
              _getWeatherAnimation(_currentWeather?.mainCondition ?? ''),
            ),

            //temperature
            Text('${_currentWeather?.temperature.round()} °C'),
          ],
        ),
      ),
    );
  }
}
