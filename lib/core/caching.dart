import 'package:get_storage/get_storage.dart';
import 'package:shop/core/cachingKeys.dart';
import 'package:shop/models/storeModel.dart';

class Caching {}

class GetUsersLocalDataSourceImpl {
  GetUsersLocalDataSourceImpl({required this.localStorage});

  final GetStorage localStorage;

  Future<void> cacheUsers(StoreModel cacheStore) {
    return localStorage.write(CachingKeys.store, cacheStore.toJson());
  }

  @override
  Future<StoreModel> getCachedUsers() {
    final jsonUsers = localStorage.read("users");
    if (jsonUsers != null) {
      return Future.value(StoreModel.fromRawJson(jsonUsers));
    } else {
      throw " Cache Error ";
    }
  }
}
