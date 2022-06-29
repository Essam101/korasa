import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/screens/complete_profile/complete_profile_screen.dart';
import 'package:shop/services/auth_services.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_services.dart';

class SignUpState extends ServiceBase {
  Future<bool> signUpAndCreateUser({required UserModel model}) async {
    isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);
    await new AuthServices().signUp(email: model.email, password: model.password).then((value) async => {
          if (value == null)
            {"Error while SignUp".showAlert(alertType: AlertType.Error), result = false}
          else
            {
              await new UserServices().createUser(model: model).then((userModel) => {
                    if (userModel == null)
                      {"Error while create user".showAlert(alertType: AlertType.Error), result = false}
                    else
                      {"Welcome Mr ${userModel.name}".showAlert(alertType: AlertType.Success)}
                  })
            },
        });
    isLoading = false;
    "Success".showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }
}
