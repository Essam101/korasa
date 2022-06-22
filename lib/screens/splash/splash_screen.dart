import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/screens/splash/components/body.dart';
import 'package:shop/services/store_services.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    Provider.of<StoreServices>(context, listen: false).getStore(storeId: "10");
    Provider.of<StoreServices>(context, listen: false).getStores();
    Provider.of<StoreServices>(context, listen: false).createStore(new StoreModel(storeId: "1", name: "Essam", status: StoreStatus.Active));

    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
