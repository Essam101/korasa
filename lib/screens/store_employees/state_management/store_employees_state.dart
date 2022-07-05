import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/generateId.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_services.dart';

import '../../../core/collectionsNames.dart';

class StoreEmployeesState extends ServiceBase {
  List<UserModel> usersModel = [];

  getWorkers() async {
    this.isLoading = true;
    if (storeId.isNotEmpty)
      usersModel = await new UserServices().getStoreEmployees(storeId: storeId);
    isLoading = false;
    notifyListeners();
  }

  Future<bool> UpdateOrCreateWorker({required UserModel model}) async {
    this.isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);

    if (model.userId.isNotEmpty && storeId.isNotEmpty) {
      await new UserServices().updateUser(model: model);
      await getWorkers();
    } else {
      if (storeId.isNotEmpty) {
        model.storeId = storeId;
        model.userId = CollectionsNames.users.generateId();
        await new UserServices().createUser(model: model);
        await getWorkers();
      } else {
        result = false;
      }
    }

    isLoading = false;
    "Success"
        .showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }

  @override
  clear() {
    super.clear();
    usersModel.clear();
    notifyListeners();
  }
}
