import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/routes/routes_name.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RoutesName.home);
                  },
                  child: Text('click'))),
        ],
      ),
    );
  }
}
