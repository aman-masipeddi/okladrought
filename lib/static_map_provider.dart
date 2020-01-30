import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class StaticMapsProvider extends StatefulWidget {
   String googleMapsApiKey;
   List locations;
//   Map currentLocation;
   Position currentPosition;
   int zoom;


  StaticMapsProvider(this.googleMapsApiKey, this.currentPosition,this.zoom);

  @override
  _StaticMapState createState() => new _StaticMapState();
}

class _StaticMapState extends State<StaticMapsProvider> {

  static const int defaultWidth = 650;
  static const int defaultHeight = 600;
  Position defaultPosition = Position(latitude: 0,longitude: 0);
  String nextUrl;
  String startUrl = 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/70/Solid_white.svg/2000px-Solid_white.svg.png';

  _buildUrl(Position currentPosition) {
    var finalUri;
   // var renderUri;
    var baseUri = new Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        port: 443,
        path: '/maps/api/staticmap',
        queryParameters: {});

    // the first case, which handles a user location but no markers
    if (currentPosition != null) {
      var userLat = currentPosition.latitude;
      var userLng = currentPosition.longitude;
      String marker = '$userLat,$userLng';
      finalUri = baseUri.replace(queryParameters: {
        'center': '${currentPosition.latitude},${currentPosition.longitude}',
        'markers': marker,
        'zoom': widget.zoom.toString(),
        'size': '${defaultWidth}x${defaultHeight}',
        'key': '${widget.googleMapsApiKey}'
      });

    }

    setState(() {
      startUrl = nextUrl ?? startUrl;
      nextUrl = finalUri.toString();
    });
  }

  // .. And then add a check in your build method:
  Widget build(BuildContext context) {
    // If locations is empty, then we need to render the default map.
   /* Position currentPosition = widget.currentPosition;
    if (widget.currentPosition == null) {
      currentPosition = defaultPosition;
    }
    _buildUrl(currentPosition);*/
    _buildUrl(widget.currentPosition);
    return new Container(
        child: new FadeInImage(
          placeholder: new NetworkImage(startUrl),
          image: new NetworkImage(nextUrl),
        ));
  }
}


