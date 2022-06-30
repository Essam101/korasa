import 'package:flutter/material.dart';
import 'package:shop/components/coustom_bottom_nav_bar.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/screens/store_staff/components/header.dart';

class StoreStaffScreen extends StatefulWidget {
  static String routeName = "/storeStaff";

  const StoreStaffScreen({Key? key}) : super(key: key);

  @override
  State<StoreStaffScreen> createState() => _StoreStaffScreenState();
}

class _StoreStaffScreenState extends State<StoreStaffScreen> {
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
