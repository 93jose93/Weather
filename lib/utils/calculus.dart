import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/models/weather.dart';

class Calculus {
  static double fatenheitToCelsius(double farenheit) {
    return (farenheit - 32) * (5 / 9);
  }

  static double kelvinToCelsius(num temperature) {
    return (temperature - 273.15);
  }

  static String dateTimeWithoutCompare(DateTime tiempo) {
    return "${tiempo.day} " +
        _month(tiempo.month) +
        " ${tiempo.hour}:" +
        _addCero(tiempo.minute);
  }

  static String dateWithoutCompare(DateTime tiempo) {
    return "${tiempo.day} " + _month(tiempo.month);
  }

  static Future<LatLng> getCurrentPositionInLatLng() async {
    Position myPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    return LatLng(myPosition.latitude, myPosition.longitude);
  }

  static Future<String> getNameCity(LatLng position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.first.locality != null && placemarks.first.locality != '') {
      return placemarks.first.locality!;
    }
    if (placemarks.first.administrativeArea != null &&
        placemarks.first.administrativeArea != '') {
      return placemarks.first.administrativeArea!;
    }
    if (placemarks.first.country != null && placemarks.first.country != '') {
      return placemarks.first.country!;
    }
    if (placemarks.first.name != null && placemarks.first.name != '') {
      return placemarks.first.name!;
    }
    return 'Desconocido';
  }

  static String _month(int n) {
    switch (n) {
      case 1:
        return "Ene";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Abr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Ago";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dic";
      default:
        return "$n";
    }
  }

  static String _addCero(int n) {
    if (n < 10) {
      return "0$n";
    } else {
      return "$n";
    }
  }

  static String translateDescription(String description) {
    switch (description) {
      case 'light rain':
        return 'Lluvia ligera no es buen dia para salir';
      case 'moderate rain':
        return 'Lluvia moderada no es buen dia para salir';
      case 'scattered clouds':
        return 'Nubes dispersas no es buen dia para salir';
      case 'clear sky':
        return 'Cielo despejado es buen dia para salir';
      case 'overcast clouds':
        return 'Nublado no es buendia para salir';
      case 'heavy intensity rain':
        return 'Lluvia intensa no es buen dia para salir';
      case 'broken clouds':
        return 'Nubes rotas no es buen dia para salir';
      case 'few clouds':
        return 'Pocas nubes es buen dia para salir';
      case 'rain and snow':
        return 'Lluvia y nieve no es buen dia para salir';
      case 'snow':
        return 'Nieve no es buen dia para salir';
      case 'light snow':
        return 'Nieve ligera no es buen dia para salir';
      default:
        return description;
    }
  }

  static AssetImage weatherConditionToImage(
      WeatherCondition condition, bool isDay) {
    switch (condition) {
      case WeatherCondition.atmosphere:
        return AssetImage('assets/fog.jpeg');
      case WeatherCondition.clear:
        return AssetImage('assets/${isDay ? 'clear' : 'clear-night'}.jpg');
      case WeatherCondition.drizzle:
        return AssetImage('assets/drizzle.jpg');
      case WeatherCondition.fog:
        return AssetImage('assets/fog.jpeg');
      case WeatherCondition.heavyCloud:
        return AssetImage('assets/cloudy.jpg');
      case WeatherCondition.lightCloud:
        return AssetImage(
            'assets/${isDay ? 'light_cloud' : 'light_cloud-night'}.jpg');
      case WeatherCondition.mist:
        return AssetImage('assets/drizzle.jpg');
      case WeatherCondition.rain:
        return AssetImage('assets/rain.jpeg');
      case WeatherCondition.snow:
        return AssetImage('assets/snow.jpg');
      case WeatherCondition.thunderstorm:
        return AssetImage('assets/thunder_storm.jpg');
      default:
        return AssetImage('assets/unknown.jpg');
    }
  }

  static Image weatherConditionToImageCard(String description) {
    switch (description) {
      case 'light rain':
        return Image.asset('assets/ligth_rain_day.gif');
      case 'moderate rain':
        return Image.asset('assets/moderate_rain.gif');
      case 'scattered clouds':
        return Image.asset('assets/light_cloud_card.gif');
      case 'heavy intensity rain':
        return Image.asset('assets/heavy_rain.gif');
      case 'clear sky':
        return Image.asset('assets/clear_sky.gif');
      case 'overcast clouds':
        return Image.asset('assets/overcast_clouds.png');
      case 'broken clouds':
        return Image.asset('assets/broken_clouds.png');
      case 'few clouds':
        return Image.asset('assets/few_clouds.png');
      case 'rain and snow':
        return Image.asset('assets/snow.gif');
      case 'snow':
        return Image.asset('assets/snow2.gif');
      case 'light snow':
        return Image.asset('assets/light_snow.gif');
      default:
        return Image.asset('assets/question.png');
    }
  }
}
