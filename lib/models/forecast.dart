import 'package:weather_app/models/alert.dart';
import 'package:weather_app/models/weather.dart';

class Forecast {
  final DateTime lastUpdate;
  final num latitude;
  final num longitude;
  final List<Weather> daily;
  final List<Alert> alerts;
  final Weather current;
  final bool isDayTime;
  final String? city;

  Forecast(
      {required this.alerts,
      required this.lastUpdate,
      required this.latitude,
      required this.longitude,
      required this.daily,
      required this.current,
      required this.isDayTime,
      this.city});

  static Forecast fromSnaphot(Map data) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
            data['current']['dt'] * 1000,
            isUtc: true)
        .toLocal();
    DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
            data['current']['sunrise'] * 1000,
            isUtc: true)
        .toLocal();
    DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
            data['current']['sunset'] * 1000,
            isUtc: true)
        .toLocal();
    bool isDay = date.isAfter(sunrise) && date.isBefore(sunset);
    List<Weather> tempDaily =
        data['daily'] != null ? Weather.weatherToList(data['daily']) : [];
    Weather? currentForcast = Weather.fromSnapshot(data['current']);
    return Forecast(
      lastUpdate: DateTime.now(),
      latitude: data['lat'],
      longitude: data['lon'],
      daily: tempDaily,
      current: currentForcast!,
      isDayTime: isDay,
      alerts: data['alerts'] != null ? Alert.alertsToQuery(data['alerts']) : [],
    );
  }
}
