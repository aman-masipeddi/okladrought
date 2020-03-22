import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:okladrought_1/classes_Required.dart';
import 'static_map_provider.dart';
import 'SMEI_Chart_Page.dart';

class LocationPointerMapPage extends StatefulWidget {
  Position currentPosition;
  LocationPointerMapPage(this.currentPosition);

  @override
  _LocationPointerMapPageState createState() => _LocationPointerMapPageState(this.currentPosition);
}

class _LocationPointerMapPageState extends State<LocationPointerMapPage> {

  String _currentAddress = " ";
  final Geolocator geolocator = Geolocator()
    ..forceAndroidLocationManager;
  Position currentPosition;

  _LocationPointerMapPageState(this.currentPosition);

  Location _location = new Location();
  List locations = [];
  String googleMapsApi = 'AIzaSyBpPIFHijTtZM2glN2WZrpXfooIGzpkz9A';
  dynamic deviceLocation;
  int zoom = 5;

  List<Station> _stations = Station.getStations();
  List<DropdownMenuItem<Station>> _dropdownMenuItems;
  Station _selectedStation;

  @override
  void initState() {
    _getAddressFromLatLng();
    _dropdownMenuItems = buildDropdownMenuItems(_stations);
    super.initState();
  }

  List<DropdownMenuItem<Station>> buildDropdownMenuItems(List stations) {
    List<DropdownMenuItem<Station>> items = List();
    for (Station station in stations) {
      items.add(DropdownMenuItem(value: station,
          child: Text(station.STNAME)));
    }
    return items;
  }

  onChangeDropDownItem(Station selectedStation) {
    setState(() {
      _selectedStation = selectedStation;
    });
  }

  Widget build(BuildContext context) {
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
                    ),
                    child: new StaticMapsProvider(
                        googleMapsApi, currentPosition, zoom),
                  )
              ),
              Expanded(
                child: Container(margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    //border: Border.all(width: 2),
                  ),
                  child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        DropdownButton(
                          value: _selectedStation,
                          items: _dropdownMenuItems,
                          onChanged: onChangeDropDownItem,
                        ),
                        SizedBox(
                          width: 147,
                          child: RaisedButton(
                            onPressed: () {_onCLickShowSMEI();},
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              width: 147,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF4E342E),
                                    Color(0xFF6D4C41),
                                    Color(0xFF8D6E63),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: Text("SMEI",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20)
                              ),
                            ),
                          ),
                        ),
                      ]
                  ),
                ),
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
        int x = _stations.indexWhere((Station) =>
        Station.STNAME == _currentAddress);
        if(x!=null){
          _selectedStation = _dropdownMenuItems[x].value;
        }
        else{}


      });
      if (_currentAddress != null) {}
    } catch (e) {
      print(e);
    }
  }

  void _onCLickShowSMEI() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SMEIChartPage(_selectedStation),
        ));
  }
}