import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_bloc.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_event.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_state.dart';
import 'package:flutter_app_auth_template/model/cats.dart';
import 'package:flutter_app_auth_template/model/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatDetail extends StatefulWidget {
  bool condition;
  int id;
  String catImage;
  String breed;

  CatDetail(this.id, this.catImage, this.breed, this.condition);

  @override
  _CatDetailState createState() =>
      _CatDetailState(this.id, this.catImage, this.breed);
}

class _CatDetailState extends State<CatDetail> {
  int id;
  String catImage;
  String breed;

  _CatDetailState(this.id, this.catImage, this.breed);

  @override
  Widget build(BuildContext context) {
    var contain;
    List<Todo> todos;
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              widget.condition
                  ? IconButton(
                      icon: Icon(
                        Icons.add,
                      ),
                      onPressed: () async {
                        BlocProvider.of<TodoBloc>(context).add(TodoAdded(
                            todo: Todo(
                                id: id,
                                breed: breed,
                                imageUrl: catImage,
                                isCompleted: false)));
                      })
                  : IconButton(
                      icon: Icon(
                        Icons.delete,
                      ),
                      onPressed: () async {
                        todos = state.todos;
                        contain = todos.indexWhere(
                            (row) => (row.imageUrl.contains(catImage)));
                        print(contain);

                        BlocProvider.of<TodoBloc>(context)
                            .add(TodoDeleted(todo: todos[contain]));
                      }),
            ],
            title: Text('Todo List'),
          ),
          backgroundColor: Colors.green,
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                  child: Hero(
                    tag: 'imgHero${catImage}',
                    child: Image(
                      filterQuality: FilterQuality.medium,
                      image: NetworkImage(catImage),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    color: Colors.brown[400],
                  ),
                  child: Text(breed ?? 'no breed',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )),
    );
  }
}
