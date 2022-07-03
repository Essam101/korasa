import 'package:flutter/material.dart';
import 'package:shop/components/coustom_bottom_nav_bar.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/screens/customer/components/header.dart';

class CustomerScreen extends StatefulWidget {
  static String routeName = "/customer";

  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Header(),
            ],
          ),
        ),
      ),
    );
  }
}
