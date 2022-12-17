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

class UpdateTodoEvent extends TodosEvent {
  final String task;
  final String? newTask;

  final bool? checked;

  const UpdateTodoEvent(this.task, this.newTask, this.checked);
  @override
  List<Object> get props => [task];
}
