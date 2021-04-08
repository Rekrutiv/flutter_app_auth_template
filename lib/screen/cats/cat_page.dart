
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/model/cats.dart';
import 'package:flutter_app_auth_template/screen/cats/favorites.dart';
import 'package:flutter_app_auth_template/screen/cats/profile_page.dart';
import 'package:flutter_app_auth_template/screen/widgets/cat_card.dart';
import 'package:flutter_app_auth_template/services/the_cat_api.dart';



class CatPage extends StatefulWidget {
  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  int _buttonIndex = 0;

  final tabs = [MyFutureBuilder(), Favorites(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cat Breeds',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          borderRadius: BorderRadius.circular(30),
          splashColor: Colors.black12,
          onTap: () {},
          child: Icon(
            Icons.menu,
            color: Colors.black87,
          ),
        ),
        actions: <Widget>[
          InkWell(
            borderRadius: BorderRadius.circular(30),
            splashColor: Colors.black12,
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Icon(
                Icons.search,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
      body: tabs[_buttonIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _buttonIndex,
        onTap: (index) {
          setState(() {
            _buttonIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
            ),
            title: Text('Favorites'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            title: Text('Profile'),
          )
        ],
      ),
    );
  }
}

class MyFutureBuilder extends StatefulWidget {
  @override
  _MyFutureBuilderState createState() => _MyFutureBuilderState();
}

class _MyFutureBuilderState extends State<MyFutureBuilder> {
  Future<List<Cat>> futureCats;
  PageController _pageController = PageController(viewportFraction: 0.5);
  int maxPages = 30;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    futureCats = getData(currentPage);
    _pageController.addListener(() {
      if (_pageController.position.pixels ==
          _pageController.position.maxScrollExtent &&
          currentPage <= maxPages) {
        setState(() {
          currentPage++;
          futureCats = getData(currentPage);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Cat>>(
      future: futureCats,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var cats = snapshot.data;
          return ListView.builder(
              controller: _pageController,
              itemCount: cats.length,
              itemBuilder: (context, index) {
                final currentCat = cats[index];
                return CatCard(
                  breed: currentCat.breed,
                  imageUrl: currentCat.imageUrl,
                  description: currentCat.description,
                );
              });
        } else {
          return SafeArea(
              child: Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ));
        }
      },
    );
  }
}
