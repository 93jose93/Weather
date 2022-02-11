import 'package:flutter/material.dart';
import 'package:weather_app/components/column_detail_day.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/calculus.dart';

class CardWeather extends StatelessWidget {
  final Weather weather;
  const CardWeather({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (builder) {
              return SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ColumnDetailDay(weather: weather),
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(100, 32, 178, 170)),
        child: Row(
          children: [
            Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Text(
                      '${Calculus.kelvinToCelsius(weather.temp.day).toStringAsFixed(1)} °C',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                    Text(
                      'Sensacion: ${Calculus.kelvinToCelsius(weather.feelLikeTemp).toStringAsFixed(1)} °C',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      '${Calculus.dateWithoutCompare(weather.date.subtract(Duration(hours: 5)))}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Calculus.weatherConditionToImageCard(weather.description),
                      Text(
                        '${Calculus.translateDescription(weather.description)}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}