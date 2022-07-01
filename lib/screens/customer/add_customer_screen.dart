import 'package:flutter/material.dart';

import 'components/body.dart';

class AddCustomerScreen extends StatefulWidget {
  static String routeName = "/add_customer";

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreen();
}

class _AddCustomerScreen extends State<AddCustomerScreen> {


  bool isLoading = false;

  loading(bool v) => setState(() => isLoading = v);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Customer"),
      ),
      body: Body(loading: loading),
    );
  }
}
