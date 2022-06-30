import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:shop/core/cachingKeys.dart';
import 'package:shop/models/userModel.dart';

class userLocal {
  GetStorage localStorage = new GetStorage();

  Future<void>? cachingUser({required UserModel? model}) {
    if (model != null) {
      localStorage.write(CachingKeys.user, model.toJson());
    }
    return null;
  }

  Future<void> cachingStoreUsers({required String storeId, required List<UserModel> storeUsers}) {
    return localStorage.write(CachingKeys.storeUsers.addIdToKey(id: storeId), userModelToJson(storeUsers));
  }

  Future<void> cachingAllUsers(List<UserModel> allUsers) {
    return localStorage.write(CachingKeys.storeUsers, userModelToJson(allUsers));
  }

  Future<UserModel>? getCashUser() {
    final jsonUsers = localStorage.read(CachingKeys.user);
    if (jsonUsers != null) {
      return Future.value(UserModel.fromRawJson(jsonEncode(jsonUsers)));
    } else {
      return null;
    }
  }

  Future<List<UserModel>>? getCashStoreUsers({required String storeId}) {
    final jsonStores = localStorage.read(CachingKeys.storeUsers.addIdToKey(id: storeId));
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
    localStorage.remove(CachingKeys.user);
  }

  deleteCachedStoreUsers({required String storeId}) {
    localStorage.remove(CachingKeys.storeUsers.addIdToKey(id: storeId));
  }

// deleteCachedAllUsers() {
//   for (int i = 0; i < localStorage.getKeys().length; i++) {
//     if (localStorage.getKeys()[i].toString().contains(CachingKeys.user)) {
//       localStorage.remove(localStorage.getKeys()[i]);
//     }
//   }
// }
}
