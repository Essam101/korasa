import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/core/instances.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/services/customers/customer_local.dart';
import 'package:shop/services/customers/customer_remote.dart';
import 'package:shop/services/service_base.dart';

class CustomerServices {
  Instances _db = new Instances();
  late CustomerRemote _customerRemote;
  CustomerLocal _customerLocal = new CustomerLocal();
  var _customerModelRef;

  CustomerServices() {
    _customerModelRef = _db.instance.collection(CollectionsNames.customers).withConverter<CustomerModel>(
          fromFirestore: (snapshot, _) => CustomerModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    _customerRemote = new CustomerRemote(_customerModelRef);
  }

  Future<CustomerModel?> getCustomer({required String customerId}) async {
    CustomerModel? customerModel;
    try {
      var customer = await _customerLocal.getCashedCustomerById(customerId: customerId);
      if (customer != null) {
        customerModel = customer;
      } else {
        var customer = await _customerRemote.getCustomer(customerId: customerId);
        customerModel = customer;
        _customerLocal.cachingCustomerById(customerId: customerId, model: customerModel);
      }
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return customerModel;
  }

  Future<List<CustomerModel>> getStoreCustomer({required String storeId}) async {
    List<CustomerModel> customersModel = [];
    try {
      var customers = await _customerLocal.getCashedStoreCustomersByStoreId(storeId: storeId);
      if (customers != null && customers.length != 0) {
        customersModel = customers;
      } else {
        var customers = await _customerRemote.getStoreCustomers(storeId: storeId);
        customersModel = customers;
        await _customerLocal.cachingStoreCustomersByStoreId(storeId: storeId, storeCustomers: customersModel);
      }
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return customersModel;
  }

  Future<CustomerModel?> createCustomer({required CustomerModel model}) async {
    try {
      await _customerModelRef.add(model);
      _customerLocal.deleteCachedCustomer(customerId: model.customerId);
      _customerLocal.deleteCachedStoreCustomers(storeId: model.storeId);
      return await getCustomer(customerId: model.customerId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<CustomerModel?> updateCustomer({required CustomerModel model}) async {
    try {
      QueryDocumentSnapshot<CustomerModel> customer = await _customerModelRef.where('customerId', isEqualTo: model.customerId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      _customerModelRef.doc(customer.id).update(model.toJson());
      _customerLocal.deleteCachedCustomer(customerId: model.customerId);
      _customerLocal.deleteCachedStoreCustomers(storeId: model.storeId);
      return await getCustomer(customerId: model.customerId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> deleteCustomer({required String customerId}) async {
    try {
      QueryDocumentSnapshot<CustomerModel> customer = await _customerModelRef.where('customerId', isEqualTo: customerId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      _customerModelRef.doc(customer.id).delete();
      _customerLocal.deleteCachedCustomer(customerId: customerId);
      _customerLocal.deleteCachedStoreCustomers(storeId: customer.data().storeId);
      return true;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return false;
  }
}
