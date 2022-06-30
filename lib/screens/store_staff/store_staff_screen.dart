import 'package:flutter/material.dart';
import 'package:shop/components/coustom_bottom_nav_bar.dart';
import 'package:shop/core/enums.dart';

class StoreStaffScreen extends StatefulWidget {
  static String routeName = "/storeStaff";

  const StoreStaffScreen({Key? key}) : super(key: key);

  @override
  State<StoreStaffScreen> createState() => _StoreStaffScreenState();
}

class _StoreStaffScreenState extends State<StoreStaffScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Staff Screen"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
    );
  }
}
