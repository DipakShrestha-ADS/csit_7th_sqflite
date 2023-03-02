import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sec_b_sqflite/screens/view_todo_screen.dart';
import 'package:sec_b_sqflite/stateManagement/bloc/cubit/counter_bloc_page.dart';
import 'package:sec_b_sqflite/stateManagement/provider/counter_change_notifier.dart';
import 'package:sec_b_sqflite/stateManagement/provider/counter_provider_page.dart';
import 'package:sec_b_sqflite/stateManagement/stacked/counter_stacked_page.dart';
import 'package:sec_b_sqflite/stateManagement/stacked/counter_view_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stacked/stacked.dart';

import '../stateManagement/bloc/todo_bloc.dart';
import '../stateManagement/bloc/todo_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.db}) : super(key: key);
  final Database db;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
      ),
      body: ViewTodoScreen(
        db: widget.db,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'test',
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () async {
          /*final todoList = await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (ctx) {
                return AddTodoScreen(
                  db: widget.db,
                );
              },
            ),
          );
          if (todoList != null) {
            setState(() {});
          }*/
          context.read<TodoBloc>().add(GetAllTodo());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 12,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: (size.width / 2) - 28,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return ChangeNotifierProvider.value(
                                value: CounterChangeNotifier(),
                                child: CounterProviderPage(),
                              );
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.person,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return ViewModelBuilder.reactive(
                                viewModelBuilder: () => CounterViewModel(),
                                builder: (ctx, vm, child) {
                                  return CounterStackedPage();
                                },
                              );
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.home,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: (size.width / 2) - 28,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return CounterBlocPage();
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.person,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.home,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
