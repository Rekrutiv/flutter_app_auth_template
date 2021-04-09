import 'dart:async';

import 'package:flutter_app_auth_template/model/cats.dart';
import 'package:flutter_app_auth_template/services/cats_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class CatsEvent extends Equatable {
  const CatsEvent();

  @override
  List<Object> get props => [];
}

class FetchCats extends CatsEvent {
  const FetchCats();

  @override
  List<Object> get props => [];
}

class RefreshCats extends CatsEvent {
  const RefreshCats();

  @override
  List<Object> get props => [];
}

abstract class CatsState extends Equatable {
  @override
  List<Object> get props => [];
}

class CatsEmpty extends CatsState {}

class CatsInitial extends CatsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class CatsLoading extends CatsState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CatsLoaded extends CatsState {
  List<Cat> cats;

  CatsLoaded({ @required this.cats});

  @override
  List<Object> get props => [cats];
}

class CatsLoadingError extends CatsState {
  String error;

  CatsLoadingError({@required this.error});

  @override
  List<Object> get props => [error];
}



class CatsBloc extends Bloc<CatsEvent, CatsState> {
  List<Cat> cats;

  get currentState => state;

  CatsRepository catsRepository;

  CatsBloc(this.catsRepository) : super(null);

  @override
  // TODO: implement initialState
  CatsState get initialState => CatsInitial();

  List<Cat> get getCats {
    return cats;
  }



  @override
  Stream<CatsState> mapEventToState(CatsEvent event) async* {
    if (event is FetchCats) {
      yield* _mapFetchCatsToState(event);
    } else if (event is RefreshCats) {
      yield* _mapRefreshCatsToState(event);
    }
  }

  Stream<CatsState> _mapFetchCatsToState(FetchCats event) async* {
    yield CatsLoading();
    try {

       cats = await catsRepository.getData(0);
      yield CatsLoaded(cats: cats);
      print(cats);
    } catch (e) {
      print( e.toString());
      yield CatsLoadingError(error: e.toString());
    }
  }

  Stream<CatsState> _mapRefreshCatsToState(RefreshCats event) async* {
    try {
      final List<Cat> cats = await  catsRepository.getData(0);
      yield CatsLoaded(cats: cats);
    } catch (_) {
      yield state;
    }
  }
}
