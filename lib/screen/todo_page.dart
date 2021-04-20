import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_bloc.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_state.dart';
import 'package:flutter_app_auth_template/model/todo.dart';
import 'package:flutter_app_auth_template/screen/widgets/cat_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state is TodoLoading) {
          return Center(
            child:
                //Text('loading')
                Image.asset(
              "assets/loader.gif",
              height: 150.0,
              width: 150.0,
            ),
          );
        }
        if (state is TodoLoaded) {
          final todos = (state).todos;
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.deepOrangeAccent,
//          appBar: AppBar(
//            actions: <Widget>[
////              IconButton(
////                  icon: Icon(
////                    Icons.exit_to_app,
////                  ),
////                  onPressed: () async {
////                    BlocProvider.of<AuthenticationBloc>(context).add(
////                      AuthenticationExited(),
////                    );
////                    SharedPreferences prefs =
////                        await SharedPreferences.getInstance();
////                    prefs.remove('email');
//////                   MaterialPageRoute(builder: (context) =>LoginMainView());
////                    Navigator.of(context).pushNamed(
////                      '/',
////                    );
////                  }),
//              PopupMenuButton(
//                  onSelected: (value) {
//                    if (value == 'mark_all_completed') {
//                      BlocProvider.of<TodoBloc>(context)
//                          .add(MarkAllCompleted());
//                    } else if (value == 'delete_all_completed') {
//                      BlocProvider.of<TodoBloc>(context)
//                          .add(DeleteAllCompleted());
//                    }
//                  },
//                  itemBuilder: (_) => <PopupMenuItem>[
//                        PopupMenuItem(
//                          child: Text('Mark All Completed'),
//                          value: 'mark_all_completed',
//                        ),
//                        PopupMenuItem(
//                          child: Text('Delete All Completed'),
//                          value: 'delete_all_completed',
//                        )
//                      ])
//            ],
//            title: Text('Todo List'),
//          ),
              body: Stack(alignment: Alignment.topCenter, children: [
                ClipPath(
                  clipper: WaveClipperOne(reverse: false),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.8,
                    width: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.cyan,
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(' Favorites Cat',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Open Sans',
                                fontSize: 40))),
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
                  child:
                  _buildBody(todos),
                ),
              ]),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildBody(List<Todo> todos) {
    if (todos == null) {
      return Container();
    }

    if (todos.length == 0) {
      return Center(child: Text('No Todo Found'));
    }

    return LiveList(
        // padding: EdgeInsets.all(10),
        itemCount: todos.length,
        itemBuilder: (context, position, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0.9),
                end: Offset.zero,
              ).animate(animation),
              child: Hero(
                tag: 'imgHero${todos[position].imageUrl}',
                child: CatCard(
                  breed: todos[position].breed,
                  imageUrl: todos[position].imageUrl,
                  condition: false,
                  todos: todos,
                ),
              ),
            )));
  }
}
