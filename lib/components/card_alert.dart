import 'package:flutter/material.dart';
import 'package:weather_app/models/alert.dart';

class CardAlert extends StatelessWidget {
  final Alert alert;
  const CardAlert({Key? key, required this.alert}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          '${alert.senderName}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Divider(),
        Text(
          '${alert.event}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        ),
        Divider(),
        Text('${alert.description}'),
        Divider()
      ]),
    );
  }
}
