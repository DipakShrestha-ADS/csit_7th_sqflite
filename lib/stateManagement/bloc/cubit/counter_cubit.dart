import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() {
    int oldCounterValue = state;
    print('oldCounter Value increment: $oldCounterValue');
    oldCounterValue++;
    emit(oldCounterValue);
  }

  void decrement() {
    int oldCounterValue = state;
    print('oldCounter Value decrement: $oldCounterValue');
    oldCounterValue--;
    emit(oldCounterValue);
  }
}
