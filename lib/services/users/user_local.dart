import 'package:get_storage/get_storage.dart';
import 'package:shop/core/cachingKeys.dart';
import 'package:shop/models/userModel.dart';

class userLocal {
  GetStorage localStorage = new GetStorage();

  Future<void>? cachingUser(userModel? model) {
    if (model != null) {
      return localStorage.write(CachingKeys.user, model.toJson());
    }
    return null;
  }

  Future<void> cachingStoreUsers(List<userModel> storeUsers) {
    return localStorage.write(
        CachingKeys.storeUsers, userModelToJson(storeUsers));
  }

  Future<void> cachingAllUsers(List<userModel> allUsers) {
    return localStorage.write(
        CachingKeys.storeUsers, userModelToJson(allUsers));
  }

  Future<userModel>? getCashUser() {
    final jsonUsers = localStorage.read(CachingKeys.user);
    if (jsonUsers != null) {
      return Future.value(userModel.fromRawJson(jsonUsers));
    } else {
      return null;
    }
  }

  Future<List<userModel>>? getCashStoreUsers() {
    final jsonStores = localStorage.read(CachingKeys.storeUsers);
    if (jsonStores != null && jsonStores.length != 0) {
      return Future.value(userModelFromJson(jsonStores));
    } else {
      return null;
    }
  }

  Future<List<userModel>>? getCashAllUsers() {
    final jsonStores = localStorage.read(CachingKeys.allUsers);
    if (jsonStores != null && jsonStores.length != 0) {
      return Future.value(userModelFromJson(jsonStores));
    } else {
      return null;
    }
  }

  deleteCachedUser() {
    localStorage.remove(CachingKeys.store);
  }

  deleteCachedStoreUsers() {
    localStorage.remove(CachingKeys.storeUsers);
  }

  deleteCachedAllUsers() {
    localStorage.remove(CachingKeys.allUsers);
  }
}
