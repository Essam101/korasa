import 'package:get_storage/get_storage.dart';
import 'package:shop/core/cachingKeys.dart';
import 'package:shop/models/storeModel.dart';

class StoreLocal {
  GetStorage localStorage = new GetStorage();

  Future<void> cacheStore(StoreModel cacheStore) {
    return localStorage.write(CachingKeys.store, cacheStore.toJson());
  }

  Future<void> cacheStores(List<StoreModel> cacheStores) {
    return localStorage.write(CachingKeys.stores, storeModelToJson(cacheStores));
  }

  Future<StoreModel>? getCachedStore() {
    final jsonUsers = localStorage.read(CachingKeys.store);
    if (jsonUsers != null) {
      return Future.value(StoreModel.fromRawJson(jsonUsers));
    } else {
      return null;
    }
  }

  Future<List<StoreModel>>? getCachedUsers() {
    final jsonStores = localStorage.read(CachingKeys.stores);
    if (jsonStores != null) {
      return Future.value(storeModelFromJson(jsonStores));
    } else {
      return null;
    }
  }
}
