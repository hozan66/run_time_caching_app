import 'package:flutter/material.dart';

import '../config/routes/app_routes.dart';
import 'first_screen.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('SecondScreen'),
          ElevatedButton(
            onPressed: () {
              navigateAndFinish(context, const FirstScreen());
            },
            child: const Text('Go to First Screen'),
          ),
        ],
      )),
    );
  }
}
