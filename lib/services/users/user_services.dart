import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/core/instances.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/users/user_local.dart';
import 'package:shop/services/users/user_remote.dart';

class UserServices {
  Instances _db = new Instances();
  late UserRemote _userRemote;
  UserLocal _userLocal = new UserLocal();
  var _userModelRef;

  UserServices() {
    _userModelRef = _db.instance.collection(CollectionsNames.users).withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    _userRemote = new UserRemote(_userModelRef);
  }

  Future<UserModel?> getLoggedInUser() async {
    try {
      return await _userLocal.getCashUserAsync();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<UserModel?> getUser({required String userId}) async {
    UserModel? userModel;
    try {
      UserModel? cachedUser = await _userLocal.getCashUserAsync();
      if (cachedUser != null) {
        userModel = cachedUser;
      } else {
        var user = await _userRemote.getUser(userId: userId);
        userModel = user;
        _userLocal.cachingUser(model: userModel);
      }
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return userModel;
  }

  Future<UserModel?> getUserByEmail({required String email}) async {
    UserModel? userModel;
    try {
      userModel = await _userRemote.getUserByEmail(email: email);
      if (userModel != null) _userLocal.cachingUser(model: userModel);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return userModel;
  }

  Future<List<UserModel>> getStoreUsers({required String storeId}) async {
    List<UserModel> usersModel = <UserModel>[];
    try {
      var cashStoreUsers = await _userLocal.getCashStoreUsers(storeId: storeId);
      if (cashStoreUsers != null && cashStoreUsers.length != 0) {
        usersModel = cashStoreUsers;
      } else {
        var storeUsers = await _userRemote.getStoreUsers(storeId: storeId);
        usersModel = storeUsers;
        await _userLocal.cachingStoreUsers(storeId: storeId, storeUsers: usersModel);
      }
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return usersModel;
  }

  Future<List<UserModel>?> getAllUsers() async {
    List<UserModel> usersModel = <UserModel>[];

    try {
      var cashAllUsers = await _userLocal.getCashAllUsers();
      if (cashAllUsers != null) {
        usersModel = cashAllUsers;
      } else {
        var storeUsers = await _userRemote.getAllUsers();
        usersModel = storeUsers;
        await _userLocal.cachingAllUsers(usersModel);
      }
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return usersModel;
  }

  Future<UserModel?> createUser({required UserModel model}) async {
    UserModel? userModel;
    try {
      await _userModelRef.add(model);
      _userLocal.deleteCachedUser();
      _userLocal.deleteCachedStoreUsers(storeId: model.storeId);
      userModel = await getUser(userId: model.userId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return userModel;
  }

  updateUser({required UserModel model}) async {
    try {
      QueryDocumentSnapshot<UserModel> user = await _userModelRef.where('userId', isEqualTo: model.userId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      _userModelRef.doc(user.id).update(model.toJson());
      _userLocal.deleteCachedUser();
      //  if (model.storeId != null) _userLocal.deleteCachedStoreUsers(storeId: model.storeId);
      // _userLocal.deleteCachedAllUsers();
      await getUser(userId: model.userId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  deleteUser({required String userId, required String storeId}) async {
    try {
      QueryDocumentSnapshot<UserModel> user = await _userModelRef.where('userId', isEqualTo: userId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      _userModelRef.doc(user.id).delete();
      _userLocal.deleteCachedUser();
      _userLocal.deleteCachedStoreUsers(storeId: storeId);
      // _userLocal.deleteCachedAllUsers();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
