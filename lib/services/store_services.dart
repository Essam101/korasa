import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/services/service_base.dart';

import '../core/enums.dart';

class StoreServices extends ServiceBase {
  CollectionReference stores = FirebaseFirestore.instance.collection(FireStoreCollectionsNames.Store.name);
  StoreModel? storeModel;

  createStore(StoreModel storeModel) async {
    return stores.add(storeModel.toJson()).then((value) {
      systemFeedBack.showAlert(alertType: AlertType.Success, massage: "User Added");
    }).catchError((error) {
      systemFeedBack.showAlert(alertType: AlertType.Error, massage: "Failed to add user: $error");
    });
  }

  getStore() async {
    storeModel = FirebaseFirestore.instance
        .collection(FireStoreCollectionsNames.Store.name)
        .withConverter<StoreModel>(
          fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()!),
          toFirestore: (movie, _) => movie.toJson(),
        )
        .where((s) => s == 1) as StoreModel?;
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
