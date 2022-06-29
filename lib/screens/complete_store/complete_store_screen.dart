import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';

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
    return WillPopScope(
      onWillPop: () {
        "Complete Store Data".showAlert(alertType: AlertType.Error);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Body(loading: loading),
      ),
    );
  }
}
