import 'dart:developer';

import 'package:example/features/signIn/actions.dart';
import 'package:example/features/signIn/state.dart';
import 'package:example/redux/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toolkit/flutter_toolkit.dart';

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
    final isFailed =
        useSelector<AppState, bool>(SignInSelectors.selectIsFailed);
    // ignore: close_sinks
    final formController = useForm(defaultValues: {
      'email': 'sang.dao@newoceaninfosys.com',
      'remember': true,
      // 'dob': DateTime.now().add(Duration(days: 3)),
    }, watch: [
      'email'
    ]);

    final onSubmit = () {
      formController.submit((formValues, formValid, formErrors) {
        if (formValid) {
          log('onSubmit values > ' + formValues.toString());
          dispatch(DoLogin(
              email: formValues['email'], password: formValues['password']));
        } else {
          log('onSubmit errors > ' + formErrors.toString());
          formController.complete();
        }
      });
    };

    final onSignUp = () {
      navigator.pushNamed('/sign-up');
    };

    final onReset = () {
      formController.reset({
        'email': 'daominhsangvn@gmail.com',
        'remember': true,
        'dob': DateTime.now(),
        'tob': TimeOfDay.fromDateTime(DateTime.now()),
        'dtob': DateTime.now().add(Duration(days: 1)),
        'dtrob': DateTimeRange(
            start: DateTime.now(), end: DateTime.now().add(Duration(days: 5))),
        'gender': 'f',
      });
    };

    final onClear = () {
      // formController.reset({
      //   'email': null,
      //   'remember': null,
      //   'dob': null,
      //   'tob': null,
      //   'dtob': null,
      //   'dtrob': null,
      //   'gender': null,
      //   'password': null
      // });

      formController.clear();
    };

    useEffect(() {
      if (isFailed) {
        formController.complete();
      }
      return () => {};
    }, [isFailed]);

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
                child: (onChange, value) => TextFieldHook(
                    initialValue: value,
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
                child: (onChange, value) => TextFieldHook(
                    initialValue: value,
                    obscureText: true,
                    onChanged: onChange,
                    decoration: InputDecoration(
                        errorText:
                            formController.getFirstFieldError('password')))),
            FormFieldController(
              controller: formController,
              name: 'dob',
              child: (onChange, value) => DatePicker(
                  initialDate: value,
                  onChange: onChange,
                  config: DateConfig(
                    minDate: DateTime.now().subtract(new Duration(days: 10)),
                    maxDate: DateTime.now().add(new Duration(days: 10)),
                  )),
            ),
            FormFieldController(
              controller: formController,
              name: 'tob',
              child: (onChange, value) => TimePicker(
                initialTime: value,
                onChange: onChange,
                config: TimeConfig(),
              ),
            ),
            FormFieldController(
              controller: formController,
              name: 'dtob',
              child: (onChange, value) => DateTimePicker(
                initialDateTime: value,
                onChange: onChange,
                timeConfig: TimeConfig(),
                dateConfig: DateConfig(),
              ),
            ),
            FormFieldController(
              controller: formController,
              name: 'dtrob',
              child: (onChange, value) => DateRangePicker(
                initialDateRange: value,
                onChange: onChange,
                config: DateRangeConfig(),
              ),
            ),
            FormFieldController(
              controller: formController,
              name: 'remember',
              child: (onChange, value) => CheckboxListTile(
                value: value ??
                    false, // Checkbox value required true/false value, make sure check null here
                onChanged: onChange,
                title: Text('Remember Me'),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ),
            FormFieldController(
              controller: formController,
              name: 'gender',
              child: (onChange, value) => Container(
                child: Column(
                  children: [
                    RadioListTile(
                      title: const Text('Male'),
                      value: 'm',
                      groupValue: value,
                      onChanged: onChange,
                    ),
                    RadioListTile(
                      title: const Text('Female'),
                      value: 'f',
                      groupValue: value,
                      onChanged: onChange,
                    )
                  ],
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                    child: Text('Sign In'),
                    onPressed: (isLoading || formController.submitting)
                        ? null
                        : onSubmit),
                RaisedButton(
                  child: Text('Sign Up'),
                  onPressed: (isLoading || formController.submitting)
                      ? null
                      : onSignUp,
                ),
                RaisedButton(
                  child: Text('Reset'),
                  onPressed:
                      (isLoading || formController.submitting) ? null : onReset,
                ),
                RaisedButton(
                  child: Text('Clear'),
                  onPressed:
                      (isLoading || formController.submitting) ? null : onClear,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
