part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends TodosEvent {
  final String username;

  const LoadTodosEvent(this.username);

  @override
  List<Object> get props => [username];
}

class AddTodoEvent extends TodosEvent {
  final String todoText;

  const AddTodoEvent(this.todoText);

  @override
  List<Object> get props => [todoText];
}

class DeleteTodoEvent extends TodosEvent {
  final String todoTask;

  const DeleteTodoEvent(this.todoTask);
  @override
  List<Object> get props => [todoTask];
}

class ToggleTodoEvent extends TodosEvent {
  final String todoTask;

  const ToggleTodoEvent(this.todoTask);

  @override
  List<Object> get props => [todoTask];
}
