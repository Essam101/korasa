import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/storeModel.dart';

class StoreRemote {
  final storeModelRef;

  StoreRemote(this.storeModelRef);

  Future<StoreModel?> getStore({required String storeId}) async {
    try {
      QueryDocumentSnapshot<StoreModel> store = await storeModelRef
          .where('storeId', isEqualTo: storeId)
          .get()
          .then((snapshot) {
        return snapshot.docs.first;
      });
      return store.data();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<StoreModel>> getStores() async {
    try {
      List<QueryDocumentSnapshot<StoreModel>> stores =
          await storeModelRef.get().then((snapshot) {
        return snapshot.docs;
      });
      List<StoreModel> _stores = [];
      stores.forEach((element) {
        _stores.add(new StoreModel(
            storeId: element.data().storeId,
            name: element.data().name,
            status: element.data().status));
      });
      return _stores;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
