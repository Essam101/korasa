import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/models/pageModel.dart';
import 'package:shop/services/service_base.dart';

class PageRemote extends ServiceBase {
  final pageModelRef;

  PageRemote(this.pageModelRef);

  Future<PageModel?> getPageByPageId({required String pageId}) async {
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

  Future<List<PageModel>> getPagesByCustomerId({required String customerId}) async {
    try {
      List<QueryDocumentSnapshot<PageModel>> stores = await pageModelRef.where('customerId', isEqualTo: customerId).get().then((snapshot) {
        return snapshot.docs;
      });
      List<PageModel> _pages = [];
      stores.forEach((element) {
        print(element);
      });
      return _pages;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }

  Future<List<PageModel>> getPagesByStoreId({required String storeId}) async {
    try {
      List<QueryDocumentSnapshot<PageModel>> stores = await pageModelRef.where('storeId', isEqualTo: storeId).get().then((snapshot) {
        return snapshot.docs;
      });
      List<PageModel> _pages = [];
      stores.forEach((element) {
        print(element);
      });
      return _pages;
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
    return [];
  }
}
