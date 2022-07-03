import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/screens/customer/components/customer.dart';
import 'package:shop/screens/customer/components/header.dart';
import 'package:shop/screens/customer/components/loading.dart';
import 'package:shop/screens/customer/state_management/customre_state.dart';


class CustomerScreen extends StatefulWidget {
  static String routeName = "/customer";

  const CustomerScreen({Key? key}) : super(key: key);

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<CustomerState>(context, listen: false).getCustomers();
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
              for (var i in Provider.of<CustomerState>(context, listen: true).customersModel) Customer(customerModel: i),
              Loading()
            ],
          ),
        ),
      ),
    );
  }
}
