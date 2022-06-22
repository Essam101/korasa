import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/store/store_local.dart';
import 'package:shop/services/store/store_remote.dart';

class StoreServices extends ServiceBase {
  StoreModel? storeModel;
  List<StoreModel> storesModel = <StoreModel>[];
  late StoreRemote storeRemote;
  StoreLocal storeLocal = new StoreLocal();
  var storeModelRef;

  StoreServices() {
    storeModelRef = db.instance.collection(CollectionsNames.stores).withConverter<StoreModel>(
          fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    storeRemote = new StoreRemote(storeModelRef);
  }

  getStore({required String storeId}) async {
    try {
      StoreModel? cachedStore = await storeLocal.getCachedStore();
      if (cachedStore != null) {
        storeModel = cachedStore;
      } else {
        var store = await storeRemote.getStore(storeId: storeId);
        storeModel = store;
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getStores() async {
    try {
      var cachedStores = await storeLocal.getCachedUsers();
      if (cachedStores != null) {
        storesModel = cachedStores;
      } else {
        var stores = await storeRemote.getStores();
        storesModel = stores;
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
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

  updateStore({required StoreModel storeModel}) async {
    try {
      QueryDocumentSnapshot<StoreModel> store = await storeModelRef.where('storeId', isEqualTo: storeModel.storeId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      storeModelRef.doc(store.id).update(storeModel.toJson());
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  deleteStore({required String storeId}) async {
    try {
      QueryDocumentSnapshot<StoreModel> store = await storeModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      storeModelRef.doc(store.id).delete();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}