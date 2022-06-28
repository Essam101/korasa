import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteSingUpScreen extends StatefulWidget {
  static String routeName = "/complete_singUp_screen";

  @override
  State<CompleteSingUpScreen> createState() => _CompleteSingUpScreenState();
}

class _CompleteSingUpScreenState extends State<CompleteSingUpScreen> {
  bool isLoading = false;

  loading(bool v) => setState(() => isLoading = v);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(loading: loading),
    );
  }
}
