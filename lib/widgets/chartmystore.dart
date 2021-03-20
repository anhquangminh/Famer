import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:farmer/model/ChartModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pie_chart/pie_chart.dart';
import 'package:farmer/provider/UserProvider.dart';
import 'package:provider/provider.dart';
import 'package:farmer/animation/FomatNumber.dart';
import 'package:farmer/model/UserConstructer.dart';

class ChartMyStore extends StatefulWidget {
  @override
  _ChartMyStoreState createState() => _ChartMyStoreState();
}

class _ChartMyStoreState extends State<ChartMyStore> {
  var data = new List<ChartModel>();
  var data1 = new List<ChartModel>();
  var datapie = new List<ChartPie>();
  int total = 0;
  int sold = 0;
  int rest = 0;

  UserInf getUser ;
  String iduser=getIdUser.getid();

  Future _getDataChart() async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getdatachart.php",
          body: {
            "iduser": iduser.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        Iterable list = await json.decode(response.body);
        setState(() {
          data = list.map((model) => ChartModel.fromJson(model)).toList();
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  Future _getDataChartMonth() async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getdatachartmonth.php",
          body: {
            "iduser": iduser.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        Iterable list = await json.decode(response.body);
        print(response.body);
        setState(() {
          data1 = list.map((model) => ChartModel.fromJson(model)).toList();
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  Future _getDataPieChart() async {
    var response;
    try {
      response = await http.post(
          "http://quangminh-api.000webhostapp.com/api_for_app/getdata/getdatapiechart.php",
          body: {
            "iduser": iduser.trim(),
          });
      if (response.statusCode == 200) {
        // if every things are right decode the response and insertInf then return true
        Iterable list = await json.decode(response.body);
        setState(() {
          datapie = list.map((model) => ChartPie.fromJson(model)).toList();
          total = datapie[0].total;
          sold = datapie[0].sold;
          rest = datapie[0].rest;
          dataMap.clear();
          dataMap.putIfAbsent("Sold", () => datapie[0].sold.toDouble());
          dataMap.putIfAbsent("Rest", () => datapie[0].rest.toDouble());
        });
      }
    } catch (e) {
      print(e); // else print the error then return false
    }
  }

  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.lime,
    Colors.cyan,
  ];

  @override
  void initState() {
    super.initState();

    _getDataChart();
    _getDataChartMonth();
    _getDataPieChart();
    dataMap.putIfAbsent("", () => 0);
  }

  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    getUser = Provider.of<User>(context).getUserInf();
  String user=getUser.iduser;
    List<charts.Series<ChartModel, String>> series = [
      charts.Series(
        id: "Subscribers",
        data: data,
        domainFn: (ChartModel series, _) => series.date,
        measureFn: (ChartModel series, _) => series.amount,
      )
//          colorFn: (SubscriberSeries series, _) => series.barColor)
    ];
    List<charts.Series<ChartModel, String>> series1 = [
      charts.Series(
        id: "Subscribers",
        data: data1,
        domainFn: (ChartModel series, _) => series.date,
        measureFn: (ChartModel series, _) => series.amount,
      )
//          colorFn: (SubscriberSeries series, _) => series.barColor)
    ];
    return new Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Card(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: charts.BarChart(series, animate: false),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            'Biểu đồ số lượng sản phẩm đã bán theo ngày',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
        Expanded(
          flex: 4,
          child: Card(
            margin: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: charts.BarChart(series1, animate: false),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            'Biểu đồ số lượng sản phẩm đã bán theo tháng',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
        Expanded(
          flex: 3,
          child: Card(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32.0,
              chartRadius: MediaQuery.of(context).size.width / 2.0,
              // showChartValuesInPercentage: true,
              // showChartValues: true,
              // showChartValuesOutside: false,
              // chartValueBackgroundColor: Colors.grey[200],
              // colorList: colorList,
              // showLegends: true,
              // legendPosition: LegendPosition.right,
              // decimalPlaces: 1,
              // showChartValueLabel: true,
              // initialAngle: 0,
              // chartValueStyle: defaultChartValueStyle.copyWith(
              //   color: Colors.blueGrey[900].withOpacity(0.9),
              // ),
              chartType: ChartType.disc,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            'Biểu đồ tổng sản phẩm còn lại và đã bán',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
        Expanded(
          flex: 2,
          child: Card(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "Tổng: ${Format.withoutFractionDigits(total.toDouble())}  sản phẩm",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                    ),
                    new Text("Đã bán: ${Format.withoutFractionDigits(sold.toDouble())} sản phẩm",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
//                    new Text("Rest: ${rest} ",
//                        style: TextStyle(
//                            fontSize: 15, fontWeight: FontWeight.w400)),
                    new Text("Còn lại: ${Format.withoutFractionDigits(rest.toDouble())} sản phẩm",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400)),
                  ],
                ),
              )),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
