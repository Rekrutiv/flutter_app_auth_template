import 'dart:async';
import 'dart:convert';

import 'package:flutter_app_auth_template/model/cats.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';


class CatsRepository {

  Future<List<Cat>> getData(int pageIndex) async {
    List<Cat> newCats = [];
    final url = 'https://api.thecatapi.com/v1/breeds?page=$pageIndex&limit=10';
    final apikey = '084ba1e9-75a2-47d1-9bc0-4a773f8e18dc';
    Response response = await get(url, headers: {'x-api-key': apikey});
    Iterable l = json.decode(response.body);
    List<Cat> cats = List<Cat>.from(l.map((i) => Cat.fromJson(i)));
    await Future.forEach(cats, (cat) async {
      var image = await getImage(cat.id);
      cat.setImage(image);
      newCats.add(cat);
    });
    return newCats;
  }

  Future<String> getImage(String id) async {
    final url = 'https://api.thecatapi.com/v1/images/search?limit=1&breed_id=$id';
    final apikey = '084ba1e9-75a2-47d1-9bc0-4a773f8e18dc';
    Response response = await get(url, headers: {'x-api-key': apikey});
    return json.decode(response.body)[0]['url'];
//  final CatsApiClient catsApiClient;
//
//  List<Cat> catCache;
//
//  CatsRepository({@required this.catsApiClient})
//      : assert(catsApiClient != null);
//
//  Future<List<Cat>> getCats(bool forceUpdate) async {
//    if (catCache != null && !forceUpdate) {
//      return catCache;
//    }
//
//    return catsApiClient.fetchCats().then(
//      (cats) {
//        catCache = cats;
//        return cats;
//      },
//    );
//  }
}}
