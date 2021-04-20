import 'package:flutter_app_auth_template/blocs/todo/todo_event.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_state.dart';
import 'package:flutter_app_auth_template/db/todo_provider.dart';
import 'package:flutter_app_auth_template/model/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoProvider todoProvider;

  get currentState => state;

  TodoState get initialState => TodoLoading();

  TodoBloc({this.todoProvider}) : super(TodoLoading());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is LoadTodo) {
      yield* _mapLoadTodoToState();
    } else if (event is TodoAdded) {
      yield* _mapTodoAddedToState(event);
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is MarkAllCompleted) {
      yield* _mapMarkAllCompletedToState(event);
    }
//    else if (event is DeleteAllCompleted) {
//      yield* _mapDeleteAllCompletedToState(event);
//    }
  }

  Stream<TodoState> _mapLoadTodoToState() async* {
    try {
      final todos = await todoProvider.getAll();
      yield TodoLoaded(todos: todos);
    } catch (e) {
      yield TodoLoadingError(error: e);
    }
  }

  Stream<TodoState> _mapTodoAddedToState(TodoAdded event) async* {
    if (currentState is TodoLoaded) {
      final List<Todo> updatedTodos =
          List.from((currentState as TodoLoaded).todos)
            ..add(await todoProvider.insert(event.todo));
      yield TodoLoaded(todos: updatedTodos);
    }
  }

  Stream<TodoState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    todoProvider.update(event.todo);
    if (state is TodoLoaded) {
      final List<Todo> updatedTodos = (state as TodoLoaded).todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      yield TodoLoaded(todos: updatedTodos);
      // _saveTodos(updatedTodos);
    }
  }


  Stream<TodoState> _mapTodoDeletedToState(TodoDeleted todosEvent) async* {
    todoProvider.delete(todosEvent.todo);
    if (state is TodoLoaded) {
      final updatedTodos = (state as TodoLoaded)
          .todos
          .where((todo) => todo.id != todosEvent.todo.id)
          .toList();
      yield TodoLoaded(todos: updatedTodos);
      //_saveTodos(updatedTodos);
    }
  }

  Stream<TodoState> _mapMarkAllCompletedToState(
      MarkAllCompleted todosEvent) async* {
    todoProvider.markAllCompleted();
    if (state is TodoLoaded) {
      final updatedTodos = (state as TodoLoaded).todos.map((e) {
        return e.copyWith(isCompleted: true);
      }).toList();
      yield TodoLoaded(todos: updatedTodos);
      //_saveTodos(updatedTodos);
    }
  }

//  Stream<TodoState> _mapDeleteAllCompletedToState(
//      MarkAllCompleted todosEvent) async* {
//    todoProvider.deleteAllCompleted();
//    if (state is TodoLoaded) {
//      final updatedTodos = (state as TodoLoaded).
//        todos.where((element) => !element.isCompleted).toList();
//      yield TodoLoaded(todos: updatedTodos);
//      //_saveTodos(updatedTodos);
//    }
//  }

}
