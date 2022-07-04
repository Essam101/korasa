import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import 'package:shop/core/size_config.dart';
import 'package:shop/screens/store_employees/components/header.dart';
import 'package:shop/screens/store_employees/state_management/store_employees_state.dart';

import '../customer/components/loading.dart';
import 'components/employee.dart';

class StoreEmployeesScreen extends StatefulWidget {
  static String routeName = "/storeStaff";

  const StoreEmployeesScreen({Key? key}) : super(key: key);

  @override
  State<StoreEmployeesScreen> createState() => _StoreEmployeesScreenState();
}

class _StoreEmployeesScreenState extends State<StoreEmployeesScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<StoreEmployeesState>(context, listen: false).getWorkers();
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
              for (var i in Provider.of<StoreEmployeesState>(context, listen: true).usersModel) Employee(userModel: i),
              Loading()
            ],
          ),
        ),
      ),
    );
  }
}
