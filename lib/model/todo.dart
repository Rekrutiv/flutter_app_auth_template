import 'package:equatable/equatable.dart';

class Todo extends Equatable{
  final int id;
  final String breed;
  final String imageUrl;
  final bool isCompleted;

  Todo({this.id, this.imageUrl, this.breed, this.isCompleted = false});

  @override
  List<Object> get props => [id, breed, imageUrl, isCompleted];

  Todo copyWith({int id, String todo, String note, bool isCompleted}){
    return Todo(
      id: id ?? this.id,
      breed: todo ?? this.breed,
      imageUrl: note ?? this.imageUrl,
      isCompleted: isCompleted ?? this.isCompleted
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'todo': breed,
      'note': imageUrl,
      'isCompleted': isCompleted ? 1 : 0
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map){
    return Todo(
      id: map['id'],
      breed: map['todo'],
      imageUrl: map['note'],
      isCompleted: map['isCompleted'] == 1 ? true : false
    );
  }
}