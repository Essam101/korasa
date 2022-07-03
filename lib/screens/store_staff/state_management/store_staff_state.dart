import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_services.dart';

class StoreStaffState extends ServiceBase {
  List<UserModel> userModel = [];

  getWorkers() async {
    this.isLoading = true;
    if (storeId.isNotEmpty) userModel = await new UserServices().getStoreUsers(storeId: storeId);
    isLoading = false;
    notifyListeners();
  }

  Future<bool> createWorker({required UserModel model}) async {
    this.isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);
    if (storeId.isNotEmpty) {
      model.storeId = storeId;
      await new UserServices().createUser(model: model);
      await getWorkers();
    } else {
      result = false;
    }

    isLoading = false;
    "Success".showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }
}
