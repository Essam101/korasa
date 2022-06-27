import 'package:get_storage/get_storage.dart';
import 'package:shop/core/cachingKeys.dart';

import '../../models/pageModel.dart';

class PageLocal {
  GetStorage localStorage = new GetStorage();

  Future<void>? cachingPageByPageId({required PageModel? model}) {
    if (model != null) {
      return localStorage.write(CachingKeys.page.addIdToKey(id: model.pageId), model.toJson());
    }
    return null;
  }

  Future<void>? cachingCustomerPages({required String customerId, required List<PageModel>? model}) {
    if (model != null) {
      return localStorage.write(CachingKeys.pages.addIdToKey(id: customerId), pageModelToJson(model));
    }
    return null;
  }

  Future<void>? cachingStorePages({required String storeId, required List<PageModel>? model}) {
    if (model != null) {
      return localStorage.write(CachingKeys.pages.addIdToKey(id: storeId), pageModelToJson(model));
    }
    return null;
  }

  Future<PageModel>? getCashedPageByPageId({required String PageId}) {
    final jsonPage = localStorage.read(CachingKeys.page.addIdToKey(id: PageId));
    if (jsonPage != null) {
      return Future.value(PageModel.fromRawJson(jsonPage));
    } else {
      return null;
    }
  }

  Future<List<PageModel>>? getCachedCustomerPagesByCustomerId({required String customerId}) {
    final jsonPage = localStorage.read(CachingKeys.page.addIdToKey(id: customerId));
    if (jsonPage != null) {
      return Future.value(pageModelFromJson(jsonPage));
    } else {
      return null;
    }
  }

  Future<List<PageModel>>? getCachedStorePagesByStoreId({required String storeId}) {
    final jsonPage = localStorage.read(CachingKeys.page.addIdToKey(id: storeId));
    if (jsonPage != null) {
      return Future.value(pageModelFromJson(jsonPage));
    } else {
      return null;
    }
  }

  deleteCachedPage() {
    localStorage.remove(CachingKeys.page);
  }

  deleteCachedPages() {
    localStorage.remove(CachingKeys.pages);
  }
}
