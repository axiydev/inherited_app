import 'package:flutter/material.dart';

import 'inheritedd_notif.dart';

/*
Mavzu:::InheritedWidget
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePageOne(),
    );
  }
}

//? Inherited Widget
class MyInheritedWidget extends InheritedWidget {
  @override
  final Widget child;
  final int count;
  final Function onIncrement;
  final Function onDecrement;
  const MyInheritedWidget(
      {super.key,
      required this.child,
      required this.count,
      required this.onIncrement,
      required this.onDecrement})
      : super(child: child);

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return oldWidget.count != count;
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 0;
  void increment() {
    count++;
    setState(() {});
  }

  void decrement() {
    count--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
        count: count,
        onIncrement: increment,
        onDecrement: decrement,
        child: const CounterView());
  }
}

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  @override
  Widget build(BuildContext context) {
    final inheritedProvider = MyInheritedWidget.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            inheritedProvider!.count.toString(),
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: '0sdjn',
            onPressed: () => inheritedProvider.onDecrement(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: '1sd',
            onPressed: () => inheritedProvider.onIncrement(),
            child: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
