import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop/services/customers/customer_services.dart';
import 'package:shop/services/pages/page_services.dart';

import 'auth_services.dart';
import 'store/store_services.dart';

//                await Provider.of<AuthServices>(context, listen: false) ;
class Services {
  final BuildContext context;

  Services(this.context);

  List<SingleChildWidget> providers() {
    return [
      ChangeNotifierProvider(
        create: (context) => new AuthServices(),
      ),
      ChangeNotifierProvider(
        create: (context) => new StoreServices(),
      ),
      ChangeNotifierProvider(
        create: (context) => new PageServices(),
      ),
      ChangeNotifierProvider(
        create: (context) => new CustomerServices(),
      ),
    ];
  }
}
