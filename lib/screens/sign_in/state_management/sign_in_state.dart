import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/cachingKeys.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/screens/home/home_screen.dart';
import 'package:shop/services/auth_services.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_services.dart';

class SignInState extends ServiceBase {
  UserModel? userModel;

  Future<bool> signIn({required String email, required String password}) async {
    isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);
    await new AuthServices().signIn(email: email, password: password).then((value) => {result = value != null, setIsLoggedIn(value: result)});
    isLoading = false;
    "Success".showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }

  getLoggedInUser() async {
    userModel = await new UserServices().getLoggedInUser();
    notifyListeners();
  }

  bool getIsLoggedIn() {
    return getStorage.read(CachingKeys.isLoggedIn) ?? false;
  }

  setIsLoggedIn({required bool value}) {
    return getStorage.write(CachingKeys.isLoggedIn, value);
  }
}
