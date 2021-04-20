import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/model/todo.dart';

abstract class TodoState extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoEmpty extends TodoState {}

class TodoInitial extends TodoState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class TodoLoading extends TodoState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TodoLoaded extends TodoState {
  List<Todo> todos;

  TodoLoaded({ @required this.todos});

  @override
  List<Object> get props => [todos];
}

class TodoLoadingError extends TodoState {
  String error;

  TodoLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}

