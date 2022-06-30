import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/core/db.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/services/store/store_local.dart';
import 'package:shop/services/store/store_remote.dart';

class StoreServices {
  Db _db = new Db();

  late StoreRemote _storeRemote;
  StoreLocal _storeLocal = new StoreLocal();
  var _storeModelRef;

  StoreServices() {
    _storeModelRef = _db.instance.collection(CollectionsNames.stores).withConverter<StoreModel>(
          fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    _storeRemote = new StoreRemote(_storeModelRef);
  }

  Future<StoreModel?> getStore({required String storeId}) async {
    StoreModel? storeModel;
    try {
      StoreModel? cachedStore = await _storeLocal.getCachedStore();
      if (cachedStore != null) {
        storeModel = cachedStore;
      } else {
        var store = await _storeRemote.getStore(storeId: storeId);
        storeModel = store;
        _storeLocal.cacheStore(storeModel);
      }
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return storeModel;
  }

  Future<List<StoreModel>?> getStores() async {
    List<StoreModel>? storesModel = <StoreModel>[];

    try {
      var cachedStores = await _storeLocal.getCachedStores();
      if (cachedStores != null) {
        storesModel = cachedStores;
      } else {
        var stores = await _storeRemote.getStores();
        storesModel = stores;
        await _storeLocal.cacheStores(storesModel);
      }
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return storesModel;
  }

  Future<StoreModel?> createStore({required StoreModel model}) async {
    StoreModel? storeModel;
    try {
      await _storeModelRef.add(model);
      await _storeLocal.deleteCachedStore();
      await _storeLocal.deleteCachedStores();
      storeModel = await getStore(storeId: model.storeId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return storeModel;
  }

  Future<StoreModel?> updateStore({required StoreModel model}) async {
    StoreModel? storeModel;
    try {
      QueryDocumentSnapshot<StoreModel> store = await _storeModelRef.where('storeId', isEqualTo: model.storeId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      _storeModelRef.doc(store.id).update(model.toJson());
      _storeLocal.deleteCachedStore();
      _storeLocal.deleteCachedStores();
      storeModel = await getStore(storeId: model.storeId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return storeModel;
  }

  Future<bool> deleteStore({required String storeId}) async {
    try {
      QueryDocumentSnapshot<StoreModel> store = await _storeModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      _storeModelRef.doc(store.id).delete();
      _storeLocal.deleteCachedStore();
      _storeLocal.deleteCachedStores();
      return true;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return false;
  }
}
