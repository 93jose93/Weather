import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/models/location.dart';

class AlertMap extends StatefulWidget {
  final String title;
  final Function changePosition;
  final LatLng location;

  const AlertMap(
      {Key? key,
      required this.title,
      required this.changePosition,
      required this.location})
      : super(key: key);

  @override
  _AlertMapState createState() => _AlertMapState();
}

class _AlertMapState extends State<AlertMap> {
  Set<Marker> markers = {};
  LatLng? newPosition;

  @override
  void initState() {
    markers.add(Marker(
      infoWindow: InfoWindow(title: '${widget.title}'),
      position: LatLng(widget.location.latitude, widget.location.longitude),
      markerId: MarkerId('${widget.title}'),
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        if (1 < markers.length) ...[
          ElevatedButton.icon(
              onPressed: () {
                widget.changePosition(newPosition);
                Navigator.pop(context);
              },
              icon: Icon(Icons.check),
              label: Text(
                'Seleccionar nueva posision',
                style: TextStyle(color: Colors.white),
              ))
        ] else ...[
          Text(
              'Navega y pulsa el mapa para obtener infromación de otra coordenada')
        ]
      ],
      title: Text('${widget.title}'),
      content: Container(
        height: 350,
        child: GoogleMap(
          onTap: (position) async {
            if (1 < markers.length) {
              markers.remove(markers.last);
            }
            //        var newIcon = await BitmapDescriptor.fromAssetImage(
            //              ImageConfiguration(size: Size(0.01, 0.01)),
//                'assets/location.png');
            setState(() {
              newPosition = position;
              markers.add(Marker(
//                icon: newIcon,
                infoWindow: InfoWindow(title: 'Nueva locación'),
                position: position,
                markerId: MarkerId('New location'),
              ));
            });
          },
          markers: markers,
          initialCameraPosition: CameraPosition(
              zoom: 5,
              target:
                  LatLng(widget.location.latitude, widget.location.longitude)),
        ),
      ),
    );
  }
}
