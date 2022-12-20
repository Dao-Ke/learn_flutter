import 'package:flutter/material.dart';
import 'package:learn_flutter/list/learn_list.dart';

void main() {
  runApp(MyApp(items: _buildMainRouteList()));
}

Map<String, Widget> _buildMainRouteList() {
  return {
    "Learn List": const ListRoute(),
    "Learn List2": const ListRoute(),
    "Learn List3": const ListRoute(),
    "Learn List4": const ListRoute(),
  };
}

class MyApp extends StatelessWidget {
  final Map<String, Widget> items;
  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("List"),
      ),
      body: buildSimpleList(items),
    ));
  }
}
