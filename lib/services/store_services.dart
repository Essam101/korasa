import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/services/service_base.dart';

import '../core/enums.dart';

class StoreServices extends ServiceBase {
  CollectionReference stores = FirebaseFirestore.instance.collection(FireStoreCollectionsNames.Store.name);
  StoreModel? storeModel;

  createStore(StoreModel storeModel) async {
    return stores.add(storeModel.toJson()).then((value) {
      systemFeedBack.showAlert(alertType: AlertType.Success, massage: "User Added");
    }).catchError((error) {
      systemFeedBack.showAlert(alertType: AlertType.Error, massage: "Failed to add user: $error");
    });
  }

  getStore() async {
    storeModel = FirebaseFirestore.instance
        .collection(FireStoreCollectionsNames.Store.name)
        .withConverter<StoreModel>(
          fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        )
        .where((s) => s == 1) as StoreModel?;
  }
}




