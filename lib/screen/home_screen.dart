import 'package:flutter_app_auth_template/authenticaiton/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'food_form.dart';

class HomeMainView extends StatelessWidget {

  void saveLogIn(String emailUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', emailUser);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.exit_to_app,
                ),
                onPressed: () async {
                  BlocProvider.of<AuthenticationBloc>(context).add(
                    AuthenticationExited(),
                  );
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('email');
                  Navigator.of(context).pushNamed(
                    '/',
                  );
                }),
          ],
        ),
        body: Center(
          child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationFailiure) {
                Navigator.of(context).pushNamed(
                  '/',
                );
              }
            },
            builder: (context, state) {
              if (state is AuthenticationInitial) {
                BlocProvider.of<AuthenticationBloc>(context)
                    .add(AuthenticationStarted());
                return CircularProgressIndicator();
              } else if (state is AuthenticationLoading) {
                return CircularProgressIndicator();
              } else if (state is AuthenticationSuccess) {
                //   SharedPreferences prefs = await SharedPreferences.getInstance();
                saveLogIn(state.authenticationDetail.email);

                return FoodForm();
                //Text('Welcome :${state.authenticationDetail.email}');
              }
              return Text('Undefined state : ${state.runtimeType}');
            },
          ),
        ),
      ),
    );
  }
}
