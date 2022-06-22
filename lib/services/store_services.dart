import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/services/service_base.dart';

import '../core/enums.dart';

class StoreServices extends ServiceBase {
  StoreModel? storeModel;
  var storeModelRef;

  StoreServices() {
    storeModelRef = db.instance.collection(FireStoreCollectionsNames.Store.name).withConverter<StoreModel>(
          fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
  }

  createStore(StoreModel storeModel) async {
    try {
      await storeModelRef.add(storeModel);
      await getStore(storeId: storeModel.storeId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getStore({required int storeId}) async {
    try {
      QueryDocumentSnapshot<StoreModel> movies = await storeModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      storeModel = movies.data();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
// import 'dart:ffi';
//
// class Store {
//   /// store Id
//   String Id = "";
//
//   /// store Name
//   String Name = "";
// }
//
// class Users {
//   /// userId
//   String Id = "";
//
//   /// user Name
//   String Name = "";
//
//   /// user role   "owner |   employee"
//   UserRole Role = UserRole.owner;
//
//   /// store id
//   String StoreId = "";
// }
//
// class Customer {
//   /// customer Id
//   String Id = "";
//
//   /// customer Name
//   String Name = "";
//
//   /// store id
//   String StoreId = "";
// }
//
// class Orders {
//   /// Order ID
//   String Id = '';
//
//   /// Order Name  like  "1 kg sugar"
//   String ProductName = "";
//
//   /// Order Date
//   DateTime CreationDate = DateTime.now();
//
//   /// Order Amount
//   double Amount = 0;
//
//   bool IsPaid = false;
//
//   /// Customer ID
//   String CustomerId = "";
//
//   /// store id
//   String StoreId = "";
// }
//
// class Transactions {
//   Int Id = 0 as Int;
//
//   DateTime CreationDate = DateTime.now();
//
//   double Amount = 0;
//
//   /// Customer ID
//   String CustomerId = "";
//
//   String OrderId = "";
//
//   /// store id
//   String StoreId = "";
// }
//
// enum UserRole { owner, emp }
