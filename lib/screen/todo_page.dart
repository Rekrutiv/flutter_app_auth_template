import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/authenticaiton/bloc/authentication_bloc.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_bloc.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_event.dart';
import 'package:flutter_app_auth_template/blocs/todo/todo_state.dart';
import 'package:flutter_app_auth_template/model/todo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_edit_page.dart';

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.deepOrangeAccent,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                  ),
                  onPressed: () async {
                    BlocProvider.of<AuthenticationBloc>(context).add(
                      AuthenticationExited(),
                    );
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('email');
//                   MaterialPageRoute(builder: (context) =>LoginMainView());
                    Navigator.of(context).pushNamed(
                      '/',
                    );
                  }),
              PopupMenuButton(
                  onSelected: (value) {
                    if (value == 'mark_all_completed') {
                      BlocProvider.of<TodoBloc>(context)
                          .add(MarkAllCompleted());
                    } else if (value == 'delete_all_completed') {
                      BlocProvider.of<TodoBloc>(context)
                          .add(DeleteAllCompleted());
                    }
                  },
                  itemBuilder: (_) => <PopupMenuItem>[
                        PopupMenuItem(
                          child: Text('Mark All Completed'),
                          value: 'mark_all_completed',
                        ),
                        PopupMenuItem(
                          child: Text('Delete All Completed'),
                          value: 'delete_all_completed',
                        )
                      ])
            ],
            title: Text('Todo List'),
          ),
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              ClipPath(
                clipper: WaveClipperOne(reverse: false),
                child: Container(
                  height: MediaQuery.of(context).size.width * 0.8,
                  width: MediaQuery.of(context).size.width * 0.9,
                  color: Colors.cyan,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: Text('List of Food',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open Sans',
                              fontSize: 40))),
                ),
              ),
              Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
                  child: _buildBody(state.todos)),
            ],
          ),
//        _buildBody(state.todos),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        fullscreenDialog: true, builder: (_) => AddEditPage()));
              }),
        ),
      ),
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
                child: ClipOval(
                  child: Card(
                    color: Colors.lime,
                    shadowColor: Colors.lightGreenAccent,
                    child: ListTile(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                fullscreenDialog: true,
                                builder: (_) =>
                                    AddEditPage(todo: todos[position]))),
                        title: Text(
                          todos[position].todo,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open Sans',
                              fontSize: 22),
                        ),
                        subtitle: Text(
                          todos[position].note,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open Sans',
                              fontSize: 20),
                        ),
                        leading: Checkbox(
                          value: todos[position].isCompleted,
                          onChanged: (_) {
                            BlocProvider.of<TodoBloc>(context).add(TodoUpdated(
                                todo: todos[position].copyWith(
                                    isCompleted:
                                        !todos[position].isCompleted)));
                          },
                        ),
                        trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              BlocProvider.of<TodoBloc>(context)
                                  .add(TodoDeleted(todo: todos[position]));
                            })),
                  ),
                ))));
  }
}
