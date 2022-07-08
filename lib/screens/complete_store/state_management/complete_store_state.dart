import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/store/store_services.dart';
import 'package:shop/services/users/user_services.dart';

class CompleteStoreState extends ServiceBase {
  CompleteStoreState() {
    setCurrentUser();
  }

  Future<bool> createStore({required StoreModel storeModel}) async {
    isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);

    if (currantUser != null) {
      await new StoreServices().createStore(model: storeModel);
      await new UserServices().updateUser(
          model: new UserModel(
        userId: currantUser!.userId,
        name: currantUser!.name,
        role: currantUser!.role,
        storeId: storeModel.storeId,
        email: currantUser!.email,
        password: currantUser!.password,
      ));
    } else {
      result = false;
    }

    isLoading = false;
    "Success".showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }
}
