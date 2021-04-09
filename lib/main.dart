import 'package:flutter_app_auth_template/app/observers/app_bloc_observer.dart';
import 'package:flutter_app_auth_template/authenticaiton/bloc/authentication_bloc.dart';
import 'package:flutter_app_auth_template/authenticaiton/data/providers/google_sign_in_provider.dart';
import 'package:flutter_app_auth_template/authenticaiton/data/repositories/authenticaiton_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_auth_template/screen/cats/cat_page.dart';
import 'package:flutter_app_auth_template/services/cats_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'authenticaiton/data/providers/authentication_firebase_provider.dart';
import 'blocs/cat_list/cats_bloc.dart';
import 'blocs/todo/todo_bloc.dart';
import 'blocs/todo/todo_event.dart';
import 'db/todo_provider.dart';
import 'package:flutter_app_auth_template/screen/router/app_router';
import 'package:hive_flutter/hive_flutter.dart';
//void main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  await Firebase.initializeApp();
//  Bloc.observer = AppBlocObserver();
//  runApp(MyApp());
//}
Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox('favorite_cats');

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = AppBlocObserver();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');

  print(email);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) =>
              TodoBloc(todoProvider: TodoProvider())..add(LoadTodo())),
      BlocProvider(
        create: (context) => AuthenticationBloc(
          authenticationRepository: AuthenticationRepository(
            authenticationFirebaseProvider: AuthenticationFirebaseProvider(
              firebaseAuth: FirebaseAuth.instance,
            ),
            googleSignInProvider: GoogleSignInProvider(
              googleSignIn: GoogleSignIn(),
            ),
          ),
        ),
      ),
      BlocProvider(create: (_) =>
               CatsBloc(CatsRepository())..add(FetchCats()))

  ],
    child: MaterialApp(home: email == null ? MyApp() : CatPage()),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) =>
                TodoBloc(todoProvider: TodoProvider())..add(LoadTodo())),
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authenticationRepository: AuthenticationRepository(
              authenticationFirebaseProvider: AuthenticationFirebaseProvider(
                firebaseAuth: FirebaseAuth.instance,
              ),
              googleSignInProvider: GoogleSignInProvider(
                googleSignIn: GoogleSignIn(),
              ),
            ),
          ),
        ),
        BlocProvider(create: (context) => CatsBloc(CatsRepository())),
      ],
      child: MaterialApp(
        title: 'Flutter Rekrutiv',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
