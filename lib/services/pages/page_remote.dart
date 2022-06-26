import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/models/pageModel.dart';
import 'package:shop/services/service_base.dart';

class PageRemote extends ServiceBase {
  final pageModelRef;

  PageRemote(this.pageModelRef);

  Future<PageModel?> getPage({required String pageId}) async {
    try {
      QueryDocumentSnapshot<PageModel> page = await pageModelRef.where('pageId', isEqualTo: pageId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      return page.data();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<PageModel>> getCustomerPages({required String customerId}) async {
    try {
      List<QueryDocumentSnapshot<PageModel>> customers = await pageModelRef.where('customerId', isEqualTo: customerId).get().then((snapshot) {
        return snapshot.docs;
      });
      List<PageModel> _pages = [];
      // customers.forEach((element) {
      //   _ Pages.add(new PageModel(
      //       customerId: ,: element.data().userId,
      //       productName: element.data().productName,
      //       creationDate: DateTime.now(),
      //       amount: element.data().amount,
      //       isPaid: element.data().isPaid,
      //       storeId: element.data().storeId));
      // });
      return _pages;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
