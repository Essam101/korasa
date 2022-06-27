import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/core/extensions/generateId.dart';
import 'package:shop/models/pageModel.dart';
import 'package:shop/models/transactionModel.dart';
import 'package:shop/services/pages/page_services.dart';

class TransactionServices {
  editTransaction({required BuildContext context, required String pageId, required Transaction transaction}) async {
    PageModel pageModel = await Provider.of<PageServices>(context, listen: false).getPageById(pageId: pageId);
    pageModel.transactions.forEach((element) {
      if (element.transactionId == transaction.transactionId) {
        element = transaction;
      }
    });
    await Provider.of<PageServices>(context, listen: false).updatePage(model: pageModel);
  }

  addTransaction({required BuildContext context, required String pageId, required Transaction transaction}) async {
    transaction.transactionId = CollectionsNames.pages.generateId();
    PageModel pageModel = await await Provider.of<PageServices>(context, listen: false).getPageById(pageId: pageId);
    pageModel.transactions.add(transaction);
    await await Provider.of<PageServices>(context, listen: false).updatePage(model: pageModel);
  }

  deleteTransaction({required BuildContext context, required String pageId, required String transactionId}) async {
    PageModel pageModel = await await Provider.of<PageServices>(context, listen: false).getPageById(pageId: pageId);
    pageModel.transactions.removeWhere((element) => element.transactionId == transactionId);
    await await Provider.of<PageServices>(context, listen: false).updatePage(model: pageModel);
  }
}
