import 'package:example/features/signOut/actions.dart';
import 'package:example/hooks/useNavigator.dart';
import 'package:example/redux/app_state.dart';
import 'package:example/redux/auth/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class HomeScreen extends HookWidget {
  final String title = "Home";

  @override
  Widget build(BuildContext context) {
    final dispatch = useDispatch<AppState>();
    final navigator = useNavigator(context);
    final token = useSelector<AppState, String>(AuthSelectors.selectToken);
    final onLogOutPress = () {
      dispatch(DoLogout());
      navigator.pushNamedAndRemoveUntil('/sign-in', (_) => false);
    };

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomeScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                RaisedButton(
                  onPressed: onLogOutPress,
                  child: Text("Sign Out"),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(token ?? ""),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
