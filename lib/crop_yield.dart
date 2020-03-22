import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:okladrought_1/classes_Required.dart';
import 'PieChart_Page.dart';

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
               child: Text("Yet To Be Developed", textAlign: TextAlign.center,
                 style: TextStyle(fontSize: 20),)
           )
     );
   }

   /*void _onCLickShowSMEI() {
     Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => PieChartPage(_selectedYear.yearnum),
         ));
     print(_selectedYear.yearnum);
   }*/

 }







