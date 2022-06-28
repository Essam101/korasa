import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteSingUpScreen extends StatelessWidget {
  static String routeName = "/complete_singUp_screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(),
    );
  }
}
