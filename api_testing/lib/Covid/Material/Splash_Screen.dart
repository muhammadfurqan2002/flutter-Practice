import 'package:api_testing/Covid/World.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => WorldStat()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
            ),
            Center(
              child: AnimatedBuilder(
                  animation: _controller,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: const Center(
                        child: Image(
                      image: AssetImage('images/virus.png'),
                    )),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * pi,
                      child: child,
                    );
                  }),
            ),
            const SizedBox(
              height: 70,
            ),
            const Align(
              alignment: Alignment.center,
              child: Center(
                  child: Text(
                'Covid-19 \n tracking app',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey),
              )),
            )
          ],
        ));
  }
}
