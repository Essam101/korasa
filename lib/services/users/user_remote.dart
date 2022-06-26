import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/services/service_base.dart';

class UserRemote extends ServiceBase {
  final userModelRef;

  UserRemote(this.userModelRef);

  Future<UserModel?> getUser({required String userId}) async {
    try {
      QueryDocumentSnapshot<UserModel> user = await userModelRef.where('userId', isEqualTo: userId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      return user.data();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<UserModel>> getStoreUsers({required String storeId}) async {
    try {
      List<QueryDocumentSnapshot<UserModel>> stores = await userModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
        return snapshot.docs;
      });
      List<UserModel> _stores = [];
      stores.forEach((element) {
        _stores
            .add(new UserModel(userId: element.data().userId, name: element.data().name, role: element.data().role, storeId: element.data().storeId));
      });
      return _stores;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<UserModel>> getAllUsers() async {
    try {
      List<QueryDocumentSnapshot<UserModel>> stores = await userModelRef.get().then((snapshot) {
        return snapshot.docs;
      });
      List<UserModel> _stores = [];
      stores.forEach((element) {
        _stores
            .add(new UserModel(userId: element.data().userId, name: element.data().name, role: element.data().role, storeId: element.data().storeId));
      });
      return _stores;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
