import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/services/service_base.dart';

class StoreRemote extends ServiceBase {
  final storeModelRef;

  StoreRemote(this.storeModelRef);

  Future<StoreModel?> getStore({required String storeId}) async {
    try {
      QueryDocumentSnapshot<StoreModel> store = await storeModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
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
      List<QueryDocumentSnapshot<StoreModel>> stores = await storeModelRef.get().then((snapshot) {
        return snapshot.docs;
      });
      return stores as List<StoreModel>;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
