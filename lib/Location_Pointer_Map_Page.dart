import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:location/location.dart';
import 'static_map_provider.dart';
import 'package:geolocator/geolocator.dart';

class LocationPointerMapPage extends StatefulWidget {

  Position currentPosition;
  LocationPointerMapPage(this.currentPosition);

  @override
  _LocationPointerMapPageState createState() => _LocationPointerMapPageState(this.currentPosition);
}

class _LocationPointerMapPageState extends State<LocationPointerMapPage>{

  String _currentAddress = " ";
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position currentPosition;
  _LocationPointerMapPageState(this.currentPosition);

  Location _location = new Location();
  List locations = [];
  String googleMapsApi = 'AIzaSyBpPIFHijTtZM2glN2WZrpXfooIGzpkz9A';
  dynamic deviceLocation;
  int zoom =5;

  @override
  void initState(){
    _getAddressFromLatLng();
    super.initState();
  }

  Widget build(BuildContext context){

  return Scaffold(
      appBar: AppBar(
      title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    //border: Border.all(width: 2),
                  ),
                  child: new StaticMapsProvider(googleMapsApi,currentPosition, zoom),
                )
            ),
            Expanded(
                child: Container(margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    //border: Border.all(width: 2),
                  ),
                  child:
                  Text("$_currentAddress", style: TextStyle(fontSize: 20)),
                )
            )
          ],
        )

      ),
    );
  }

  _getAddressFromLatLng() async {

    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}";
      });
      if(_currentAddress!=null){
      }
    } catch (e) {
      print(e);
    }
  }

}



