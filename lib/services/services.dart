import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop/screens/complete_store/state_management/complete_store_state.dart';
import 'package:shop/screens/navigation/state_management/navigation_state.dart';
import 'package:shop/screens/profile/state_management/profile_state.dart';
import 'package:shop/screens/sign_in/state_management/sign_in_state.dart';
import 'package:shop/screens/sign_up/state_management/sign_up_state.dart';
import 'package:shop/services/customers/customer_services.dart';
import 'package:shop/services/pages/page_services.dart';
import 'package:shop/services/users/user_services.dart';

import '../screens/complete_store/complete_store_screen.dart';
import 'auth_services.dart';
import 'store/store_services.dart';

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
        create: (context) => new CustomerServices(),
      ),
      ChangeNotifierProvider(
        create: (context) => new SignUpState(),
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
    ];
  }
}
