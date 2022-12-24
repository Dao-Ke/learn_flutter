import 'package:flutter/material.dart';
import 'package:learn_flutter/list/learn_list.dart';
import 'package:learn_flutter/list/learn_animated_list.dart';
import 'package:learn_flutter/list/mediaplayer.dart';

void main() {
  runApp(MyApp(items: _buildMainRouteList()));
}

Map<String, Widget> _buildMainRouteList() {
  return {
    "Learn List": ListRoute(),
    "Simple List": SimpleListRoute(),
    "AnimatedList": const AnimatedListRoute(),
    "AudioPayer": const AudioPlayerRoute(),
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
      ),
    );
  }
}
