import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/services/customers/customer_local.dart';
import 'package:shop/services/customers/customer_remote.dart';
import 'package:shop/services/service_base.dart';

class CustomerServices extends ServiceBase {
  CustomerModel? customer_Model;
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
      CustomerModel? cachedUser = await customerLocal.getCashCustomer();
      if (cachedUser != null) {
        customer_Model = cachedUser;
      } else {
        var user = await customerRemote.getCustomer(customerId: customerId);
        customer_Model = user;
        customerLocal.cachingCustomer(customer_Model);
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
      var cashStoreCustomers = await customerLocal.getCashStoreUCustomers();
      if (cashStoreCustomers != null) {
        customersModel = cashStoreCustomers;
      } else {
        var storeUsers = await customerRemote.getStoreCustomers(storeId: storeId);
        customersModel = storeUsers;
        await customerLocal.cachingStoreCustomers(customersModel);
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
      await getCustomer(customerId: model.id);
      customerLocal.deleteCachedCustomer();
      customerLocal.deleteCachedStoreCustomers();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  updateUser({required CustomerModel model}) async {
    try {
      QueryDocumentSnapshot<CustomerModel> customer = await customerModelRef.where('customer', isEqualTo: model.id).get().then((snapshot) {
        return snapshot.docs.first;
      });
      customerModelRef.doc(customer.id).update(model.toJson());
      customerLocal.deleteCachedCustomer();
      customerLocal.deleteCachedStoreCustomers();
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
      customerLocal.deleteCachedCustomer();
      customerLocal.deleteCachedStoreCustomers();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
