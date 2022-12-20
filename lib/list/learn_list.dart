import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildSimpleList(Map<String, Widget> items) {
  List titles = items.keys.toList(growable: false);
  List routes = items.values.toList(growable: false);
  return ListView.separated(
    itemCount: items.length,
    itemBuilder: ((context, index) {
      return ListTile(
        title: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => routes[index])));
            },
            child: Center(child: Text(titles[index]))),
      );
    }),
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}

class ListRoute extends StatelessWidget {
  final Map<String, Widget> items = {};
  ListRoute({super.key}) {
    for (var element in List.generate(10, (index) => "Item $index")) {
      items[element] = SimpleListRoute();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListRoute"),
      ),
      body: buildSimpleList(items),
    );
  }
}

class SimpleListRoute extends StatelessWidget {
  final List<String> items = List.generate(200, (index) => "Item $index");
  SimpleListRoute({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SimpleListRoute"),
      ),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: ((context, index) {
          return ListTile(
            title: Center(child: Text(items[index])),
          );
        }),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
