import 'package:example/features/signIn/actions.dart';
import 'package:example/features/signIn/state.dart';
import 'package:example/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux_toolkit/flutter_redux_toolkit.dart';

class SignInScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final dispatch = useDispatch<AppState>();
    final navigator = useNavigator(context);
    final isLoading =
        useSelector<AppState, bool>(SignInSelectors.selectIsLoading);
    final status = useSelector<AppState, String>((AppState state) => state.signIn.submitStatus.toString());
    final isSucceed =
        useSelector<AppState, bool>(SignInSelectors.selectIsSucceed);

    final onSubmit = () {
      dispatch(DoLogin(email: "admin@example.com", password: "123"));
    };

    final onSignUp = () {
      navigator.pushNamed('/sign-up');
    };

    useEffect(() {
      if (isSucceed) {
        navigator.pushNamedAndRemoveUntil('/home', (_) => false);
      }
      return () => {
        // reset state
        dispatch(Reset())
      };
    }, [isSucceed]);

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the SignInScreen object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Sign In $status"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    child: Text('Sign In'),
                    onPressed: isLoading ? null : onSubmit),
                RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: onSignUp,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
