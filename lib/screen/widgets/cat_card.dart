import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_bloc.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_event.dart';
import 'package:flutter_app_auth_template/model/todo.dart';
import 'package:flutter_app_auth_template/screen/cats/cat_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatCard extends StatefulWidget {
  final int id;
  final String breed;
  final String imageUrl;
  final bool condition;
  final List<Todo> todos;

  const CatCard(
      {this.id, this.breed, this.imageUrl, this.condition, this.todos});

  @override
  _CatCardState createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  void onTapFavorite(
    String imageUrl,
  ) {
    //row["name"].contains(value))
    final contain =
        widget.todos.indexWhere((row) => (row.imageUrl.contains(imageUrl)));
    // print(contain);
    if (contain >= 0) {
      BlocProvider.of<TodoBloc>(context)
          .add(TodoDeleted(todo: widget.todos[contain]));
    } else {
      BlocProvider.of<TodoBloc>(context).add(TodoAdded(
          todo: Todo(
              id: widget.id,
              breed: widget.breed,
              imageUrl: widget.imageUrl,
              isCompleted: false)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      shadowColor: Colors.black,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.black12,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CatDetail(widget.id, widget.imageUrl,
                    widget.breed, widget.condition)),
          );
        },
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Stack(children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Positioned(
                    bottom: 25.0,
                    right: 25,
                    child: InkWell(
                      onTap: () => {
                        onTapFavorite(widget.imageUrl),
                      },
                      child: Builder(builder: (context) {
                        // any logic needed...
                        // print(state.todos);
                        final _condition = widget.todos
                            .where((row) =>
                                (row.imageUrl.contains(widget.imageUrl)))
                            .isNotEmpty;
                        if (_condition) {
                          return (Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          ));
                        } else {
                          return (Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                            size: 30,
                          ));
                        }

//                Builder(builder: (context) {
//                  state.todos
//                      .where((row) => (row.imageUrl.contains(widget.imageUrl)))
//                      .isNotEmpty
//                      ? Icon(
//                    Icons.favorite,
//                    color: Colors.red,
//                    size: 30,
//                  )
//                      : Icon(
//                    Icons.favorite,
//                    color: Colors.red,
//                    size: 30,
//                  );
//
//
//                }
////                        return (Icon(
////                          Icons.favorite,
////                          color: Colors.red,
////                          size: 30,
////                        ));
////                      } else {
////                        return (Icon(
////                          Icons.favorite_border,
////                          color: Colors.red,
////                          size: 30,
////                        ));
////                      }
//              )
                        // getIcon(widget.imageUrl, state.todos)
                      }),
                    ))
              ]),
            ),

//            CatImage(imageUrl: widget.imageUrl),
          ],
        ),
      ),
    );
  }
}
