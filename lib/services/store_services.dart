import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/services/service_base.dart';

import '../core/enums.dart';

class StoreServices extends ServiceBase {
  StoreModel? storeModel;
  var storeModelRef;

  StoreServices() {
    storeModelRef = db.instance.collection(FireStoreCollectionsNames.Store.name).withConverter<StoreModel>(
          fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
  }

  createStore(StoreModel storeModel) async {
    try {
      await storeModelRef.add(storeModel);
      await getStore(storeId: storeModel.storeId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getStore({required int storeId}) async {
    try {
      QueryDocumentSnapshot<StoreModel> movies = await storeModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      storeModel = movies.data();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}




