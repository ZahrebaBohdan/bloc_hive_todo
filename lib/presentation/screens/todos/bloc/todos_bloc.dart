import 'package:bloc_hive_todo/services/todo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/task.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = _todoService.getTasks(event.username);
      emit(TodosLoadedState(todos, event.username));
    });

    on<AddTodoEvent>((event, emit) {
      final currentState = state as TodosLoadedState;
      _todoService.addTask(event.todoText, currentState.username);
      add(LoadTodosEvent(currentState.username));
    });

    on<DeleteTodoEvent>((event, emit) {
      final currentstate = state as TodosLoadedState;
      _todoService.deleteTask(event.todoTask, currentstate.username);
      add(LoadTodosEvent(currentstate.username));
    });

    on<UpdateTodoEvent>((event, emit) {
      final currentstate = state as TodosLoadedState;
      _todoService.updateTask(
          event.task, event.newTask, event.checked, currentstate.username);
      add(LoadTodosEvent(currentstate.username));
    });
  }
}
