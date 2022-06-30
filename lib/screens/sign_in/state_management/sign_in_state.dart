import 'package:flutter/material.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/auth_services.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_services.dart';

class SignInState extends ServiceBase {
  Future<bool> signIn({required String email, required String password}) async {
    isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);
    await new AuthServices().signIn(email: email, password: password).then((value) => {
          result = value != null,
        });
    isLoading = false;
    "Success".showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }

  Future<UserModel?> getLoggedInUser() async {
    return await new UserServices().getLoggedInUser();
  }
}
