import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/screens/customer/state_management/customre_state.dart';
import 'package:shop/screens/splash/splash_screen.dart';
import 'package:shop/screens/store_employees/state_management/store_employees_state.dart';
import 'package:shop/services/auth_services.dart';
import 'package:shop/services/service_base.dart';

class ProfileState extends ServiceBase {
  Future<bool> logOut({required BuildContext context}) async {
    isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);

    await new AuthServices().logOut().then((value) => {result = value});
    await getStorage.erase();
    Provider.of<CustomerState>(context, listen: false).clear();
    Provider.of<StoreEmployeesState>(context, listen: false).clear();
    isLoading = false;
    "Success".showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    if (result) Navigator.pushReplacementNamed(context, SplashScreen.routeName);
    return result;
  }
}
