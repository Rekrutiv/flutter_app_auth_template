//import 'package:flutter/material.dart';
//import 'package:flutter_app_auth_template/blocs/todo/todo_bloc.dart';
//import 'package:flutter_app_auth_template/blocs/todo/todo_event.dart';
//import 'package:flutter_app_auth_template/blocs/todo/todo_state.dart';
//import 'package:flutter_app_auth_template/model/todo.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:hive/hive.dart';
//
//class Favorites extends StatefulWidget {
//  @override
//  _FavoritesState createState() => _FavoritesState();
//}
//
//class _FavoritesState extends State<Favorites> {
// var favoriteCatsBox = Hive.box('favorite_cats');
//  List<String> favorites = [];
//
//  @override
//  void initState() {
//    super.initState();
//
//  }
//
//  void readFavorites(Box favoriteCatsBox) {
//    for (int index = 0; index < favoriteCatsBox.length; index++) {
//      favorites.add(favoriteCatsBox.getAt(index));
//      favorites.sort();
//    }
//  }
//
//  void updateFavorites(Box favoriteCatsBox) {
//    List<String> newFavorites = [];
//    for (int index = 0; index < favoriteCatsBox.length; index++) {
//      newFavorites.add(favoriteCatsBox.getAt(index));
//      newFavorites.sort();
//    }
//    setState(() {
//      favorites = newFavorites;
//    });
//  }
//
//  Widget getIcon(String catId,List<Todo> todos) {
////    BlocProvider.of<TodoBloc>(context).add(TodoAdded(todo: Todo(
////        todo: _todoController.text,
////        note: _noteController.text
////    )));
//
//    if (todos.contains(catId)) {
//      return (Icon(
//        Icons.favorite,
//        color: Colors.red,
//        size: 30,
//      ));
//    }
//    return (Icon(
//      Icons.favorite_border,
//      color: Colors.red,
//      size: 30,
//    ));
//  }
//
//  void onTapFavorite(String catId,List<Todo> todos) {
//    if (todos.contains(catId)) {
//
//      setState(() {
//        getIcon(catId,todos);
//        //updateFavorites(favoriteCatsBox);
//      });
//    } else {
//
//      setState(() {
//        getIcon(catId);
//        updateFavorites(favoriteCatsBox);
//      });
//    }
//  }
//
//  Widget build(BuildContext context) {
//    if (favorites.length > 0) {
//      return  BlocBuilder<TodoBloc, TodoState>(
//          builder: (context, state) =>
//         Scaffold(
//
//          body: SafeArea(
//            child: Center(
//              child: ListView.builder(
//                  itemCount: favorites.length,
//                  itemBuilder: (context, index) {
//                    List<Todo> todos1  = state.todos;
//                    final favoriteCat = favorites[index];
//                    return Card(
//                      child: InkWell(
//                        onTap: () {},
//                        splashColor: Colors.grey,
//                        child: ListTile(
//                          title: Text(favoriteCat),
//                          subtitle: Text('Description Here'),
//                          trailing: GestureDetector(
//                            onTap: () => onTapFavorite(favoriteCat),
//                            child:
//                            getIcon(favoriteCat),
//                          ),
//                        ),
//                      ),
//                    );
//                  }),
//            ),
//          ),
//        ),
//      );
//    } else {
//      return Scaffold(
//        body: Center(
//          child: Text(
//            "It looks like you don't have any favorites yet...   :(",
//            style: TextStyle(fontSize: 15.0),
//
//          ),
//        ),
//      );
//    }
//  }
//}
