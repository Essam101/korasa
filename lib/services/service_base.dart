import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop/core/db.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/users/user_local.dart';
import 'package:shop/services/users/user_services.dart';

class ServiceBase extends ChangeNotifier {
  ServiceBase() {
    new userLocal().getCashUser()?.then((value) => {
          currantUser = value,
          if (currantUser != null)
            {
              userId = value.userId,
              storeId = value.storeId,
            }
        });
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

  late UserModel? currantUser;

  String userId = "";

  String storeId = "";
}
