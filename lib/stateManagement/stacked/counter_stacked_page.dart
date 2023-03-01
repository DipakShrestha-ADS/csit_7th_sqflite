import 'package:flutter/material.dart';
import 'package:sec_b_sqflite/stateManagement/stacked/counter_view_model.dart';
import 'package:stacked/stacked.dart';

class CounterStackedPage extends ViewModelWidget<CounterViewModel> {
  const CounterStackedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, viewModel) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
      ),
      body: Center(
        child: Text(
          'Counter Value : ${viewModel.counter}',
        ),
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            onPressed: () {
              viewModel.increment();
            },
            child: Icon(
              Icons.add,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              viewModel.decrement();
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
