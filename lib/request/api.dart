import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class WeatherApi {
  static Future<Forecast> getWeatherFromCity(String city) async {
    String cityClean = city;
    if (city.endsWith(' ')) {
      cityClean = city.substring(0, city.length - 1);
    }
    LatLng? location = await getLocation(cityClean);
    return await getWeather(location!);
  }

  static Future<LatLng?> getLocation(String city) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=$ApiKey';
    try {
      var response = await http.get(Uri.parse(url));
      return Location.formData(jsonDecode(response.body)['coord']);
    } catch (e) {
      return null;
    }
  }

  static Future<Forecast> getWeather(LatLng location) async {
    final url =
        'https://api.openweathermap.org/data/2.5/onecall?lat=${location.latitude}&lon=${location.longitude}&exclude=hourly,minutely&APPID=$ApiKey';
      var response = await http.get(Uri.parse(url));
      return Forecast.fromSnaphot(jsonDecode(response.body));
  }
}
