// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';
// import 'package:shop/core/collectionsNames.dart';
// import 'package:shop/models/storeModel.dart';
// import 'package:shop/services/service_base.dart';
//
// import '../core/enums.dart';
//
// class StoreServices extends ServiceBase {
//   StoreModel? storeModel;
//   List<StoreModel> storesModel = <StoreModel>[];
//
//   var storeModelRef;
//
//   StoreServices() {
//     storeModelRef = db.instance.collection(CollectionsNames.stores).withConverter<StoreModel>(
//           fromFirestore: (snapshot, _) => StoreModel.fromJson(snapshot.data()!),
//           toFirestore: (store, _) => store.toJson(),
//         );
//   }
//
//   createStore(StoreModel storeModel) async {
//     try {
//       await storeModelRef.add(storeModel);
//       await getStore(storeId: storeModel.storeId);
//     } on FirebaseFirestore catch (e) {
//       print(e);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   getStore({required String storeId}) async {
//     try {
//       QueryDocumentSnapshot<StoreModel> store = await storeModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
//         return snapshot.docs.first;
//       });
//       storeModel = store.data();
//       notifyListeners();
//     } on FirebaseFirestore catch (e) {
//       print(e);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   getStores() async {
//     try {
//       List<QueryDocumentSnapshot<StoreModel>> stores = await storeModelRef.get().then((snapshot) {
//         return snapshot.docs;
//       });
//       stores.forEach((element) {
//         storesModel.add(new StoreModel(storeId: element.data().storeId, name: element.data().name, status: element.data().status));
//       });
//       notifyListeners();
//     } on FirebaseFirestore catch (e) {
//       print(e);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   updateStore({required StoreModel storeModel}) async {
//     try {
//       QueryDocumentSnapshot<StoreModel> store = await storeModelRef.where('storeId', isEqualTo: storeModel.storeId).get().then((snapshot) {
//         return snapshot.docs.first;
//       });
//       storeModelRef.doc(store.id).update(storeModel.toJson());
//       notifyListeners();
//     } on FirebaseFirestore catch (e) {
//       print(e);
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   deleteStore({required String storeId}) async {
//     try {
//       QueryDocumentSnapshot<StoreModel> store = await storeModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
//         return snapshot.docs.first;
//       });
//       storeModelRef.doc(store.id).delete();
//       notifyListeners();
//     } on FirebaseFirestore catch (e) {
//       print(e);
//     } catch (e) {
//       print(e);
//     }
//   }
// }
