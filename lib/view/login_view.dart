import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/components/round_button.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';
import 'package:flutter_mvvm/utils/utils.dart';
import 'package:flutter_mvvm/view-model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _emailController =
      TextEditingController(text: 'eve.holt@reqres.in');
  TextEditingController _passwordController =
      TextEditingController(text: 'cityslicka');
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);

  @override
  void dispose() {
// TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            focusNode: _emailFocusNode,
            controller: _emailController,
            onFieldSubmitted: (value) {
              Utils.fieldFocusChange(
                  context, _emailFocusNode, _passwordFocusNode);
            },
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Enter Email',
              prefixIcon: Icon(Icons.mail_outline),
            ),
          ),
          ValueListenableBuilder(
              valueListenable: _obsecurePassword,
              builder: (context, value, child) {
                return TextFormField(
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  obscureText: value,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    prefixIcon: Icon(Icons.lock_open_rounded),
                    suffixIcon: InkWell(
                        onTap: () {
                          _obsecurePassword.value = !_obsecurePassword.value;
                        },
                        child: Icon(
                          value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                        )),
                  ),
                );
              }),
          SizedBox(
            height: deviceSize.height * 0.1,
            child: RoundButton(
                title: 'Login',
                loading: authViewModel.isLoading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage('Please enter email', context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        'Please enter password', context);
                  } else if (_passwordController.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        'Please enter 6 digit password', context);
                  } else {
                    print('api hit');

                    Map data = {
                      'email': _emailController.text.toString(),
                      'password': _passwordController.text.toString(),
                    };
                    authViewModel.loginApi(data, context);
                  }
                }),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamed(RoutesName.signup);
            },
            child: const Text('Sign up Now..'),
          )
        ],
      ),
    );
  }
}
