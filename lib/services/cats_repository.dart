import 'dart:async';

import 'package:flutter_app_auth_template/model/cats.dart';
import 'package:meta/meta.dart';

import 'cats_api_client.dart';

class CatsRepository {
  final CatsApiClient catsApiClient;

  List<Cat> catCache;

  CatsRepository({@required this.catsApiClient})
      : assert(catsApiClient != null);

  Future<List<Cat>> getCats(bool forceUpdate) async {
    if (catCache != null && !forceUpdate) {
      return catCache;
    }

    return catsApiClient.fetchCats().then(
      (cats) {
        catCache = cats;
        return cats;
      },
    );
  }
}
