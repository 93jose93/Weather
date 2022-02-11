import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/components/alert_map.dart';
import 'package:weather_app/components/card_alert.dart';
import 'package:weather_app/components/card_weather.dart';
import 'package:weather_app/components/column_detail_today.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/request/api.dart';
import 'package:weather_app/utils/calculus.dart';

class PageHome extends StatefulWidget {
  PageHome({Key? key}) : super(key: key);

  @override
  _PageHomeState createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  final controllerSearch = TextEditingController(text: 'Caracas');

  LatLng? currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<Forecast>(
          future: currentPosition != null
              ? WeatherApi.getWeather(currentPosition!)
              : WeatherApi.getWeatherFromCity(controllerSearch.text),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Stack(
                children: [
                  Center(child: Image.asset('assets/error.gif')),
                  Positioned(
                    top: 35,
                    left: 20,
                    right: 20,
                    child: Text(
                      'Ha ocurrido un error',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
            if (!snapshot.hasData) {
              return Center(
                child: Image.asset('assets/loading.gif'),
              );
            }
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Calculus.weatherConditionToImage(
                          snapshot.data!.current.condition,
                          snapshot.data!.isDayTime))),
              child: ListView(
                children: [
                  ColumnDetailToday(
                    city: controllerSearch.text,
                    weather: snapshot.data!.current,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0)
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            Color.fromARGB(200, 32, 178, 170),
                            Colors.green.shade200,
                          ],
                        ),
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(50, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(width: 25),
                              Icon(Icons.place_rounded, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Buscar en el mapa nueva ubicacion',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (builder) {
                                return AlertMap(
                                    title: '${controllerSearch.text}',
                                    changePosition: (LatLng position) async {
                                      controllerSearch.text =
                                          await Calculus.getNameCity(position);
                                      setState(() {
                                        currentPosition = position;
                                      });
                                    },
                                    location: LatLng(
                                        snapshot.data!.latitude.toDouble(),
                                        snapshot.data!.longitude.toDouble()));
                              });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 5.0
                              
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [
                            Color.fromARGB(200, 32, 178, 170),
                            Colors.green.shade200,
                          ],
                        ),
                        color: Colors.green.shade300,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          ),
                          minimumSize: MaterialStateProperty.all(Size(50, 50)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.transparent),
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Container(
                          child: Row(
                            children: [
                              SizedBox(width: 35),
                              Icon(Icons.place_rounded, color: Colors.white,),
                              SizedBox(width: 10),
                              Text(
                                'Clima en mi ubicación exacta',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        onPressed: () async {
                          LatLng newPosition =
                              await Calculus.getCurrentPositionInLatLng();
                          controllerSearch.text =
                              await Calculus.getNameCity(newPosition);
                          setState(() {
                            currentPosition = newPosition;
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(100, 32, 178, 170),
                      ),
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: controllerSearch,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            hintText: 'Buscar'),
                        onSubmitted: (_) {
                          Fluttertoast.showToast(
                              msg: 'Buscando: ${controllerSearch.text}');
                          setState(() {
                            currentPosition = null;
                          });
                        },
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  if (0 < snapshot.data!.alerts.length) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(100, 139, 0, 0)),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (builder) {
                                return SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Column(
                                      children: snapshot.data!.alerts
                                          .map((e) => Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: CardAlert(alert: e),
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                );
                              });
                        },
                        icon: Icon(
                          Icons.warning,
                          color: Colors.yellow,
                        ),
                        label: Text(
                          'Alertas',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                  SizedBox(
                    height: 0,
                  ),
                  ...snapshot.data!.daily.map((e) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CardWeather(weather: e),
                      ))
                ],
              ),
            );
          }),
    );
  }
}
