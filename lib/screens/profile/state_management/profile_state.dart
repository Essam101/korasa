import 'package:get_storage/get_storage.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/services/auth_services.dart';
import 'package:shop/services/service_base.dart';

class ProfileState extends ServiceBase {
  Future<bool> logOut() async {
    isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);
    await new AuthServices().logOut().then((value) => {result = value});
    isLoading = false;
    "Success".showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }
}
