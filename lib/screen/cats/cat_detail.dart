import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/model/cats.dart';


class CatDetail extends StatefulWidget {
  String cat;
  String descrition;
  CatDetail(this.cat,this.descrition);

  @override
  _CatDetailState createState() => _CatDetailState(this.cat,this.descrition);
}

class _CatDetailState extends State<CatDetail> {
  String cat;
  String descrition;

  _CatDetailState(this.cat,this.descrition);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                child: Hero(
                  tag: 'imgHero${cat}',
                  child: Image(
                    filterQuality: FilterQuality.medium,
                    image: NetworkImage(cat),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10.0),
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.brown[400],
                ),
                child: Text(descrition,style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ));
  }
}
