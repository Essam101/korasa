import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop/core/db.dart';
import 'package:shop/core/extensions/system_feedback.dart';

class ServiceBase extends ChangeNotifier {
  Db db = new Db();

  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }
}
