import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'Models/model3.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;
  Future<void> getUser() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Data is Loading ');
            } else {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(children: [
                        Text(data[index]['name'].toString()),
                        // Text(data[index][''].toString()),
                      ]),
                    );
                  });
            }
          }),
    );
  }
}
