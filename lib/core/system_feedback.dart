import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'enums.dart';

class SystemFeedBack {
  showAlert({required AlertType alertType, required String massage}) {
    switch (alertType) {
      case AlertType.Error:
        _errorAlert(massage: massage);
        break;
      case AlertType.Success:
        _successAlert(massage: massage);
        break;
      case AlertType.Warning:
        _warningAlert(massage: massage);
        break;
      default:
        _warningAlert(massage: massage);
        break;
    }
  }

  _successAlert({required String massage}) {
    Fluttertoast.showToast(
        msg: "${massage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _errorAlert({required String massage}) {
    Fluttertoast.showToast(
        msg: "${massage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _warningAlert({required String massage}) {
    Fluttertoast.showToast(
        msg: "${massage}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.yellow,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
