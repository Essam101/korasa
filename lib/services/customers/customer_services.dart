import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/services/customers/customer_local.dart';
import 'package:shop/services/customers/customer_remote.dart';
import 'package:shop/services/service_base.dart';

class CustomerServices extends ServiceBase {
  CustomerModel? _customerModel;
  List<CustomerModel> _customersModel = <CustomerModel>[];
  late CustomerRemote _customerRemote;
  CustomerLocal _customerLocal = new CustomerLocal();
  var _customerModelRef;

  CustomerServices() {
    _customerModelRef = db.instance.collection(CollectionsNames.customers).withConverter<CustomerModel>(
          fromFirestore: (snapshot, _) => CustomerModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    _customerRemote = new CustomerRemote(_customerModelRef);
  }

  getCustomer({required String customerId}) async {
    try {
      var customer = await _customerLocal.getCashedCustomerById(customerId: customerId);
      if (customer != null) {
        _customerModel = customer;
      } else {
        var customer = await _customerRemote.getCustomer(customerId: customerId);
        _customerModel = customer;
        _customerLocal.cachingCustomerById(customerId: customerId,model: _customerModel);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getStoreCustomer({required String storeId}) async {
    try {
      var customers = await _customerLocal.getCashedStoreCustomersByStoreId(storeId: storeId);
      if (customers != null) {
        _customersModel = customers;
      } else {
        var customers = await _customerRemote.getStoreCustomers(storeId: storeId);
        _customersModel = customers;
        await _customerLocal.cachingStoreCustomersByStoreId(storeId: storeId, storeCustomers: _customersModel);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  createCustomer(CustomerModel model) async {
    try {
      await _customerModelRef.add(model);
      await getCustomer(customerId: model.customerId);
      _customerLocal.deleteCachedCustomer(customerId: model.customerId);
      _customerLocal.deleteCachedStoreCustomers(storeId: model.storeId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  updateCustomer({required CustomerModel model}) async {
    try {
      QueryDocumentSnapshot<CustomerModel> customer = await _customerModelRef.where('customerId', isEqualTo: model.customerId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      _customerModelRef.doc(customer.id).update(model.toJson());
      _customerLocal.deleteCachedCustomer(customerId: model.customerId);
      _customerLocal.deleteCachedStoreCustomers(storeId: model.storeId);
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  deleteCustomer({required String customerId}) async {
    try {
      QueryDocumentSnapshot<CustomerModel> customer = await _customerModelRef.where('customerId', isEqualTo: customerId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      _customerModelRef.doc(customer.id).delete();
      _customerLocal.deleteCachedCustomer(customerId: customerId);
      _customerLocal.deleteCachedStoreCustomers(storeId: customer.data().storeId);
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
