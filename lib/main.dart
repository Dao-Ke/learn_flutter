import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(items: List.generate(200, (index) => "Item $index")));
}

class MyApp extends StatelessWidget {
  final List<String> items;
  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text("List"),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: ((context, index) {
            return ListTile(
              title: Center(child: Text(items[index])),
            );
          })),
    ));
  }
}
