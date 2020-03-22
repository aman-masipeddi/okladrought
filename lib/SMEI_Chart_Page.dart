
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Class_STID_STNAME.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:developer';
import 'package:intl/intl.dart';

class SMEIChartPage extends StatefulWidget {
  Station _selectedStation;
  SMEIChartPage(this._selectedStation);

  @override
  _SMEIChartPageState createState() => _SMEIChartPageState(this._selectedStation);
}

class _SMEIChartPageState extends State<SMEIChartPage>{

  List<charts.Series<chart_Values, DateTime>> _seriesLineData;
  List<charts.Series<chart_Values, DateTime>> _seriesLineData_1;
  List<chart_Values> SMEI_Raw_Values_list = List<chart_Values>();
  List<chart_Values> price_Value_list = List<chart_Values>();

  Station _selectedStation;
  _SMEIChartPageState(this._selectedStation);


  Future _generateData() async {
    String x = _selectedStation.STID;
    String url = "http://192.168.0.56:8080/OD/get_station_data_$x.php";
    print(url);
    final res = await http.get(url, headers: {"Accept": "aplication/json"});
    final jsonData = json.decode(res.body);
    List data = jsonData['result'] as List;

    for (var h in data) {
      double smei = double.parse(double.parse(h["SMEI"]).toStringAsFixed(4));
      int date = int.parse(h["Date"]);
      chart_Values x = new chart_Values(new DateTime(int.parse(date.toString().substring(0,4)),int.parse(date.toString().substring(4,6))), smei);
      SMEI_Raw_Values_list.add(x);
    }

    String url_wheat_price = "http://192.168.0.56:8080/OD/get_monthly_wheat_price.php";
    print(url_wheat_price);
    final res_1 = await http.get(url_wheat_price, headers: {"Accept": "aplication/json"});
    final jsonData_1 = json.decode(res_1.body);
    List data_1 = jsonData_1['result'] as List;

    for (var h_1 in data_1) {
    double price = double.parse(h_1["Price"]);
    int date = int.parse(h_1["Date"]);
    chart_Values y = new chart_Values(new DateTime(int.parse(date.toString().substring(0,4)),int.parse(date.toString().substring(4,6))), price);
    price_Value_list.add(y);
    }

    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'SMEI',
        data: SMEI_Raw_Values_list,
        domainFn: (chart_Values a, _) => a.Date,
        measureFn: (chart_Values a, _) => a.SMEI_price,
      ),
    );

    _seriesLineData_1.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
        id: 'SMEI',
        data: SMEI_Raw_Values_list,
        domainFn: (chart_Values a, _) => a.Date,
        measureFn: (chart_Values a, _) => a.SMEI_price*100,
      ),
    );

    _seriesLineData_1.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Price',
        data: price_Value_list,
        domainFn: (chart_Values a, _) => a.Date,
        measureFn: (chart_Values a, _) => a.SMEI_price,
      ),
    );
    return _seriesLineData;
  }

  @override
  void initState() {
    _generateData();
    _seriesLineData = List<charts.Series<chart_Values, DateTime>>();
    _seriesLineData_1 = List<charts.Series<chart_Values, DateTime>>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
              return DefaultTabController( length: 2,
                child: Stack(
                    children: <Widget>[
                      Scaffold(
                        appBar: AppBar(
                          backgroundColor: Colors.brown,
                          bottom: TabBar(
                            indicatorColor: Colors.brown,
                            tabs: [
                              Tab(child: Text("SMEI Chart"),),
                              Tab(child: Text("SMEI/Price Chart"),),
                            ],
                          ),
                          title: Text(_selectedStation.STNAME),
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
                                        child: charts.TimeSeriesChart(
                                            _seriesLineData,
                                            defaultRenderer: new charts.LineRendererConfig(
                                                includeArea: true, stacked: true),
                                            animate: true,
                                            animationDuration: Duration(seconds: 1),
                                            domainAxis: new charts.EndPointsTimeAxisSpec(),
                                            behaviors: [new charts.SeriesLegend(),
                                              new charts.ChartTitle('TimeLine',
                                                  behaviorPosition: charts.BehaviorPosition.bottom,
                                                  titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                              new charts.ChartTitle('SMEI',
                                                  behaviorPosition: charts.BehaviorPosition.start,
                                                  titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                                            ]
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Container(
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                        child: charts.TimeSeriesChart(
                                            _seriesLineData_1,
                                            animate: true,
                                            animationDuration: Duration(seconds: 1),
                                            // Configure the default renderer as a bar renderer.
                                            defaultRenderer: new charts.BarRendererConfig(),
                                            domainAxis: new charts.EndPointsTimeAxisSpec(),
                                            // Custom renderer configuration for the line series. This will be used for
                                            // any series that does not define a rendererIdKey.
                                            customSeriesRenderers: [
                                              new charts.LineRendererConfig(
                                                // ID used to link series to this renderer.
                                                  customRendererId: 'customLine'),
                                            ],
                                            behaviors: [new charts.SeriesLegend(),
                                            new charts.ChartTitle('Timeline',
                                            behaviorPosition: charts.BehaviorPosition.bottom,
                                            titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                            new charts.ChartTitle('SMEI/Price',
                                            behaviorPosition: charts.BehaviorPosition.start,
                                            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )

                          ],
                        )

                    )],
                ),


    );
  }
}

class chart_Values{
  final DateTime Date;
  final double SMEI_price;

  chart_Values(this.Date, this.SMEI_price);
}

