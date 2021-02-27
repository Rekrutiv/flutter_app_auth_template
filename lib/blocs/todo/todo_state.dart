import 'package:equatable/equatable.dart';
import 'package:flutter_app_auth_template/model/todo.dart';


class TodoState extends Equatable{

  final List<Todo> todos;

  factory TodoState.initial(){
//    List<Todo> todos = [
//         Todo(id: 1, todo: 'Learn Dart',note:'b',isCompleted: true),
//
//       ];

    return TodoState(
      todos: null,
    );
  }

  TodoState({this.todos});

  @override
  List<Object> get props => [todos];
}