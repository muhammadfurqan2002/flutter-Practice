import 'dart:async';
import 'dart:convert';
import 'package:api_testing/Models/model1.dart';
import 'package:api_testing/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User1> mylist = [];
  Future<List<User1>> userList() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      mylist.clear();
      for (Map i in data) {
        mylist.add(User1.fromJson(i));
      }
      return mylist;
    } else {
      return mylist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: userList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [Text(snapshot.data![index].title.toString())],
                  ),
                );
              });
            } else {
              return Text('Loading Data');
            }
          }),
    );
  }
}
