import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:bloc_hive_todo/services/todo.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'bloc/todos_bloc.dart';
import 'new_todo.dart';

class TodosPage extends StatelessWidget {
  final String username;
  const TodosPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Tasks'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoService>(context))
              ..add(LoadTodosEvent(username)),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(
                children: [
                  ...state.tasks.map(
                    (e) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: Slidable(
                        endActionPane: ActionPane(
                            extentRatio: 0.3,
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                flex: 3,
                                onPressed: (context) {
                                  BlocProvider.of<TodosBloc>(context)
                                      .add(DeleteTodoEvent(e.task));
                                },
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              )
                            ]),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.amber[200]),
                          child: ListTile(
                            title: Text(
                              e.task,
                              style: TextStyle(
                                  decorationThickness: 3,
                                  decoration: e.completed
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: e.completed
                                      ? Colors.black26
                                      : Colors.black),
                            ),
                            // subtitle: e. ? Text(e.task) : null,
                            trailing: Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                shape: const CircleBorder(),
                                activeColor: Colors.amber,
                                value: e.completed,
                                onChanged: (value) {
                                  BlocProvider.of<TodosBloc>(context)
                                      .add(ToggleTodoEvent(e.task));
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: const Text('+ New task'),
                    onTap: () async {
                      final result = await showModalBottomSheet<String>(
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return const AddNewTask();
                        },
                      );

                      if (result != null) {
                        BlocProvider.of<TodosBloc>(context)
                            .add(AddTodoEvent(result));
                      }
                    },
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
