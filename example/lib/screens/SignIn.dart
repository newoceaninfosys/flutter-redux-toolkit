import 'dart:developer';

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
    final status = useSelector<AppState, String>(
        (AppState state) => state.signIn.submitStatus.toString());
    final isSucceed =
        useSelector<AppState, bool>(SignInSelectors.selectIsSucceed);
    // ignore: close_sinks
    final formController = useForm(
        defaultValues: {'email': 'sang.dao@newoceaninfosys.com'},
        watch: ['email']);

    final onSubmit = () {
      formController.submit((formValues, formValid, formErrors) {
        if (formValid) {
          log('onSubmit values > ' + formValues.toString());
        } else {
          log('onSubmit errors > ' + formErrors.toString());
        }
      });
    };

    final onSignUp = () {
      navigator.pushNamed('/sign-up');
    };

    final onReset = () {
      formController.reset(
          {'email': 'daominhsangvn@gmail.com'}); // TODO: change input values
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
            // FormFieldController(
            //     controller: formController,
            //     name: 'username',
            //     validators: {
            //       'required': (value) => value == '' || value == null
            //           ? 'Please input this field'
            //           : null,
            //       'unique': (value) async {
            //         new Future.delayed(const Duration(seconds: 5), () => "5");
            //         return null;
            //       }
            //     },
            //     child: (onChange, value) => TextFormField(
            //         initialValue: value,
            //         onChanged: onChange,
            //         decoration: InputDecoration(
            //             errorText:
            //                 formController.getFirstFieldError('username'),
            //             suffix: formController.isAsync('username')
            //                 ? CircularProgressIndicator()
            //                 : null))),
            FormFieldController(
                controller: formController,
                name: 'email',
                validators: [RequiredValidator('Please input this field')],
                child: (onChange) => TextField(
                    onChanged: onChange,
                    decoration: InputDecoration(
                        errorText:
                            formController.getFirstFieldError('email')))),
            FormFieldController(
                controller: formController,
                name: 'password',
                validators: [
                  RequiredValidator('Please input this field'),
                  MinLengthValidator('Min length 5', 5)
                ],
                child: (onChange) => TextField(
                    obscureText: true,
                    onChanged: onChange,
                    decoration: InputDecoration(
                        errorText:
                            formController.getFirstFieldError('password')))),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    child: Text('Sign In'),
                    onPressed: isLoading ? null : onSubmit),
                RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: onSignUp,
                ),
                RaisedButton(
                  child: Text('Reset'),
                  onPressed: onReset,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
