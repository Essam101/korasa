import 'package:flutter/material.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/screens/splash/components/body.dart';


class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(body: Body());
  }
}
