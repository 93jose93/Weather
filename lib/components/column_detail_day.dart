import 'package:flutter/material.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/calculus.dart';

class ColumnDetailDay extends StatelessWidget {
  final Weather weather;

  const ColumnDetailDay({Key? key, required this.weather, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Pronóstico ${Calculus.dateWithoutCompare(weather.date)}',
          style:
              TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
                child: Calculus.weatherConditionToImageCard(
                    weather.description)),
            Expanded(
              flex: 3,
              child: Text(
                '${Calculus.translateDescription(weather.description)}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        Divider(),
        Row(
          children: [
            Spacer(),
            Column(
              children: [
                Text(
                  'Dia: ${Calculus.kelvinToCelsius(weather.temp.day).toStringAsFixed(1)} °C',
                  style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                Text(
                    'Max: ${Calculus.kelvinToCelsius(weather.temp.max).toStringAsFixed(1)} °C'),
                Text(
                    'Min: ${Calculus.kelvinToCelsius(weather.temp.min).toStringAsFixed(1)} °C'),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text(
                    'Mañana: ${Calculus.kelvinToCelsius(weather.temp.morn).toStringAsFixed(1)} °C'),
                Text(
                    'Tarde: ${Calculus.kelvinToCelsius(weather.temp.eve).toStringAsFixed(1)} °C'),
                Text(
                    'Noche: ${Calculus.kelvinToCelsius(weather.temp.night).toStringAsFixed(1)} °C')
              ],
            ),
            Spacer(),
          ],
        ),
        Divider(),
        Text(
          'Sensación: ${Calculus.kelvinToCelsius(weather.feelLikeTemp).toStringAsFixed(1)} °C',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
        Divider(),
        Row(
          children: [
            Spacer(),
            Text('Uvi: ${weather.uvi}'),
            Spacer(),
            Text('Nubosidad: ${weather.cloudiness}%'),
            Spacer(),
            Text('Humedad: ${weather.humidity}%'),
            Spacer(),
          ],
        ),
        Divider(),
        Row(
          children: [
            Spacer(),
            Text('Viento: ${weather.windSpeed} Mph'),
            Spacer(),
            if (weather.rain != null) ...[
              Text('Lluvia: ${weather.rain}%'),
              Spacer(),
            ]
          ],
        ),
        Divider()
      ],
    );
  }
}
