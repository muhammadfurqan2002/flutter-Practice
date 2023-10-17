import 'dart:convert';
// import 'dart:html';
import 'dart:async';

import 'package:api_testing/Models/model2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Model2> myList = [];

  Future<List<Model2>> getPhoto() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      myList.clear();
      for (Map i in data) {
        Model2 m = Model2(title: i['title'], url: i['url']);
        myList.add(m);
      }
      return myList;
    } else {
      return myList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal,
        appBar: AppBar(
          title: const Center(child: Text('Home Screen')),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPhoto(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Data is loading');
                    } else {
                      return ListView.builder(
                          itemCount: myList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              // leading: CircleAvatar(backgroundImage: NetworkImage(),
                              title: Text(myList[index].title.toString()),
                            );
                          });
                    }
                  }),
            ),
            Expanded(
              flex: 3,
              child: FutureBuilder(
                  future: getPhoto(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Data is loading');
                    } else {
                      return ListView.builder(
                          itemCount: myList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                                leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(myList[index].url.toString()),
                              // title: Text(myList[index].title.toString()),
                            ));
                          });
                    }
                  }),
            ),
          ],
        ));
  }
}
