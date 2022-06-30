import 'package:flutter/material.dart';
import 'package:shop/core/constants.dart';
import 'package:shop/screens/cart/cart_screen.dart';

import 'package:shop/core/size_config.dart';
import 'package:shop/screens/home/components/icon_btn_with_counter.dart';
import 'package:shop/screens/store_staff/components/add_staff.dart';
import 'package:shop/screens/store_staff/components/search_field.dart';

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
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AddStaff();
                  },
                );
              }),
        ],
      ),
    );
  }
}
