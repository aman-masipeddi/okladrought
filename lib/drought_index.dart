import 'package:flutter/material.dart';

class droughtindexpage extends StatefulWidget {

  @override
  _DroughtIndexPageState createState() => _DroughtIndexPageState();
}

class _DroughtIndexPageState extends State<droughtindexpage>{

  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
        title: Text("Drought Index"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Yet To Be Developed", textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),)
          ],
        ),

      ),
    );

  }
}