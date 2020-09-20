
import 'package:example/redux/app_state.dart';
import 'package:example/screens/Home.dart';
import 'package:example/screens/SignIn.dart';
import 'package:example/screens/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp(this.store);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'MedeHealth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // initialRoute: '/',
        home: this.store.state.auth.token != null ? HomeScreen() : SignInScreen(),
        routes: {
          '/home': (context) => HomeScreen(),
          '/sign-in': (context) => SignInScreen(),
          '/sign-up': (context) => SignUpScreen(),
        },
      ),
    );
  }
}