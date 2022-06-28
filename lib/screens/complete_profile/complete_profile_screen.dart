import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'components/body.dart';

class CompleteSingUpScreen extends StatefulWidget {
  static String routeName = "/complete_singUp";

  @override
  State<CompleteSingUpScreen> createState() => _CompleteSingUpScreenState();
}

class _CompleteSingUpScreenState extends State<CompleteSingUpScreen> {
  bool isLoading = false;

  loading(bool v) => setState(() => isLoading = v);

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Body(loading: loading),
      ),
    );
  }
}
