import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/models/orderModel.dart';
import 'package:shop/services/service_base.dart';

class OrderRemote extends ServiceBase {
  final orderModelRef;

  OrderRemote(this.orderModelRef);

  Future<orderModel?> getOrder({required String orderId}) async {
    try {
      QueryDocumentSnapshot<orderModel> order = await orderModelRef.where('orderId', isEqualTo: orderId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      return order.data();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<orderModel>> getCustomerOrders({required String customerId } ) async {
    try {
      List<QueryDocumentSnapshot<orderModel>> customers = await orderModelRef.where('customerId', isEqualTo: customerId).get().then((snapshot) {
        return snapshot.docs;
      });
      List<orderModel> _orders = [];
      customers.forEach((element) {
        _orders.add(new orderModel(id: element.data().id, productName: element.data().productName , creationDate: DateTime.now(), amount: element.data().amount, isPaid: element.data().isPaid, storeId: element.data().storeId));
      });
      return _orders;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }


}
