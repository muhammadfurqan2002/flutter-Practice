import 'package:flutter/material.dart';

import 'dart:async';

import 'package:http/http.dart' as http;

class User1 {
  int? userId;
  int? id;
  String? title;
  String? body;

  User1({this.userId, this.id, this.title, this.body});

  User1.fromJson(Map<dynamic, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['userId'] = this.userId;
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    return data;
  }
}