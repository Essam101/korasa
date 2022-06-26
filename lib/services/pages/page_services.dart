import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/models/pageModel.dart';
import 'package:shop/services/pages/page_local.dart';
import 'package:shop/services/pages/page_remote.dart';

import 'package:shop/services/service_base.dart';

class PageServices extends ServiceBase {
  PageModel? pageModel;
  List<PageModel> pagesModel = <PageModel>[];
  late PageRemote pageRemote;
  PageLocal pageLocal = new PageLocal();
  var pageModelRef;

  PageServices() {
    pageModelRef = db.instance.collection(CollectionsNames.stores).withConverter<PageModel>(
          fromFirestore: (snapshot, _) => PageModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    pageRemote = new PageRemote(pageModelRef);
  }

  getPage({required String pageId}) async {
    try {
      PageModel? cachedPage = await pageLocal.getCashPage();
      if (cachedPage != null) {
        pageModel = cachedPage;
      } else {
        var page = await pageRemote.getPage(pageId: pageId);
        pageModel = page;
        pageLocal.cachingPage(pageModel);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getCustomerPages({required String customerId}) async {
    try {
      var cashCustomerPages = await pageLocal.getCashCustomerPages();
      if (cashCustomerPages != null) {
        pagesModel = cashCustomerPages;
      } else {
        var customerPages = await pageRemote.getCustomerPages(customerId: customerId);
        pagesModel = customerPages;
        await pageLocal.cachingCustomerPages(pagesModel);
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  createPage(PageModel model) async {
    try {
      await pageModelRef.add(model);
      await getPage(pageId: model.pageId);
      pageLocal.deleteCachedPage();
      pageLocal.deleteCachedCustomerPage();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  updatePage({required PageModel model}) async {
    try {
      QueryDocumentSnapshot<PageModel> user = await pageModelRef.where('pageId', isEqualTo: model.pageId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      pageModelRef.doc(user.id).update(model.toJson());
      pageLocal.deleteCachedPage();
      pageLocal.deleteCachedCustomerPage();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  deletePage({required String pageId}) async {
    try {
      QueryDocumentSnapshot<PageModel> page = await pageModelRef.where('pageId', isEqualTo: pageId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      pageModelRef.doc(page.id).delete();
      pageLocal.deleteCachedPage();
      pageLocal.deleteCachedCustomerPage();
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
