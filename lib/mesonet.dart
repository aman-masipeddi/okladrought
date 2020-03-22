import 'package:flutter/material.dart';

class mesonetpage extends StatefulWidget {

  @override
  _MesonetPageState createState() => _MesonetPageState();
}

class _MesonetPageState extends State<mesonetpage>{

  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text(" Mesonet"),
      ),
      body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
      Text('The Oklahoma Mesonet is a network of environmental monitoring '
          'stations designed to measure the environment at the size and duration of mes'
         'oscale weather events. The phrase "mesonet" is a portmanteau of the words mesoscale and network.',textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),),
        Text("Founded: January 1, 1994", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),),
        Text("Headquarters: Oklahoma", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),),
        Text("Funded: 1991", textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),)
        ]
      )
      ),
    );

  }
}