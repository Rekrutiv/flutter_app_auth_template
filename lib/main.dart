import 'package:flutter_app_auth_template/app/observers/app_bloc_observer.dart';
import 'package:flutter_app_auth_template/authenticaiton/bloc/authentication_bloc.dart';
import 'package:flutter_app_auth_template/authenticaiton/data/providers/google_sign_in_provider.dart';
import 'package:flutter_app_auth_template/authenticaiton/data/repositories/authenticaiton_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/screen/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authenticaiton/data/providers/authentication_firebase_provider.dart';
import 'bloc/food_bloc.dart';
import 'model/food.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Food> foods=[];
    return MultiBlocProvider(
      providers: [
        BlocProvider<FoodBloc>(create: (context) => FoodBloc(foods)),
        BlocProvider(create: (context) => AuthenticationBloc(
          authenticationRepository: AuthenticationRepository(
            authenticationFirebaseProvider: AuthenticationFirebaseProvider(
              firebaseAuth: FirebaseAuth.instance,
            ),
            googleSignInProvider: GoogleSignInProvider(
              googleSignIn: GoogleSignIn(),
            ),
          ),
        ),)
      ],


      child: MaterialApp(
        title: 'Flutter Rekrutiv',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:LoginMainView(),
      ),
    );
  }
}
