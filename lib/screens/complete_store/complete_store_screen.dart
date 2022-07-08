import 'package:flutter/material.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';

import 'components/body.dart';

class CompleteStoreScreen extends StatefulWidget {
  static String routeName = "/complete_store";

  @override
  State<CompleteStoreScreen> createState() => _CompleteStoreScreenState();
}

class _CompleteStoreScreenState extends State<CompleteStoreScreen> {
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
