import 'package:get_storage/get_storage.dart';
import 'package:shop/core/cachingKeys.dart';
import 'package:shop/models/customerModel.dart';

class CustomerLocal {
  GetStorage localStorage = new GetStorage();

  Future<void>? cachingCustomer(CustomerModel? model) {
    if (model != null) {
      return localStorage.write(CachingKeys.user, model.toJson());
    }
    return null;
  }

  Future<void> cachingStoreCustomers(List<CustomerModel> storeCustomers) {
    return localStorage.write(CachingKeys.storeUsers, customerModelToJson(storeCustomers));
  }

  Future<CustomerModel>? getCashCustomer() {
    final jsonCustomer = localStorage.read(CachingKeys.customer);
    if (jsonCustomer != null) {
      return Future.value(CustomerModel.fromRawJson(jsonCustomer));
    } else {
      return null;
    }
  }

  Future<List<CustomerModel>>? getCashStoreUCustomers() {
    final jsonCustomers = localStorage.read(CachingKeys.storeCustomers);
    if (jsonCustomers != null && jsonCustomers.length != 0) {
      return Future.value(customerModelFromJson(jsonCustomers));
    } else {
      return null;
    }
  }

  deleteCachedCustomer() {
    localStorage.remove(CachingKeys.customer);
  }

  deleteCachedStoreCustomers() {
    localStorage.remove(CachingKeys.storeCustomers);
  }
}
