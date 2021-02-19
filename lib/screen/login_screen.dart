import 'package:flutter_app_auth_template/authenticaiton/bloc/authentication_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/dao/barcode_dao.dart';
import 'package:flutter_app_auth_template/model/barcodes_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'barcode_list.dart';
//import 'home_screen.dart';

class LoginMainView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CodesDao dau = CodesDao();
    dau.insertBooks(BarCodes(
      barCode: int.parse("11111111111"),
      responseuser: "Молоко",
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.deepOrange,
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Builder(
          builder: (context) {
            return BlocConsumer<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationSuccess) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
//                          HomeMainView()
                              BarCodesList()));
                } else if (state is AuthenticationFailiure) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                    ),
                  );
                }
              },
              buildWhen: (current, next) {
                if (next is AuthenticationSuccess) {
                  return false;
                }
                return true;
              },
              builder: (context, state) {
                if (state is AuthenticationInitial ||
                    state is AuthenticationFailiure) {
                  return Center(
                    child: MaterialButton(
                      color: Colors.yellowAccent,
                      height: MediaQuery.of(context).size.height / 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Text('Login with Google',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Open Sans',
                              fontSize: 20)),
                      onPressed: () =>
                          BlocProvider.of<AuthenticationBloc>(context).add(
                        AuthenticationGoogleStarted(),


                      ),
                    ),
                  );
                } else if (state is AuthenticationLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(
                    child: Text('Undefined state : ${state.runtimeType}'));
              },
            );
          },
        ),
      ),
    );
  }
}
