import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/models/orderModel.dart';
import 'package:shop/services/orders/order_local.dart';
import 'package:shop/services/orders/order_remote.dart';
import 'package:shop/services/service_base.dart';

class OrderServices extends ServiceBase {
  orderModel? order_Model;
  List<orderModel> ordersModel = <orderModel>[];
  late OrderRemote orderRemote;
  OrderLocal order_Local = new OrderLocal();
  var orderModelRef;

  OrderServices() {
    orderModelRef = db.instance
        .collection(CollectionsNames.stores)
        .withConverter<orderModel>(
          fromFirestore: (snapshot, _) => orderModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    orderRemote = new OrderRemote(orderModelRef);
  }

  getOrder({required String orderId}) async {
    try {
      orderModel? cachedUser = await order_Local.getCashOrder();
      if (cachedUser != null) {
        order_Model = cachedUser;
      } else {
        var user = await orderRemote.getOrder(orderId: orderId);
        order_Model = user;
        order_Local.cachingOrder(order_Model);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getCustomerOrders({required String customerId}) async {
    try {
      var cashCustomerOrders = await order_Local.getCashCustomerOrders();
      if (cashCustomerOrders != null) {
        ordersModel = cashCustomerOrders;
      } else {
        var customerOrders = await orderRemote.getCustomerOrders(customerId: customerId);
        ordersModel = customerOrders;
        await order_Local.cachingCustomerOrders(ordersModel);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }



  createOrder(orderModel model) async {
    try {
      await orderModelRef.add(model);
      await getOrder(orderId: model.id);
      order_Local.deleteCachedOrder();
      order_Local.deleteCachedCustomerOrder();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  updateOrder({required orderModel model}) async {
    try {
      QueryDocumentSnapshot<orderModel> user = await orderModelRef
          .where('userId', isEqualTo: model.id)
          .get()
          .then((snapshot) {
        return snapshot.docs.first;
      });
      orderModelRef.doc(user.id).update(model.toJson());
      order_Local.deleteCachedOrder();
      order_Local.deleteCachedCustomerOrder();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  deleteOrder({required String orderId}) async {
    try {
      QueryDocumentSnapshot<orderModel> order = await orderModelRef
          .where('orderId', isEqualTo: orderId)
          .get()
          .then((snapshot) {
        return snapshot.docs.first;
      });
      orderModelRef.doc(order.id).delete();
      order_Local.deleteCachedOrder();
      order_Local.deleteCachedCustomerOrder();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
