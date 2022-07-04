import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop/screens/complete_store/state_management/complete_store_state.dart';
import 'package:shop/screens/customer/state_management/customre_state.dart';
import 'package:shop/screens/navigation/state_management/navigation_state.dart';
import 'package:shop/screens/profile/state_management/profile_state.dart';
import 'package:shop/screens/sign_in/state_management/sign_in_state.dart';
import 'package:shop/screens/sign_up/state_management/sign_up_state.dart';
import 'package:shop/screens/splash/state_management/splash_state.dart';
import 'package:shop/screens/store_employees/state_management/store_employees_state.dart';
import 'package:shop/services/pages/page_services.dart';

//                await Provider.of<AuthServices>(context, listen: false) ;
class Services {
  final BuildContext context;

  Services(this.context);

  List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider(
        create: (context) => new PageServices(),
      ),
      ChangeNotifierProvider(
        create: (context) => new SignUpState(),
      ),
      ChangeNotifierProvider(
        create: (context) => new CustomerState(),
      ),
      ChangeNotifierProvider(
        create: (context) => new SignInState(),
      ),
      ChangeNotifierProvider(
        create: (context) => new ProfileState(),
      ),
      ChangeNotifierProvider(
        create: (context) => new CompleteStoreState(),
      ),
      ChangeNotifierProvider(
        create: (context) => new NavigationState(),
      ),
      ChangeNotifierProvider(
        create: (context) => new StoreEmployeesState(),
      ),
      ChangeNotifierProvider(
        create: (context) => new SplashState(),
      ),
    ];
  }
}
