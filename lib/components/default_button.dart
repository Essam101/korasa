import 'package:flutter/material.dart';
import 'package:shop/core/size_config.dart';

import '../core/constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:

              // RoundedRectangleBorder(borderRadius : BorderRadius.vertical(bottom: Radius.circular(20),top: Radius.circular(20))),
              RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(20),
                      topEnd: Radius.circular(5),
                      bottomStart: Radius.circular(5),
                      bottomEnd: Radius.circular(20))),
          primary: Colors.white,
          // padding: EdgeInsets.all(10),
          backgroundColor: kPrimaryColor,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
