
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/screen/cats/cat_screen.dart';
import 'package:flutter_app_auth_template/screen/cats/favorites.dart';
import 'package:flutter_app_auth_template/screen/cats/profile_page.dart';




class CatPage extends StatefulWidget {
  @override
  _CatPageState createState() => _CatPageState();
}

class _CatPageState extends State<CatPage> {
  int _buttonIndex = 0;

  final tabs = [CatsScreen(), Favorites(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


