import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:sec_b_sqflite/stateManagement/bloc/cubit/counter_cubit.dart';

class CounterBlocPage extends StatelessWidget {
  const CounterBlocPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Page'),
      ),
      body: Center(
        ///bloc consumer
        child: BlocConsumer<CounterCubit, int>(
          listener: (ctx, counter) {
            print('counter in liseterner: $counter');
          },
          builder: (ctx, counter) {
            return Text(
              'Counter Value : ${counter}',
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().increment();
            },
            child: Icon(
              Icons.add,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
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
