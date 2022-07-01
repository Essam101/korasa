import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/services/customers/customer_services.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_services.dart';

class AddCustomerState extends ServiceBase {
  Future<bool> createCustomer({required CustomerModel model}) async {
    this.isLoading = true;
    bool result = true;

    "Loading".showLoading(alertType: AlertType.Loading);

    UserServices userServices = new UserServices();

    var user = await userServices.getLoggedInUser();

    if (user != null) {
      model.storeId = user.storeId;
      await new CustomerServices().createCustomer(model: model);
    } else {
      result = false;
    }

    isLoading = false;

    "Success"
        .showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }
}
