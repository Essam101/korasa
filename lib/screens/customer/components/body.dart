import 'package:flutter/material.dart';
import 'package:shop/screens/customer/components/add_customer_form.dart';

import '../../../core/constants.dart';
import '../../../core/size_config.dart';

class Body extends StatelessWidget {

  final Function(bool) loading;

  const Body({super.key, required this.loading});
@override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
          width: double.infinity,

          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                  Text("Adding New Customer", style: headingStyle),


                  AddCustomerForm(loading:  loading ),


                  SizedBox(height: getProportionateScreenHeight(20)),

                ]

          ),
        ),

        ),
   );


  }
}