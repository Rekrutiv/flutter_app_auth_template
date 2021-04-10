import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_bloc.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_event.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_state.dart';
import 'package:flutter_app_auth_template/model/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CatCard extends StatelessWidget {
  final String breed;
  final String imageUrl;
  final String description;

  const CatCard({this.breed, this.imageUrl, this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      shadowColor: Colors.black,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        splashColor: Colors.black12,
        onTap: () {},
        child: Column(
          children: <Widget>[
            CatImage(imageUrl: imageUrl, catId: breed),
            SizedBox(height: 20),
            BreedNameText(breed: breed),
            SizedBox(height: 10),
            PartialDescription(description: description),
          ],
        ),
      ),
    );
  }
}

class BreedNameText extends StatelessWidget {
  final String breed;

  BreedNameText({this.breed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          breed,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 26,
          ),
        ),
      ),
    );
  }
}

class CatImage extends StatefulWidget {
  final catId;
  final imageUrl;

  const CatImage({this.imageUrl, this.catId});

  @override
  _CatImageState createState() => _CatImageState();
}

class _CatImageState extends State<CatImage> {
  @override
  void initState() {
    super.initState();
  }



  Widget getIcon(int catId, List<Todo> todos) {
    var contain = todos.where((element) => element.id == catId.toString());

    if (contain.isNotEmpty) {
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
  }

  void onTapFavorite(int catId, List<Todo> todos, ) {
    var contain = todos.where((element) => element.id == catId.toString());
    if (contain.isNotEmpty) {
      BlocProvider.of<TodoBloc>(context)
          .add(TodoDeleted(todo: todos[1]));
    } else {

      BlocProvider.of<TodoBloc>(context)
          .add(TodoAdded(todo: Todo(id: catId, breed: 'widget.imageUrl', imageUrl:'jcvbjbj',isCompleted: false )));
    }
  }

  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) => Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                return progress == null
                    ? child
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              },
            ),
          ),
          new Positioned(
            bottom: 25.0,
            right: 25,
            child: InkWell(
                onTap: () =>
                onTapFavorite(widget.catId,state.todos),
                child: getIcon(widget.catId, state.todos)),
          ),
        ]),
      ),
    );
  }
}

class PartialDescription extends StatelessWidget {
  final String description;

  PartialDescription({this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Description',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              description.substring(0, 50) + '...',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}
