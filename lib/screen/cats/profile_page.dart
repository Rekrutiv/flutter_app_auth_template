import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {




  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text(
          "Profile",
          style: TextStyle(fontSize: 15.0),

        ),
      ),
    );

  }
}
