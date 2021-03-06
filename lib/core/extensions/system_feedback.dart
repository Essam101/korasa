import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../enums.dart';

extension SystemFeedBackEx on String {
  showLoading({required AlertType alertType}) {
    if (AlertType.Loading == alertType) {
      EasyLoading.show(status: this, maskType: EasyLoadingMaskType.black);
      return;
    } else if (AlertType.Success == alertType) {
      EasyLoading.showSuccess(this, maskType: EasyLoadingMaskType.black);
    } else if (AlertType.Error == alertType) {
      EasyLoading.showError(
        "Error",
      );
    } else {
      EasyLoading.showInfo('Useful Information.');
    }
    EasyLoading.removeAllCallbacks();
  }

  showAlert({required AlertType alertType}) {
    var backgroundColor;
    if (alertType == AlertType.Error) {
      backgroundColor = Colors.red;
    } else if (alertType == AlertType.Success) {
      backgroundColor = Colors.green;
    } else if (alertType == AlertType.Warning) {
      backgroundColor = Colors.yellow;
    } else {
      backgroundColor = Colors.yellow;
    }
    Fluttertoast.showToast(
        msg: this,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
