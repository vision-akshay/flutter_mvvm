import 'package:flutter/material.dart';
import 'package:flutter_mvvm/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    Utils.flushBarErrorMessage('Hello Flutter', context);
                  },
                  child: Text('home screen'))),
        ],
      ),
    );
  }
}
