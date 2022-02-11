import 'package:weather_app/models/temp.dart';

class Weather {
  final WeatherCondition condition;
  final String description;
  final int cloudiness;
  final DateTime date;
  final dynamic temp;
  final num feelLikeTemp;
  final num humidity;
  final num dewPoint;
  final num windSpeed;
  final num? rain;
  final num uvi;

  Weather({
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.rain,
    required this.uvi,
    required this.temp,
    required this.cloudiness,
    required this.date,
    required this.feelLikeTemp,
    required this.condition,
    required this.description,
  });

  static Weather? fromSnapshot(Map data) {
    try {
      var feels = data['feels_like'];
      var temp = data['temp'];
      return Weather(
          humidity: data['humidity'],
          rain: data['rain'] ?? null,
          uvi: data['uvi'],
          windSpeed: data['wind_speed'],
          dewPoint: data['dew_point'],
          description: data['weather'][0]['description'],
          condition:
              toWeatherCondition(data['weather'][0]['main'], data['clouds']),
          cloudiness: data['clouds'],
          date: DateTime.fromMillisecondsSinceEpoch(data['dt'] * 1000,
                  isUtc: true)
              .toLocal(),
          feelLikeTemp: feels.runtimeType == double
              ? data['feels_like']
              : data['feels_like']['day'],
          temp: temp.runtimeType == double
              ? data['temp']
              : Temp.fromSnapshot(data['temp']));
    } catch (e) {
      return null;
    }
  }

  static List<Weather> weatherToList(List query) {
    List<Weather> result = [];
    query.forEach((element) {
      Weather? tmp = fromSnapshot(element);
      if (tmp != null) {
        result.add(tmp);
      }
    });
    return result;
  }

  static WeatherCondition toWeatherCondition(String input, int cloudiness) {
    WeatherCondition condition;
    switch (input) {
      case 'Thunderstorm':
        condition = WeatherCondition.thunderstorm;
        break;
      case 'Drizzle':
        condition = WeatherCondition.drizzle;
        break;
      case 'Rain':
        condition = WeatherCondition.rain;
        break;
      case 'Snow':
        condition = WeatherCondition.snow;
        break;
      case 'Clear':
        condition = WeatherCondition.clear;
        break;
      case 'Clouds':
        condition = (cloudiness >= 85)
            ? WeatherCondition.heavyCloud
            : WeatherCondition.lightCloud;
        break;
      case 'Mist':
        condition = WeatherCondition.mist;
        break;
      case 'fog':
        condition = WeatherCondition.fog;
        break;
      case 'Smoke':
      case 'Haze':
      case 'Dust':
      case 'Sand':
      case 'Ash':
      case 'Squall':
      case 'Tornado':
        condition = WeatherCondition.atmosphere;
        break;
      default:
        condition = WeatherCondition.unknown;
    }

    return condition;
  }
}

enum WeatherCondition {
  thunderstorm,
  drizzle,
  rain,
  snow,
  atmosphere,
  mist,
  fog,
  lightCloud,
  heavyCloud,
  clear,
  unknown
}
