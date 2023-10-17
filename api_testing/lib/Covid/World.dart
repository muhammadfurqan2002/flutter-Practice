import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:async';
import 'URLS/Url.dart';
import 'URLS/WorldModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'CountryList.dart';

class WorldStat extends StatefulWidget {
  const WorldStat({super.key});

  @override
  State<WorldStat> createState() => _WorldStatState();
}

class _WorldStatState extends State<WorldStat> with TickerProviderStateMixin {
  final colorList = <Color>[Colors.red, Colors.green, Colors.blue];

  late final AnimationController _Controller =
      AnimationController(duration: Duration(seconds: 20), vsync: this)
        ..repeat();

  @override
  void initState() {
    Timer(Duration(seconds: 5), () {});
    super.initState();
  }

  Future<WorldModel> getStatistics() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));

    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return WorldModel.fromJson(data);
    } else {
      throw Exception('No Data Found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Column(
          children: [
            FutureBuilder(
                future: getStatistics(),
                builder: (context, AsyncSnapshot<WorldModel> snapshot) {
                  if (!snapshot.hasData) {
                    return Expanded(
                      flex: 1,
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        controller: _Controller,
                      ),
                    );
                  } else {
                    return Column(children: [
                      const SizedBox(
                        height: 70,
                      ),
                      PieChart(
                        dataMap: {
                          'Cases':
                              double.parse(snapshot.data!.cases!.toString()),
                          'Recovered': double.parse(
                              snapshot.data!.recovered!.toString()),
                          'Deaths':
                              double.parse(snapshot.data!.deaths!.toString()),
                          'Active':
                              double.parse(snapshot.data!.active!.toString()),
                          'Critical':
                              double.parse(snapshot.data!.critical!.toString()),
                        },
                        chartRadius: 120,
                        chartType: ChartType.ring,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left),
                        colorList: const [
                          Colors.red,
                          Colors.green,
                          Colors.blue,
                          Colors.white,
                          Colors.pink,
                        ],
                        animationDuration: const Duration(seconds: 1),
                        chartValuesOptions: const ChartValuesOptions(
                            showChartValuesInPercentage: true),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: Colors.grey,
                        child: Column(
                          children: [
                            UsableRow(
                                name: 'Cases',
                                value: snapshot.data!.cases!.toString()),
                            UsableRow(
                                name: 'Recovered',
                                value: snapshot.data!.recovered!.toString()),
                            UsableRow(
                                name: 'Deaths',
                                value: snapshot.data!.deaths!.toString()),
                            UsableRow(
                                name: 'Active',
                                value: snapshot.data!.active!.toString()),
                            UsableRow(
                                name: 'Critical',
                                value: snapshot.data!.critical!.toString()),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CountryList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Center(
                              child: Text('Countries',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      )
                    ]);
                  }
                })
          ],
        ));
  }
}

class UsableRow extends StatelessWidget {
  String name, value;
  UsableRow({super.key, required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 3),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(name), Text(value)],
            ),
            const Divider(),
          ],
        ));
  }
}
