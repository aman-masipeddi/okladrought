// TODO Implement this library.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'classes_Required.dart';


class PieChartPage extends StatefulWidget {
  String yearNum;
  Station _selectedStation;
  List data;
  PieChartPage(this.yearNum, this._selectedStation, this.data);

  @override
  _PieChartPageState createState() => _PieChartPageState(this.yearNum, this._selectedStation, this.data);
}



class _PieChartPageState extends State<PieChartPage> {

  Station _selectedStation;
  String yearNum;
  List data;

  List<int> month_List = new List<int>();
  List<Pie_Value> pie_Value_List = new List<Pie_Value>();
  List<charts.Series<Pie_Value, String>> _seriesPieData = List<charts.Series<Pie_Value, String>>();

  _PieChartPageState(this.yearNum,this._selectedStation, this.data);

  _generate_Data(){
    int count_EW = 0 , count_SW = 0, count_MW = 0, count_MildW = 0, count_MildD = 0, count_MD = 0, count_SD = 0, count_ED = 0;
    for (var h in data) {
      if (h["Date"].toString().substring(0, 4) == yearNum) {
        int x = int.parse(h["Date"].toString().substring(0, 4));
        int y = int.parse(h["Date"].toString().substring(0, 4)) - 1;

        if (!month_List.contains(int.parse(y.toString() + "09"))) {
          month_List.add(int.parse(y.toString() + "09"));
        }
        for (int i = 10; i <= 12; i++) {
          if (!month_List.contains(int.parse(y.toString() + i.toString()))) {
            month_List.add(int.parse(y.toString() + i.toString()));
          }

          for (int i = 01; i <= 06; i++) {
            if (!month_List.contains(
                int.parse(x.toString() + "0" + i.toString()))) {
              month_List.add(int.parse(x.toString() + "0" + i.toString()));
            }
          }
        }
      }
    }
    /*print(month_List.length);
       for (var i in month_List) {
         print(i.toString());
       }*/

    for(var a in data){
      for(var h in month_List){
        if(h.toString() == a["Date"]) {
          print(a["Date"]);
          double x = double.parse(double.parse(a["SMEI"]).toStringAsFixed(2));
          if(x>=2.00){
            print("EW");
            count_EW = count_EW + 1;
          }else if(1.50 <= x && x <= 1.99){
            print("SW");
            count_SW = count_SW + 1;
          }else if(1.00 <= x && x <= 1.49){
            print("MW");
            count_MW = count_MW + 1;
          }else if(0.00 <= x && x <= 0.99){
            print("MildW");
            count_MildW = count_MildW + 1;
          }else if(-0.99 <= x && x <= 0.00){
            print("MildD");
            count_MildD = count_MildD + 1;
          }else if(-1.49 <= x && x <= -1.00){
            print("MD");
            count_MD = count_MD + 1;
          }else if(-1.99 <= x && x <= -1.50){
            print("SD");
            count_SD = count_SD +1;
          }else{
            print("ED");
            count_ED = count_ED + 1;
          }
        }
      }
    }
    pie_Value_List.add(new Pie_Value("Extremely Wet",count_EW, Color(0xFFFF6D00)));
    pie_Value_List.add(new Pie_Value("Severely Wet",count_SW, Color(0xFFEF6C00)));
    pie_Value_List.add(new Pie_Value("Moderately Wet",count_MW, Color(0xFFFF9800)));
    pie_Value_List.add(new Pie_Value("Mildly Wet",count_MildW, Color(0xFFFFcc80)));
    pie_Value_List.add(new Pie_Value("Mild Drought",count_MD, Color(0xFFEF5350)));
    pie_Value_List.add(new Pie_Value("Moderate Drought",count_MD, Color(0xFFE53935)));
    pie_Value_List.add(new Pie_Value("Severe Drought",count_SD, Color(0xFFD50000)));
    pie_Value_List.add(new Pie_Value("Extremely Drought",count_ED, Color(0xFFB71C1C)));
    print(pie_Value_List.length);


    _seriesPieData.add(
      charts.Series(
        domainFn: (Pie_Value task, _) => task.category,
        measureFn: (Pie_Value task, _) => task.count,
        colorFn: (Pie_Value task, _) =>
            charts.ColorUtil.fromDartColor(task.colorCode),
        id: 'Pie Chart',
        data: pie_Value_List,
        labelAccessorFn: (Pie_Value row, _) => '${row.count}',
      ),
    );
    print(_seriesPieData.length);
  }

  @override
  void initState() {
    _generate_Data();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController( length: 1,
    child: Stack(
    children: <Widget>[
    Scaffold(
    appBar: AppBar(
    backgroundColor: Colors.brown,
    bottom: TabBar(
    indicatorColor: Colors.brown,
    tabs: [
    Tab(child: Text("Pie Chart"),),
    ],
    ),
    title: Text(_selectedStation.STNAME+" "+yearNum),
    ),
    body: TabBarView(
        children: <Widget>[
    Padding(
    padding: EdgeInsets.all(8.0),
        child: Container(
            child: Center(
                child: Column(
                    children: <Widget>[
                    Expanded(
                      child: charts.PieChart(
                        _seriesPieData,
                        animate: true,
                        animationDuration: Duration(seconds: 1),
                        behaviors: [new charts.DatumLegend(
                          outsideJustification: charts.OutsideJustification.endDrawArea,
                          horizontalFirst: false,
                          desiredMaxRows: 3,
                          cellPadding: new EdgeInsets.only(right: 1.0, bottom: 5.0),
                          entryTextStyle: charts.TextStyleSpec(
                              color: charts.MaterialPalette.black,
                              fontFamily: 'Georgia',
                              fontSize: 13),
                        )],
                      ),
                    ),]
                  )
                )
            )
    )
    ]
    )
    )
    ]
    )
    );
  }
}

class Pie_Value{
  String category;
  int count;
  Color colorCode;

  Pie_Value(this.category, this.count,this.colorCode);
}
