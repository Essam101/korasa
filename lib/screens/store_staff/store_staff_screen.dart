import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:shop/core/size_config.dart';
import 'package:shop/screens/store_staff/components/header.dart';
import 'package:shop/screens/store_staff/state_management/store_staff_state.dart';

import '../customer/components/loading.dart';
import 'components/worker.dart';

class StoreStaffScreen extends StatefulWidget {
  static String routeName = "/storeStaff";

  const StoreStaffScreen({Key? key}) : super(key: key);

  @override
  State<StoreStaffScreen> createState() => _StoreStaffScreenState();
}

class _StoreStaffScreenState extends State<StoreStaffScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<StoreStaffState>(context, listen: false).getWorkers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Header(),
              SizedBox(height: getProportionateScreenWidth(10)),
              for (var i in Provider.of<StoreStaffState>(context, listen: true).userModel) Worker(userModel: i),
              Loading()
            ],
          ),
        ),
      ),
    );
  }
}
