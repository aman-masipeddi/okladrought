import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
import 'Location_Pointer_Map_Page.dart';
import 'drought_index.dart';
import 'crop_yield.dart';
import 'mesonet.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

//class ScreenArguments {
//  final Position _currentPosition;
//
//  ScreenArguments(this._currentPosition);
//}

class _HomePageState extends State<HomePage> {

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
       child: Column(
         mainAxisSize: MainAxisSize.min,
         children: <Widget>[
           Expanded(
             child: Container(
                 decoration: BoxDecoration(
                   //border: Border.all(width: 2),
                 ),
                 margin: const EdgeInsets.all(10.0),
                 child: Align(
                     alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Image(
                            width: 200,
                            image: AssetImage('assets/OKDR_LOGO.png'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Image(
                            image: AssetImage('assets/OKDR_LOGO_TEXT.jpg'),
                          ) ,
                        )
                    ],
                  ),
//                     Text("OKLADROUGHT",style: TextStyle(fontSize: 50,fontStyle: FontStyle.italic))
                 )
               /*child:Row( mainAxisSize: MainAxisSize.min,
               children: <Widget>[Text("Location: "),_currentAddress!=null? Text(_currentAddress): Container()],
             )*/
             ),
           ),
         Expanded(
           child:Container(
               decoration: BoxDecoration(
                //  border: Border.all(width: 2)
               ),
             child:Align(
               alignment: Alignment.topCenter,
              child: Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                   // border: Border.all(width: 2)
                ),
               child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround ,
                   children: <Widget>[
                     SizedBox(
                       width: 147,
                       child: RaisedButton(
                 onPressed: () {_getCurrentLocation();},
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
               child: const Text(
                   'Find Location',textAlign: TextAlign.center,
                   style: TextStyle(fontSize: 20)
               ),
             ),
           ),
         ),
                     SizedBox(
                       width: 147,
                       child: RaisedButton(
                       onPressed: () {
                         Navigator.of(context).push(
                             new MaterialPageRoute(builder: (context) => droughtindexpage(),
                             )
                         );
                       },
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
                         child: const Text(
                             'Drought Index',textAlign: TextAlign.center,
                             style: TextStyle(fontSize: 20)
                         ),
                       ),
                     ),
                   )
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: <Widget>[
                     SizedBox(
                       width: 147,
                       child: RaisedButton(
                     onPressed: () {
                       Navigator.of(context).push(
                           new MaterialPageRoute(builder: (context) => cropyieldpage(),
                           )
                       );
                     },
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
               child: const Text(
                   'Crop Yield',textAlign: TextAlign.center,
                   style: TextStyle(fontSize: 20)
               ),
             ),
           ),
         ),
                     SizedBox(
                       width: 147,
                       child: RaisedButton(
                       onPressed: () {
                         Navigator.of(context).push(
                             new MaterialPageRoute(builder: (context) => mesonetpage(),
                             )
                         );
                       },
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
                         child: const Text(
                             'Mesonet',textAlign: TextAlign.center,
                             style: TextStyle(fontSize: 20)
                         ),
                       ),
                     ),
                   )
                   ],
                 )
               ],
             ),
            )
           )
           )
         )
         ],
       ),
      )
    );
  }
  _getCurrentLocation() async {

    GeolocationStatus geolocationStatus  = await Geolocator().checkGeolocationPermissionStatus();

    geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LocationPointerMapPage(_currentPosition),
          ));
    }).catchError((e) {
      print(e);
    });
  }

  /*_getAddressFromLatLng() async {

    _currentAddress = " ";
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}";
      });
      if(_currentAddress!=null){

      }
    } catch (e) {
      print(e);
    }
  }*/
}