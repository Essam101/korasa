import 'package:get_storage/get_storage.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/services/customers/customer_services.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_services.dart';

class CustomerState extends ServiceBase {
  List<CustomerModel> customersModel = [];

  getCustomers() async {
    this.isLoading = true;
    if (storeId.isNotEmpty) customersModel = await new CustomerServices().getStoreCustomer(storeId: storeId);
    isLoading = false;
    notifyListeners();
  }

  Future<bool> createCustomer({required CustomerModel model}) async {
    this.isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);
    if (storeId.isNotEmpty) {
      model.storeId = storeId;
      await new CustomerServices().createCustomer(model: model);
      await getCustomers();
    } else {
      result = false;
    }

    isLoading = false;
    "Success".showLoading(alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }
}
