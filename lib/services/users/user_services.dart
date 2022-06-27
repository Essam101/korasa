import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_local.dart';
import 'package:shop/services/users/user_remote.dart';

class UserServices extends ServiceBase {
  UserModel? user_Model;
  List<UserModel> usersModel = <UserModel>[];
  late UserRemote userRemote;
  userLocal user_Local = new userLocal();
  var userModelRef;

  UserServices() {
    userModelRef =
        db.instance.collection(CollectionsNames.stores).withConverter<
            UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    userRemote = new UserRemote(userModelRef);
  }

  getUser({required String userId}) async {
    try {
      UserModel? cachedUser = await user_Local.getCashUser(userId: userId);
      if (cachedUser != null) {
        user_Model = cachedUser;
      } else {
        var user = await userRemote.getUser(userId: userId);
        user_Model = user;
        user_Local.cachingUser(userId: userId, model: user_Model);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getStoreUsers({required String storeId}) async {
    try {
      var cashStoreUsers = await user_Local.getCashStoreUsers(storeId: storeId);
      if (cashStoreUsers != null) {
        usersModel = cashStoreUsers;
      } else {
        var storeUsers = await userRemote.getStoreUsers(storeId: storeId);
        usersModel = storeUsers;
        await user_Local.cachingStoreUsers(
            storeId: storeId, storeUsers: usersModel);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getAllUsers() async {
    try {
      var cashAllUsers = await user_Local.getCashAllUsers();
      if (cashAllUsers != null) {
        usersModel = cashAllUsers;
      } else {
        var storeUsers = await userRemote.getAllUsers();
        usersModel = storeUsers;
        await user_Local.cachingAllUsers(usersModel);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  createUser(UserModel model) async {
    try {
      await userModelRef.add(model);
      await getUser(userId: model.userId);
      user_Local.deleteCachedUser(userId: model.userId);
          user_Local.deleteCachedStoreUsers(storeId: model.storeId);
      user_Local.deleteCachedAllUsers();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  updateUser({required UserModel model}) async {
    try {
      QueryDocumentSnapshot<UserModel> user = await userModelRef.where(
          'userId', isEqualTo: model.userId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      userModelRef.doc(user.id).update(model.toJson());
      user_Local.deleteCachedUser(userId: model.userId);
      user_Local.deleteCachedStoreUsers(storeId: model.storeId);
      user_Local.deleteCachedAllUsers();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  deleteUser({required String userId, required String storeId}) async {
    try {
      QueryDocumentSnapshot<UserModel> user = await userModelRef.where(
          'userId', isEqualTo: userId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      userModelRef.doc(user.id).delete();
      user_Local.deleteCachedUser(userId: userId);
      user_Local.deleteCachedStoreUsers(storeId: storeId);
      user_Local.deleteCachedAllUsers();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
