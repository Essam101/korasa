// import 'package:get_storage/get_storage.dart';
// import 'package:shop/core/cachingKeys.dart';
// import 'package:shop/models/orderModel.dart';
//
// class OrderLocal {
//   GetStorage localStorage = new GetStorage();
//
//   Future<void>? cachingOrder(orderModel? model) {
//     if (model != null) {
//       return localStorage.write(CachingKeys.user, model.toJson());
//     }
//     return null;
//   }
//
//   Future<void> cachingCustomerOrders(List<orderModel> model) {
//     return localStorage.write(
//         CachingKeys.customerOrders, orderModelToJson(model));
//   }
//
//
//
//   Future<orderModel>? getCashOrder() {
//     final jsonOrder = localStorage.read(CachingKeys.order);
//     if (jsonOrder != null) {
//       return Future.value(orderModel.fromRawJson(jsonOrder));
//     } else {
//       return null;
//     }
//   }
//
//   Future<List<orderModel>>? getCashCustomerOrders() {
//     final jsonOrders = localStorage.read(CachingKeys.storeCustomers);
//     if (jsonOrders != null && jsonOrders.length != 0) {
//       return Future.value(orderModelFromJson(jsonOrders));
//     } else {
//       return null;
//     }
//   }
//
//
//
//   deleteCachedOrder() {
//     localStorage.remove(CachingKeys.order);
//   }
//
//   deleteCachedCustomerOrder() {
//     localStorage.remove(CachingKeys.customerOrders);
//   }
//
//
// }
