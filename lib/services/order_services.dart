import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/core/extensions/generateId.dart';
import 'package:shop/models/orderModel.dart';
import 'package:shop/models/pageModel.dart';
import 'package:shop/services/pages/page_services.dart';

class OrderServices {
  editOrder({required BuildContext context, required String pageId, required Order order}) async {
    PageModel pageModel = await Provider.of<PageServices>(context, listen: false).getPageById(pageId: pageId);
    pageModel.orders.forEach((element) {
      if (element.orderId == order.orderId) {
        element = order;
      }
    });
    await Provider.of<PageServices>(context, listen: false).updatePage(model: pageModel);
  }

  addOrder({required BuildContext context, required String pageId, required Order order}) async {
    order.orderId = CollectionsNames.pages.generateId();
    PageModel pageModel = await await Provider.of<PageServices>(context, listen: false).getPageById(pageId: pageId);
    pageModel.orders.add(order);
    await await Provider.of<PageServices>(context, listen: false).updatePage(model: pageModel);
  }

  deleteOrder({required BuildContext context, required String pageId, required String orderId}) async {
    PageModel pageModel = await await Provider.of<PageServices>(context, listen: false).getPageById(pageId: pageId);
    pageModel.orders.removeWhere((element) => element.orderId == orderId);
    await await Provider.of<PageServices>(context, listen: false).updatePage(model: pageModel);
  }
}
