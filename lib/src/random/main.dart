/// Dash pattern line chart example
import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random 随机性测试'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {});
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: 250,
            child: RandomTestLineChart(createRandomData()),
          ),
        ),
      ),
    );
  }

  List<charts.Series<RandomResult, int>> createRandomData() {
    final List<RandomResult> data1 = [];
    final List<RandomResult> data2 = [];
    final List<RandomResult> data3 = [];

    Random _random = Random();

    int count = 100000;
    for (int i = 0; i < 10; i++) {
      List<double> nums = [];
      for (int i = 0; i < count; i++) {
        double value = _random.nextDouble();
        nums.add(value);
      }

      data1.add(
          RandomResult(i, nums.where((v) => v > 0.5).length / nums.length));
      data2.add(
          RandomResult(i, nums.where((v) => v < 0.25).length / nums.length));
      data3.add(
          RandomResult(i, nums.where((v) => v > 0.6).length / nums.length));
    }

    return [
      charts.Series<RandomResult, int>(
        id: '>0.5',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (RandomResult sales, _) => sales.count,
        measureFn: (RandomResult sales, _) => sales.rate,
        data: data1,
      ),
      charts.Series<RandomResult, int>(
        id: '<0.25',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (RandomResult sales, _) => sales.count,
        measureFn: (RandomResult sales, _) => sales.rate,
        data: data2,
      ),
      charts.Series<RandomResult, int>(
        id: '>0.6',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (RandomResult sales, _) => sales.count,
        measureFn: (RandomResult sales, _) => sales.rate,
        data: data3,
      )
    ];
  }
}

/// Example of a line chart rendered with dash patterns.
class RandomTestLineChart extends StatelessWidget {
  final List<charts.Series<RandomResult, int>> seriesList;

  const RandomTestLineChart(this.seriesList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.LineChart(seriesList,
        animate: true,
        behaviors: [
          charts.SeriesLegend(
            position: charts.BehaviorPosition.top,
            cellPadding:
                const EdgeInsets.only(right: 4.0, bottom: 0.0, left: 4.0),
            entryTextStyle: const charts.TextStyleSpec(
                color: charts.Color(r: 0, g: 0, b: 0), fontSize: 11),
          ),
        ],
        primaryMeasureAxis: charts.NumericAxisSpec(
            tickProviderSpec: const charts.StaticNumericTickProviderSpec([
              charts.TickSpec(
                0,
                label: '0 %',
              ),
              charts.TickSpec(
                0.25,
                label: '25 %',
              ),
              charts.TickSpec(
                0.50,
                label: '50 %',
              ),
              charts.TickSpec(
                0.750,
                label: '75 %',
              ),
              charts.TickSpec(
                1,
                label: '100 %',
              ),
            ]),
            renderSpec: charts.GridlineRendererSpec(
                // labelStyle: charts.TextStyleSpec(
                //     color: charts.Color.fromHex(code: '#000000'),
                //     lineHeight: 1),
                lineStyle: charts.LineStyleSpec(
                    dashPattern: [5, 5],
                    color: charts.Color.fromHex(code: '#3D5877')))));
  }
}

class RandomResult {
  final int count;
  final double rate;

  RandomResult(this.count, this.rate);
}
