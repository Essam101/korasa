import 'package:get_storage/get_storage.dart';
import 'package:shop/core/cachingKeys.dart';

import '../../models/pageModel.dart';

class PageLocal {
  GetStorage localStorage = new GetStorage();

  Future<void>? cachingPage(PageModel? model) {
    if (model != null) {
      return localStorage.write(CachingKeys.user, model.toJson());
    }
    return null;
  }

  Future<void> cachingCustomerPages(List<PageModel> model) {
    return localStorage.write(CachingKeys.customerPages, pageModelToJson(model));
  }

  Future<PageModel>? getCashPage() {
    final jsonPage = localStorage.read(CachingKeys.page);
    if (jsonPage != null) {
      return Future.value(PageModel.fromRawJson(jsonPage));
    } else {
      return null;
    }
  }

  Future<List<PageModel>>? getCashCustomerPages() {
    final jsonPages = localStorage.read(CachingKeys.storeCustomers);
    if (jsonPages != null && jsonPages.length != 0) {
      return Future.value(pageModelFromJson(jsonPages));
    } else {
      return null;
    }
  }

  deleteCachedPage() {
    localStorage.remove(CachingKeys.page);
  }

  deleteCachedCustomerPage() {
    localStorage.remove(CachingKeys.customerPages);
  }
}
