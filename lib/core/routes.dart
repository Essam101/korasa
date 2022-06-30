import 'package:flutter/widgets.dart';
import 'package:shop/screens/cart/cart_screen.dart';
import 'package:shop/screens/complete_store/complete_store_screen.dart';
import 'package:shop/screens/complete_store/state_management/complete_store_state.dart';
import 'package:shop/screens/details/details_screen.dart';
import 'package:shop/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop/screens/home/home_screen.dart';
import 'package:shop/screens/login_success/login_success_screen.dart';
import 'package:shop/screens/otp/otp_screen.dart';
import 'package:shop/screens/profile/profile_screen.dart';
import 'package:shop/screens/sign_in/sign_in_screen.dart';
import 'package:shop/screens/sign_in/state_management/sign_in_state.dart';
import 'package:shop/screens/sign_up/sign_up_screen.dart';
import 'package:shop/screens/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteStoreScreen.routeName: (context) => CompleteStoreScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};
