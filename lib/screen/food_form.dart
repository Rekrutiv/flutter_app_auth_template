
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/bloc/food_bloc.dart';
import 'package:flutter_app_auth_template/bloc/food_event.dart';
import 'package:flutter_app_auth_template/model/food.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'food_list.dart';



class FoodForm extends StatefulWidget {
  @override
  _FoodFormState createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  String _foodname;
  String _foodresponse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffd7deff),
      appBar: AppBar(title: Text('Coding')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(36),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Bloc Example',
                style: TextStyle(fontSize: 42),
              ),
              FoodList(),
            ],
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                child: Dialog(
                    child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(labelText: 'Food'),
                        style: TextStyle(fontSize: 22),
                        onChanged: (text) {
                          setState(() {
                            _foodname = text;
                          });
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'User Response'),
                        style: TextStyle(fontSize: 22),
                        onChanged: (text) {
                          setState(() {
                            _foodresponse = text;
                          });
                        },
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      FlatButton(
                        child: Text("Добавити штрихкод"),
                        onPressed: () {
                          setState(() {
                            BlocProvider.of<FoodBloc>(context).add(
                              FoodEvent.add(Food(_foodname, _foodresponse)),
                            );
                            Navigator.pop(context);
                          });
                        },
                      )
                    ],
                  ),
                )));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
