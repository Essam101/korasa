import 'package:shop/core/collectionsNames.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/generateId.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/models/pageModel.dart';
import 'package:shop/services/customers/customer_services.dart';
import 'package:shop/services/pages/page_services.dart';
import 'package:shop/services/service_base.dart';

class CustomerState extends ServiceBase {
  List<CustomerModel> customersModel = [];
  CustomerModel? customerModel;

  getCustomers() async {
    this.isLoading = true;
    if (storeId.isNotEmpty) customersModel =
    await new CustomerServices().getStoreCustomer(storeId: storeId);
    isLoading = false;
    notifyListeners();
  }

  Future<bool> updateOrCreateCustomer({required CustomerModel model}) async {
    this.isLoading = true;
    bool result = true;
    "Loading".showLoading(alertType: AlertType.Loading);

    if (model.customerId.isNotEmpty && storeId.isNotEmpty) {
      // Update
      await new CustomerServices().updateCustomer(model: model);
      await getCustomers();
    } else // Add new
        {
      if (storeId.isNotEmpty) {
        model.storeId = storeId;
        model.customerId = CollectionsNames.customers.generateId();
        await new CustomerServices().createCustomer(model: model);
        await new PageServices().createPage(new PageModel(
            pageId: CollectionsNames.pages.generateId(),
            storeId: model.storeId,
            customerId: model.customerId,
            creationDate: DateTime.now().toString(),
            orders: [],
            transactions: []));
        await getCustomers();
      } else {
        result = false;
      }
    }

    isLoading = false;
    "Success".showLoading(
        alertType: result ? AlertType.Success : AlertType.Error);
    return result;
  }

  deleteCustomer({required String customerId}) async {
    this.isLoading = true;
    await new CustomerServices().deleteCustomer(customerId: customerId);
    await getCustomers();
  }

  @override
  clear() {
    super.clear();
    customersModel.clear();
    customerModel = null;
    notifyListeners();
  }
}
