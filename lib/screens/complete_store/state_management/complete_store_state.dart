import 'package:shop/core/cachingKeys.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/store/store_services.dart';
import 'package:shop/services/users/user_services.dart';

class CompleteStoreState extends ServiceBase {
  Future<bool> createStore({required StoreModel storeModel}) async {
    isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);

    UserServices userServices = new UserServices();
    var user = await userServices.getLoggedInUser();
    if (user != null) {
      await new StoreServices().createStore(model: storeModel);
      await userServices.updateUser(
          model: new UserModel(
        userId: user.userId,
        name: user.name,
        role: user.role,
        storeId: storeModel.storeId,
        email: user.email,
        password: user.password,
      ));
    } else {
      result = false;
    }

    isLoading = false;
    "Success".showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }

  Future<bool> isUserHasStore() async {
    UserModel? user = await new UserServices().getLoggedInUser();
    if (user != null) {
      return user.storeId.isNotEmpty;
    }
    return false;
  }
}
