
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/bloc/food_bloc.dart';
import 'package:flutter_app_auth_template/bloc/food_event.dart';
import 'package:flutter_app_auth_template/model/food.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.tealAccent,
        resizeToAvoidBottomPadding: false,
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

            SingleChildScrollView(

              padding: EdgeInsets.all(26),
              child: Center(
                child: FoodList(),
              ),
            ),
          ],
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
      ),
    );
  }
}
