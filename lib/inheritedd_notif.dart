import 'package:flutter/material.dart';

/*
Mavzu:::InheritedNotifier, ChangeNotifier,ValueNotifier
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

class MyChangeNotifier with ChangeNotifier {
  int? count;
  MyChangeNotifier({required this.count});

  void increment() {
    count = count! + 1;
    notifyListeners();
  }

  void decrement() {
    if (count! > 0) {
      count = count! - 1;
      notifyListeners();
    }
  }
}

class MyInheritedNotifier extends InheritedNotifier<MyChangeNotifier> {
  @override
  final MyChangeNotifier notifier;
  @override
  final Widget child;
  const MyInheritedNotifier(
      {super.key, required this.notifier, required this.child})
      : super(notifier: notifier, child: child);
  static int? of(BuildContext context) {
    final countData =
        context.dependOnInheritedWidgetOfExactType<MyInheritedNotifier>();
    return countData!.notifier.count;
  }
}

class HomePageOne extends StatefulWidget {
  const HomePageOne({super.key});

  @override
  State<HomePageOne> createState() => _HomePageOneState();
}

final myValueNotifier = MyValueNotifier(0);
final MyChangeNotifier myChangeNotifier = MyChangeNotifier(count: 0);

class _HomePageOneState extends State<HomePageOne> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return MyInheritedNotifier(
        notifier: myChangeNotifier,
        child: Builder(builder: (context) {
          return CounterViewOne(
            count: MyInheritedNotifier.of(context),
          );
        }));
  }
}

class CounterViewOne extends StatefulWidget {
  final int? count;
  const CounterViewOne({super.key, required this.count});

  @override
  State<CounterViewOne> createState() => _CounterViewOneState();
}

class _CounterViewOneState extends State<CounterViewOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            widget.count.toString(),
            style: const TextStyle(
                fontSize: 40, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: '0sdjn',
            onPressed: () => myChangeNotifier.decrement(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: '1sd',
            onPressed: () => myChangeNotifier.increment(),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
