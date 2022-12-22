import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class AnimatedListRoute extends StatefulWidget {
  const AnimatedListRoute({super.key});

  @override
  State<StatefulWidget> createState() => _AnimatedListSampleState();
}

class _AnimatedListSampleState extends State<AnimatedListRoute> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  late ListMode<int> _list;
  int? _selectedItem;
  late int _nextItem;

  @override
  void initState() {
    super.initState();
    _list = ListMode(
        listKey: _listKey,
        removedItemBuilder: _buildRemovedItem,
        initialItems: <int>[0, 1, 2]);
    _nextItem = 3;
  }

  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(animation: animation, item: item);
  }

  void _insert() {
    int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
    logger.d("insert at index: $index");
    _list.insert(index, _nextItem++);
  }

  void _remove() {
    if (_selectedItem != null) {
      int index = _list.indexOf(_selectedItem!);
      logger.d("remove at index: $index");
      _list.removeAt(index);
      setState(() {
        if (_list.length > 0) {
          _selectedItem = _list[_list.length - 1];
        } else {
          _selectedItem = null;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AnimatedList"),
          actions: [
            IconButton(
              onPressed: _insert,
              icon: const Icon(Icons.add_circle),
            ),
            IconButton(
              onPressed: _remove,
              icon: const Icon(Icons.remove_circle),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: (() {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      }),
    );
  }
}

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);

class ListMode<E> {
  ListMode({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : items = List.from(initialItems ?? <E>[]);
  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> items;
  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    items.insert(index, item);
    _animatedList?.insertItem(index);
  }

  E removeAt(int index) {
    E removedItem = items.removeAt(index);
    if (removedItem != null) {
      _animatedList?.removeItem(
          index,
          (context, animation) =>
              removedItemBuilder(removedItem, context, animation));
    }
    return removedItem;
  }

  int get length => items.length;

  E operator [](int index) => items[index];

  int indexOf(E item) => items.indexOf(item);
}

class CardItem extends StatelessWidget {
  const CardItem(
      {super.key,
      required this.animation,
      this.onTap,
      required this.item,
      this.selected = false})
      : assert(item >= 0);
  final Animation<double> animation;
  final VoidCallback? onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
      padding: const EdgeInsets.all(2),
      child: ScaleTransition(
        scale: animation,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            height: 80,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text(
                  "Item $item",
                  style: textStyle,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
