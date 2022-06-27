import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop/core/cachingKeys.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';
import 'package:shop/models/pageModel.dart';
import 'package:shop/services/pages/page_local.dart';
import 'package:shop/services/pages/page_remote.dart';

import 'package:shop/services/service_base.dart';

class PageServices extends ServiceBase {
  var pageModelRef;
  late PageRemote pageRemote;
  late PageLocal pageLocal = new PageLocal();

  late PageModel customerPageModel;
  late List<PageModel> customerPagesModel;
  late List<PageModel> storePagesModel;

  PageServices() {
    pageModelRef = db.instance.collection(CollectionsNames.stores).withConverter<PageModel>(
          fromFirestore: (snapshot, _) => PageModel.fromJson(snapshot.data()!),
          toFirestore: (store, _) => store.toJson(),
        );
    print(pageModelRef.runtimeType);
    pageRemote = new PageRemote(pageModelRef);
  }

  getPageById({required String pageId}) async {
    try {
      var page = await pageLocal.getCashedPageByPageId(PageId: pageId);
      if (page != null) {
        customerPageModel = page;
      } else {
        var page = await pageRemote.getPageByPageId(pageId: pageId);
        if (page != null) {
          customerPageModel = page;
          await pageLocal.cachingPageByPageId(model: customerPageModel);
        } else {
          "Page Not Found".showAlert(alertType: AlertType.Error);
        }
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getCustomerPagesByCustomerId({required String customerId}) async {
    try {
      var pages = await pageLocal.getCachedCustomerPagesByCustomerId(customerId: customerId);
      if (pages != null) {
        customerPagesModel = pages;
      } else {
        var pages = await pageRemote.getPagesByCustomerId(customerId: customerId);
        if (pages.length > 0) {
          customerPagesModel = pages;
          await pageLocal.cachingCustomerPages(customerId: customerId, model: customerPagesModel);
        } else {
          "Not Found".showAlert(alertType: AlertType.Error);
        }
      }
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  getStorePagesByStoreId({required String storeId}) async {
    try {
      var pages = await pageLocal.getCachedStorePagesByStoreId(storeId: storeId);
      if (pages != null) {
        storePagesModel = pages;
      } else {
        var pages = await pageRemote.getPagesByStoreId(storeId: storeId);
        if (pages.length > 0) {
          storePagesModel = pages;
          await pageLocal.cachingStorePages(storeId: storeId, model: storePagesModel);
        } else {
          "Not Found".showAlert(alertType: AlertType.Error);
        }
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
      await pageLocal.deleteCachedPage();
      await pageLocal.deleteCachedPages();
      await getPageById(pageId: model.pageId);
      await getCustomerPagesByCustomerId(customerId: model.customerId);
      await getStorePagesByStoreId(storeId: model.storeId);
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }

  updatePage({required PageModel model}) async {
    try {
      QueryDocumentSnapshot<PageModel> page = await pageModelRef.where('pageId', isEqualTo: model.pageId).get().then((snapshot) {
        return snapshot.docs.first;
      });
      pageModelRef.doc(page.id).update(model.toJson());

      await pageLocal.deleteCachedPage();
      await pageLocal.deleteCachedPages();
      await getPageById(pageId: model.pageId);
      await getCustomerPagesByCustomerId(customerId: model.customerId);
      await getStorePagesByStoreId(storeId: model.storeId);

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
      await pageLocal.deleteCachedPage();
      await pageLocal.deleteCachedPages();
      await getPageById(pageId: page.data().pageId);
      await getCustomerPagesByCustomerId(customerId: page.data().customerId);
      await getStorePagesByStoreId(storeId: page.data().storeId);
      notifyListeners();
    } on FirebaseFirestore catch (e) {
      print(e);
    } catch (e) {
      print(e);
    }
  }
}
