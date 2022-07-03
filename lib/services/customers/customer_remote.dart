import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/services/service_base.dart';

class CustomerRemote extends ServiceBase {
  final customerModelRef;

  CustomerRemote(this.customerModelRef);

  Future<CustomerModel?> getCustomer({required String customerId}) async {
    try {
      QueryDocumentSnapshot<CustomerModel> user = await customerModelRef.where('customerId', isEqualTo: customerId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      return user.data();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<CustomerModel>> getStoreCustomers({required String storeId}) async {
    try {
      List<QueryDocumentSnapshot<CustomerModel>> customers = await customerModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
        return snapshot.docs;
      });
      List<CustomerModel> _customers = [];
      customers.forEach((element) {
        _customers.add(
          new CustomerModel(
            creationDate: element.data().creationDate,
            customerId: element.data().customerId,
            name: element.data().name,
            storeId: element.data().storeId,
            notes: element.data().notes,
          ),
        );
      });
      return _customers;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
