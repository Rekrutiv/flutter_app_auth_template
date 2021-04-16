import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_bloc.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_event.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_state.dart';
import 'package:flutter_app_auth_template/model/todo.dart';
import 'package:flutter_app_auth_template/screen/cats/cat_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatCard extends StatelessWidget {
  final int id;
  final String breed;
  final String imageUrl;
  final bool condition;

  const CatCard({this.id, this.breed, this.imageUrl, this.condition});

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
                builder: (context) =>
                    CatDetail(id, imageUrl, breed, condition)),
          );
        },
        child: Column(
          children: <Widget>[
            CatImage(imageUrl: imageUrl),
            SizedBox(height: 20),
//            BreedNameText(breed: breed),
            SizedBox(height: 10),
//            PartialDescription(description: description),
          ],
        ),
      ),
    );
  }
}

class CatImage extends StatefulWidget {
  final catId;
  final imageUrl;
  final breed;

  const CatImage({this.imageUrl, this.catId, this.breed});

  @override
  _CatImageState createState() => _CatImageState();
}

class _CatImageState extends State<CatImage> {
  var contain;

  @override
  void initState() {
    super.initState();
    //+ List<Todo> todos;
  }

  void onTapFavorite(
    String imageUrl,
    List<Todo> todos,
  ) {
    //row["name"].contains(value))
    contain = todos.indexWhere((row) => (row.imageUrl.contains(imageUrl)));
    // print(contain);
    if (contain >= 0) {
      BlocProvider.of<TodoBloc>(context).add(TodoDeleted(todo: todos[contain]));
    } else {
      BlocProvider.of<TodoBloc>(context).add(TodoAdded(
          todo: Todo(
              id: widget.catId,
              breed: widget.breed,
              imageUrl: widget.imageUrl,
              isCompleted: false)));
    }
  }

  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) => Container(
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
                      // contain = state.todos.where((element) => element.imageUrl == widget.imageUrl.toString());
                      onTapFavorite(widget.imageUrl, state.todos),
                    },
                child: Builder(builder: (context) {
                  // any logic needed...
                  //final condition = _whateverLogicNeeded();
                  if (state.todos
                      .where((row) => (row.imageUrl.contains(widget.imageUrl)))
                      .isNotEmpty) {
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
                })
                // getIcon(widget.imageUrl, state.todos)
                ),
          ),
        ]),
      ),
    );
  }
}
