import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/constants.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/models/pageModel.dart';
import 'package:shop/models/transactionModel.dart';
import 'package:shop/screens/home/home_screen.dart';
import 'package:shop/screens/sign_in/sign_in_screen.dart';
import 'package:shop/screens/sign_in/state_management/sign_in_state.dart';
import 'package:shop/screens/splash/state_management/splash_state.dart';
import 'package:shop/services/pages/page_services.dart';
import 'package:shop/services/transaction_services.dart';

// This is the best practice
import '../components/splash_content.dart';
import '../../../components/default_button.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "Welcome to Tokoto, Let’s shop!", "image": "assets/images/splash_1.png"},
    {"text": "We help people conect with store \naround United State of America", "image": "assets/images/splash_2.png"},
    {"text": "We show the easy way to shop. \nJust stay at home with us", "image": "assets/images/splash_3.png"},
  ];
  late TransactionServices transactionServices;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Provider.of<SplashState>(context, listen: false).navigateTo(context: context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    // DefaultButton(
                    //   text: "Continue",
                    //   press: () {
                    //     Navigator.pushNamed(context, SignInScreen.routeName);
                    //   },
                    // ),
                    // Text("${EasyDynamicTheme.of(context).themeMode}"),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       EasyDynamicTheme.of(context).changeTheme();
                    //     },
                    //     child: Text("Change")),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
