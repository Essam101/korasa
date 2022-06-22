import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/services/service_base.dart';

class CustomerRemote extends ServiceBase {
  final customerModelRef;

  CustomerRemote(this.customerModelRef);

  Future<customerModel?> getCustomer({required String customerId}) async {
    try {
      QueryDocumentSnapshot<customerModel> user = await customerModelRef.where('customerId', isEqualTo: customerId).get().then((snapshot) {
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

  Future<List<customerModel>> getStoreCustomers({required String storeId } ) async {
    try {
      List<QueryDocumentSnapshot<customerModel>> customers = await customerModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
        return snapshot.docs;
      });
      List<customerModel> _customers = [];
      customers.forEach((element) {
        _customers.add(new customerModel(id: element.data().id,name: element.data().name , storeId: element.data().storeId));
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
