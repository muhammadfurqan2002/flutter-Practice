import 'package:api_testing/Covid/World.dart';
import 'package:flutter/material.dart';

class CountryData extends StatefulWidget {
  final String flag, cases, deaths, recovered;
  const CountryData(
      {super.key,
      required this.recovered,
      required this.cases,
      required this.deaths,
      required this.flag});

  @override
  State<CountryData> createState() => _CountryDataState();
}

class _CountryDataState extends State<CountryData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromARGB(255, 65, 66, 66),
        ),
        backgroundColor: const Color.fromARGB(255, 65, 66, 66),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
                  child: Card(
                    color: const Color.fromARGB(255, 123, 133, 150),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        UsableRow(name: 'Cases', value: widget.cases),
                        UsableRow(name: 'Deaths', value: widget.deaths),
                        UsableRow(name: 'Recovered', value: widget.recovered),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(widget.flag),
                  backgroundColor: Colors.white70,
                ),
              ],
            ),
          ],
        ));
  }
}
