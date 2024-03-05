import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/weather.dart';

class WeatherRepository {
  final wf = WeatherFactory(dotenv.get('API_KEY'), language: Language.UKRAINIAN);

  Future<dynamic> getWeather(String city) async {
    try {
      final weather = wf.currentWeatherByCityName(city);
      return weather;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}