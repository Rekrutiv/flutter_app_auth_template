import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/bloc/food_bloc.dart';
import 'package:flutter_app_auth_template/bloc/food_event.dart';
import 'package:flutter_app_auth_template/model/food.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoodList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: BlocConsumer<FoodBloc, List<Food>>(
          buildWhen: (List<Food> previous, List<Food> current) {
            return true;
          },
          listenWhen: (List<Food> previous, List<Food> current) {
            if (current.length > previous.length) {
              return true;
            }

            return false;
          },
          builder: (context, foodList) {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(16),
              itemCount: foodList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(foodList[index].name),
                    subtitle: Text(foodList[index].responseUser),
                    onTap: () => BlocProvider.of<FoodBloc>(context).add(
                      FoodEvent.delete(index),
                    ),
                  ),
                );
              },
            );
          },
          listener: (BuildContext context, foodList) {
            Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Added!')),
            );
          },
        ));
  }
}
