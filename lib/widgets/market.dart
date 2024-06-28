import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MarketPage extends StatefulWidget {
  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<FlSpot> spots = [];
  @override void initState() {
    super.initState();
    FetchPrices().then((value) {
      List<FlSpot> fetchedSpots = [];
      var rawResponse = jsonDecode(value.toString()) as Map<String, dynamic>;
      print(rawResponse.toString());
      for (var entry in rawResponse['Time Series (5min)'].keys){
        print(rawResponse['Time Series (5min)'][entry]['1. open'].toString());
        fetchedSpots.add(FlSpot(DateTime.parse(entry).millisecondsSinceEpoch.toDouble(), double.parse(rawResponse['Time Series (5min)'][entry]['1. open'].toString())));
      }
      setState(() {
        spots = fetchedSpots;
      });
    });
  }

  Future<String> FetchPrices() async {
    var response = await http.get(Uri.parse('https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=${dotenv.env['AVTOKEN']}'));
    return response.body;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Stocks market'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          LineChart(LineChartData(
            lineBarsData:[
              LineChartBarData(
                show: true,
                spots: spots
              )
            ],
            // titlesData:
            //   FlTitlesData(
            //     show: true,
            //     bottomTitles: AxisTitles(
            //       sideTitles:
            //         SideTitles(
            //           showTitles: true,
            //           getTitlesWidget: (value, titleMeta) {
            //             final DateTime date =
            //             DateTime.fromMillisecondsSinceEpoch(value.toInt());
            //             final parts = date.toIso8601String().split("T");
            //             return Text(parts.first);
            //           },
            //         ),
            //     )
            //
            //   )
            )
          )
        ],
      )
    );
  }
}