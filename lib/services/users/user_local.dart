import 'package:get_storage/get_storage.dart';
import 'package:shop/core/cachingKeys.dart';
import 'package:shop/models/userModel.dart';

class userLocal {
  GetStorage localStorage = new GetStorage();

  Future<void>? cachingUser(UserModel? model) {
    if (model != null) {
      return localStorage.write(CachingKeys.user, model.toJson());
    }
    return null;
  }

  Future<void> cachingStoreUsers(List<UserModel> storeUsers) {
    return localStorage.write(CachingKeys.storeUsers, userModelToJson(storeUsers));
  }

  Future<void> cachingAllUsers(List<UserModel> allUsers) {
    return localStorage.write(CachingKeys.storeUsers, userModelToJson(allUsers));
  }

  Future<UserModel>? getCashUser() {
    final jsonUsers = localStorage.read(CachingKeys.user);
    if (jsonUsers != null) {
      return Future.value(UserModel.fromRawJson(jsonUsers));
    } else {
      return null;
    }
  }

  Future<List<UserModel>>? getCashStoreUsers() {
    final jsonStores = localStorage.read(CachingKeys.storeUsers);
    if (jsonStores != null && jsonStores.length != 0) {
      return Future.value(userModelFromJson(jsonStores));
    } else {
      return null;
    }
  }

  Future<List<UserModel>>? getCashAllUsers() {
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
