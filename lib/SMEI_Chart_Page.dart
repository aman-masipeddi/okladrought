import 'package:flutter/material.dart';
import 'Class_STID_STNAME.dart';

class SMEIChartPage extends StatefulWidget {
  Station _selectedStation;
  SMEIChartPage(this._selectedStation);

  @override
  _SMEIChartPageState createState() => _SMEIChartPageState(this._selectedStation);
}

class _SMEIChartPageState extends State<SMEIChartPage>{

  Station _selectedStation;
  _SMEIChartPageState(this._selectedStation);


  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedStation.STNAME),
      ),
      body: Center(
      ),
    );

  }
}