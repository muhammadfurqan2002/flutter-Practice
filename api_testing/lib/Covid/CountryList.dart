import 'dart:convert';

import 'package:api_testing/Covid/countryData.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList>
    with TickerProviderStateMixin {
  final TextEditingController searchCountry = TextEditingController();

  Future<List<dynamic>> getCountries() async {
    final response =
        await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return data;
    } else {
      throw Exception('Error exist While fetching Information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchCountry,
              decoration: InputDecoration(
                  hintText: 'search country',
                  fillColor: Colors.grey,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: FutureBuilder(
                  future: getCountries(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 5,
                          itemBuilder: (contex, index) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                        width: 50,
                                        color: Colors.white,
                                        height: 10,
                                      ),
                                      title: Container(
                                        width: 50,
                                        color: Colors.white,
                                        height: 10,
                                      ),
                                      subtitle: Container(
                                        width: 50,
                                        color: Colors.white,
                                        height: 10,
                                      ),
                                    ),
                                  ],
                                ));
                          });
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (contex, index) {
                            String name =
                                snapshot.data![index]['country'].toString();

                            if (searchCountry.text.isEmpty) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CountryData(
                                                    flag: snapshot.data![index]
                                                            ['countryInfo']
                                                            ['flag']
                                                        .toString(),
                                                    deaths: snapshot
                                                        .data![index]['deaths']
                                                        .toString(),
                                                    recovered: snapshot
                                                        .data![index]
                                                            ['recovered']
                                                        .toString(),
                                                    cases: snapshot.data![index]
                                                            ['cases']
                                                        .toString(),
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                          width: 50,
                                          image: NetworkImage(snapshot
                                              .data![index]['countryInfo']
                                                  ['flag']
                                              .toString())),
                                      title: Text(snapshot.data![index]
                                              ['country']
                                          .toString()),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  ),
                                ],
                              );
                            } else if (name
                                .toLowerCase()
                                .contains(searchCountry.text.toLowerCase())) {
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => CountryData(
                                                    flag: snapshot.data![index]
                                                            ['countryInfo']
                                                            ['flag']
                                                        .toString(),
                                                    deaths: snapshot
                                                        .data![index]['deaths']
                                                        .toString(),
                                                    recovered: snapshot
                                                        .data![index]
                                                            ['recovered']
                                                        .toString(),
                                                    cases: snapshot.data![index]
                                                            ['cases']
                                                        .toString(),
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: Image(
                                          width: 50,
                                          image: NetworkImage(snapshot
                                              .data![index]['countryInfo']
                                                  ['flag']
                                              .toString())),
                                      title: Text(snapshot.data![index]
                                              ['country']
                                          .toString()),
                                      subtitle: Text(snapshot.data![index]
                                              ['cases']
                                          .toString()),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return Container();
                            }
                          });
                    }
                  })),
        ],
      ),
    );
  }
}
