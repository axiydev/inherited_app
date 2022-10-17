import 'package:flutter/material.dart';

/*
Mavzu:::ValueListenableBuilder
*/

//?Value Notifier

class MyValueNotifier extends ValueNotifier<int> {
  MyValueNotifier(super.value);

  void increment() {
    value = value + 1;
  }

  void decrement() {
    if (value > 0) {
      value = value - 1;
    }
  }
}

class HomePageOther extends StatefulWidget {
  const HomePageOther({super.key});

  @override
  State<HomePageOther> createState() => _HomePageOtherState();
}

final myValueNotifier = MyValueNotifier(0);

class _HomePageOtherState extends State<HomePageOther> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: myValueNotifier,
        builder: (context, value, _) => CounterViewOther(count: value));
  }
}

class CounterViewOther extends StatefulWidget {
  final int? count;
  const CounterViewOther({super.key, required this.count});

  @override
  State<CounterViewOther> createState() => _CounterViewOtherState();
}

class _CounterViewOtherState extends State<CounterViewOther> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            widget.count.toString(),
            style: const TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: '0sdjn',
            onPressed: () => myValueNotifier.decrement(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: '1sd',
            onPressed: () => myValueNotifier.increment(),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
