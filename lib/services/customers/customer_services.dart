import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/services/customers/customer_local.dart';
import 'package:shop/services/customers/customer_remote.dart';
import 'package:shop/services/service_base.dart';

class CustomerServices extends ServiceBase {
  CustomerModel? customerModel;
  List<CustomerModel> customersModel = <CustomerModel>[];
  late CustomerRemote customerRemote;
  CustomerLocal customerLocal = new CustomerLocal();
  var customerModelRef;

  CustomerServices() {
    customerModelRef = db.instance.collection(CollectionsNames.stores).withConverter<CustomerModel>(
          fromFirestore: (snapshot, _) => CustomerModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    customerRemote = new CustomerRemote(customerModelRef);
  }

  getCustomer({required String customerId}) async {
    try {
      var customer = await customerLocal.getCashedCustomerById(customerId: customerId);
      if (customer != null) {
        customerModel = customer;
      } else {
        var customer = await customerRemote.getCustomer(customerId: customerId);
        customerModel = customer;
        customerLocal.cachingCustomerById(customerId: customerId,model: customerModel);
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
      var customers = await customerLocal.getCashedStoreCustomersByStoreId(storeId: storeId);
      if (customers != null) {
        customersModel = customers;
      } else {
        var customers = await customerRemote.getStoreCustomers(storeId: storeId);
        customersModel = customers;
        await customerLocal.cachingStoreCustomersByStoreId(storeId: storeId, storeCustomers: customersModel);
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
      await customerModelRef.add(model);
      await getCustomer(customerId: model.customerId);
      customerLocal.deleteCachedCustomer(customerId: model.customerId);
      customerLocal.deleteCachedStoreCustomers(storeId: model.storeId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  updateUser({required CustomerModel model}) async {
    try {
      QueryDocumentSnapshot<CustomerModel> customer = await customerModelRef.where('customer', isEqualTo: model.customerId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      customerModelRef.doc(customer.id).update(model.toJson());
      customerLocal.deleteCachedCustomer(customerId: model.customerId);
      customerLocal.deleteCachedStoreCustomers(storeId: model.storeId);
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  deleteUser({required String customerId}) async {
    try {
      QueryDocumentSnapshot<CustomerModel> customer = await customerModelRef.where('customerId', isEqualTo: customerId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      customerModelRef.doc(customer.id).delete();
      customerLocal.deleteCachedCustomer(customerId: customerId);
      customerLocal.deleteCachedStoreCustomers(storeId: customer.data().storeId);
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
