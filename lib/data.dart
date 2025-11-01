import 'dart:convert';

import 'package:flutter/services.dart';

Future<List<dynamic>> loadData() async {
  final String response = await rootBundle.loadString("assets/azkar.json");
  final  data = json.decode(response);

  return data;
}
