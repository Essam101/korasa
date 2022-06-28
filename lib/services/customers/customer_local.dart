import 'package:get_storage/get_storage.dart';
import 'package:shop/core/cachingKeys.dart';
import 'package:shop/models/customerModel.dart';

class CustomerLocal {
  GetStorage localStorage = new GetStorage();

  Future<void>? cachingCustomerById({required String customerId,required CustomerModel? model}) {
    if (model != null) {
      return localStorage.write(CachingKeys.user.addIdToKey(id: customerId), model.toJson());
    }
    return null;
  }

  Future<void> cachingStoreCustomersByStoreId({
    required String storeId,
    required List<CustomerModel> storeCustomers,
  }) {
    return localStorage.write(CachingKeys.storeUsers.addIdToKey(id: storeId), customerModelToJson(storeCustomers));
  }

  Future<CustomerModel>? getCashedCustomerById({required String customerId}) {
    final jsonCustomer = localStorage.read(CachingKeys.customer.addIdToKey(id: customerId));
    if (jsonCustomer != null) {
      return Future.value(CustomerModel.fromRawJson(jsonCustomer));
    } else {
      return null;
    }
  }

  Future<List<CustomerModel>>? getCashedStoreCustomersByStoreId({required String storeId}) {
    final jsonCustomers = localStorage.read(CachingKeys.storeCustomers.addIdToKey(id: storeId));
    if (jsonCustomers != null && jsonCustomers.length != 0) {
      return Future.value(customerModelFromJson(jsonCustomers));
    } else {
      return null;
    }
  }

  deleteCachedCustomer({required String customerId}) {
    localStorage.remove(CachingKeys.customer.addIdToKey(id: customerId));
  }

  deleteCachedStoreCustomers({required String storeId}) {
    localStorage.remove(CachingKeys.storeCustomers.addIdToKey(id: storeId));
  }
}
