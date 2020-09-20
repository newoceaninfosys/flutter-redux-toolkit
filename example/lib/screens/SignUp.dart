import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SignUpScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // final store = useMemoized(() => MyStore());

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the SignUpScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Sign Up"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SignUpScreen',
            )
          ],
        ),
      ),
    );
  }
}
