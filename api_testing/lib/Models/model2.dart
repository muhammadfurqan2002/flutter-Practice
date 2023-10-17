import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Model2 {
  int? id, album;
  String? title, url, thumbnailUrl;
  Model2({required this.title, required this.url});
}
