import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sec_b_sqflite/stateManagement/provider/counter_change_notifier.dart';

class CounterProviderPage extends StatelessWidget {
  const CounterProviderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
      ),
      body: Center(
        child: Text(
          'Counter Value : ${context.watch<CounterChangeNotifier>().counter}',
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterChangeNotifier>().increment();
            },
            child: Icon(
              Icons.add,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterChangeNotifier>().decrement();
            },
            child: Icon(
              Icons.remove,
            ),
          ),
        ],
      ),
    );
  }
}
