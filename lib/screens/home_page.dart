import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sec_b_sqflite/screens/add_todo_screen.dart';
import 'package:sec_b_sqflite/screens/view_todo_screen.dart';
import 'package:sqflite/sqflite.dart';

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
          final todoList = await Navigator.push(
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
          }
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.home,
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
              SizedBox(
                width: (size.width / 2) - 28,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.home,
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
