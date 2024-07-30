import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChartPage extends StatefulWidget {
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<FlSpot> spots = [];
  double lastPrice = 0.0;
  ScrollController _scrollController = ScrollController();
  bool isMaximized = true;
  bool isWidgetVisible = false;
  bool isButtonPressed = false;

  final TextEditingController _sharesController = TextEditingController();
  final TextEditingController _buyLimitController = TextEditingController();
  final TextEditingController _sellDurationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchChartData();
  }

  Future<void> fetchChartData() async {
    final response = await http.get(Uri.parse(
        'https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=${dotenv.env['AVTOKEN']}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final timeSeries = jsonData['Time Series (5min)'] as Map<String, dynamic>;

      List<FlSpot> tempSpots = [];
      int index = 0;
      timeSeries.forEach((time, data) {
        double closePrice = double.parse(data['4. close']);
        tempSpots.add(FlSpot(index.toDouble(), closePrice));
        if (index == 0) {
          lastPrice = closePrice;
        }
        index++;
      });

      setState(() {
        spots = tempSpots.reversed.toList();
      });

      // Scroll to the end of the list to show the most recent data
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    } else {
      throw Exception('Failed to load chart data');
    }
  }

  Widget buildLeftTitles(double value, TitleMeta meta) {
    return Text(
      value.toString(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 6,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget buildBottomTitles(double value, TitleMeta meta) {
    return Text(
      value.toInt().toString(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 8,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 46,
            right: 246,
            child: Row(
              children: [
                Text(
                  'IBM Stock Chart',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                // IconButton(
                //   icon: Icon(Icons.minimize, color: Colors.white),
                //   onPressed: () {
                //     setState(() {
                //       isMaximized = false;
                //     });
                //   },
                // ),
                // IconButton(
                //   icon: Icon(Icons.fullscreen, color: Colors.white),
                //   onPressed: () {
                //     setState(() {
                //       isMaximized = true;
                //     });
                //   },
                // ),
              ],
            ),
          ),
          Positioned.fill(
            top: -80,
            child: Center(
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                width: isMaximized
                    ? MediaQuery.of(context).size.width * 0.9
                    : 400,
                height: isMaximized
                    ? MediaQuery.of(context).size.height * 0.7
                    : 300,
                decoration: BoxDecoration(
                  color: Color(0xff130e15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: spots.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: spots.length * 5.0,
                      child: LineChart(
                        LineChartData(
                          gridData: const FlGridData(show: true),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: buildLeftTitles,
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                interval: 5,
                                getTitlesWidget: buildBottomTitles,
                              ),
                            ),
                          ),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(
                              color: const Color(0xffffffff),
                              width: 1,
                            ),
                          ),
                          minX: 0,
                          maxX: spots.length.toDouble() - 1,
                          minY: spots
                              .map((spot) => spot.y)
                              .reduce((a, b) => a < b ? a : b),
                          maxY: spots
                              .map((spot) => spot.y)
                              .reduce((a, b) => a > b ? a : b),
                          lineBarsData: [
                            LineChartBarData(
                              spots: spots,
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 2,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.blue.withOpacity(0.3),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Text(
              'Last Price: \$${lastPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 16,
            right: 16,
            child: AnimatedOpacity(
              opacity: isWidgetVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xff1e1e1e),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Shares', style: TextStyle(color: Colors.white)),
                    TextField(
                      controller: _sharesController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.grey[800],
                        filled: true,
                        border: OutlineInputBorder(),
                        hintText: 'Enter shares',
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // edra make Buy action
                          },
                          child: Text('Buy'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // edra make Sell action
                          },
                          child: Text('Sell'),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Limit', style: TextStyle(color: Colors.white)),
                              TextField(
                                controller: _buyLimitController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[800],
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter limit',
                                  hintStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Duration', style: TextStyle(color: Colors.white)),
                              TextField(
                                controller: _sellDurationController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  fillColor: Colors.grey[800],
                                  filled: true,
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter duration',
                                  hintStyle: TextStyle(color: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            bottom: isButtonPressed ? 280 : 80, // 1 - when pressed, 2 - when unpressed
            right: 16,
            duration: Duration(milliseconds: 300),
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  isWidgetVisible = !isWidgetVisible;
                  isButtonPressed = !isButtonPressed;
                });
              },
              child: Icon(
                isWidgetVisible ? Icons.close : Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
