import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shop/models/userModel.dart';

import 'package:shop/core/size_config.dart';
import 'package:shop/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop/screens/store_employees/components/add_staff_form.dart';
import 'package:shop/screens/store_employees/components/search_field.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
              svgSrc: "assets/icons/more.svg",
              press: () {
                showBarModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AddStaffForm(empId: "",empName: "",email: "",password: "",storeId: "",role: roleType.emp.name,);
                  },
                );
              }),
        ],
      ),
    );
  }
}
