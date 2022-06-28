import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/service_base.dart';
import 'package:shop/services/users/user_local.dart';
import 'package:shop/services/users/user_remote.dart';

class UserServices extends ServiceBase {
  UserModel? _userModel;
  List<UserModel> _usersModel = <UserModel>[];
  late UserRemote _userRemote;
  userLocal _userLocal = new userLocal();
  var _userModelRef;

  UserServices() {
    _userModelRef = db.instance
        .collection(CollectionsNames.users)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    _userRemote = new UserRemote(_userModelRef);
  }

  getUser({required String userId}) async {
    try {
      UserModel? cachedUser = await _userLocal.getCashUser(userId: userId);
      if (cachedUser != null) {
        _userModel = cachedUser;
      } else {
        var user = await _userRemote.getUser(userId: userId);
        _userModel = user;
        _userLocal.cachingUser(userId: userId, model: _userModel);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getUserByEmail({required String email}) async {
    try {
      var user = await _userRemote.getUserByEmail(email: email);
      _userModel = user;

      notifyListeners();

      return _userModel;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getStoreUsers({required String storeId}) async {
    try {
      var cashStoreUsers = await _userLocal.getCashStoreUsers(storeId: storeId);
      if (cashStoreUsers != null) {
        _usersModel = cashStoreUsers;
      } else {
        var storeUsers = await _userRemote.getStoreUsers(storeId: storeId);
        _usersModel = storeUsers;
        await _userLocal.cachingStoreUsers(
            storeId: storeId, storeUsers: _usersModel);
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
      var cashAllUsers = await _userLocal.getCashAllUsers();
      if (cashAllUsers != null) {
        _usersModel = cashAllUsers;
      } else {
        var storeUsers = await _userRemote.getAllUsers();
        _usersModel = storeUsers;
        await _userLocal.cachingAllUsers(_usersModel);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  createUser({required UserModel model}) async {
    try {

      var _user = await _userRemote.getUserByEmail(email: model.email);
      if(_user == null){
        await _userModelRef.add(model);
        await getUser(userId: model.userId);
        _userLocal.deleteCachedUser(userId: model.userId);
        _userLocal.deleteCachedStoreUsers(storeId: model.storeId);
        _userLocal.deleteCachedAllUsers();
      }

    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  updateUser({required UserModel model}) async {
    try {
      QueryDocumentSnapshot<UserModel> user = await _userModelRef
          .where('userId', isEqualTo: model.userId)
          .get()
          .then((snapshot) {
        return snapshot.docs.first;
      });
      _userModelRef.doc(user.id).update(model.toJson());
      _userLocal.deleteCachedUser(userId: model.userId);
      _userLocal.deleteCachedStoreUsers(storeId: model.storeId);
      _userLocal.deleteCachedAllUsers();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  deleteUser({required String userId, required String storeId}) async {
    try {
      QueryDocumentSnapshot<UserModel> user = await _userModelRef
          .where('userId', isEqualTo: userId)
          .get()
          .then((snapshot) {
        return snapshot.docs.first;
      });
      _userModelRef.doc(user.id).delete();
      _userLocal.deleteCachedUser(userId: userId);
      _userLocal.deleteCachedStoreUsers(storeId: storeId);
      _userLocal.deleteCachedAllUsers();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
