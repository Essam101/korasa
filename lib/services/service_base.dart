import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop/core/instances.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/users/user_local.dart';

class ServiceBase extends ChangeNotifier {
  ServiceBase() {
    setCurrentUser().then((value) => {print("ServiceBase")});
  }

  Instances instance = new Instances();
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
    currantUser = new UserLocal().getCashUser();
    if (currantUser != null) {
      userId = currantUser!.userId;
      storeId = currantUser!.storeId;
    }
    notifyListeners();
  }

  clear() {
    currantUser = null;
    storeId = "";
    userId = "";
  }
}
