import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class cropyieldpage extends StatefulWidget {

   @override
  _CropYieldPageState createState() => _CropYieldPageState();
}

 class _CropYieldPageState extends State<cropyieldpage> {


   @override
   Widget build(BuildContext context) {
     return Scaffold(
         appBar: AppBar(
           title: Text("Crop Yield"),

         ),
           body: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text("Yet To Be Developed", textAlign: TextAlign.center,
                     style: TextStyle(fontSize: 20),)
                 ],
               ),
           )
     );
   }
}

class crop_Yield{
   String date;
   double price;

  crop_Yield(this.date, this.price);
}



