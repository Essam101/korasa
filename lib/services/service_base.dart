import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop/core/db.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/screens/sign_in/state_management/sign_in_state.dart';
import 'package:shop/services/users/user_local.dart';
import 'package:shop/services/users/user_services.dart';

class ServiceBase extends ChangeNotifier {
  ServiceBase() {
    setCurrentUser().then((value) => {print("ServiceBase")});
  }

  Db db = new Db();
  GetStorage getStorage = new GetStorage();

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  UserModel? currantUser;

  String userId = "";

  String storeId = "";

  Future<void> setCurrentUser() async {
    currantUser = new UserLocal().getCashUserTest();
    if (currantUser != null) {
      userId = currantUser!.userId;
      storeId = currantUser!.storeId;
    }
    notifyListeners();
  }
}
