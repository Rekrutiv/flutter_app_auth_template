
import 'package:flutter_app_auth_template/bloc/food_event.dart';
import 'package:flutter_app_auth_template/model/food.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FoodBloc extends Bloc<FoodEvent, List<Food>> {
  FoodBloc(List<Food> initialState) : super(initialState);

  List<Food> get initialState => List<Food>();



  @override
  Stream<List<Food>> mapEventToState(FoodEvent event) async* {
    switch (event.eventType) {
      case EventType.add:
        List<Food> newState = List.from(state);
        if (event.food != null) {
          newState.add(event.food);
        }
        yield newState;
        break;
      case EventType.delete:
        List<Food> newState = List.from(state);
        print(newState.length);
        newState.removeAt(event.foodIndex);
        yield newState;
        break;
      default:
        throw Exception('Event not found $event');
    }
  }
}
