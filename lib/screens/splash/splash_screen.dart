import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/core/extensions/generateId.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/models/pageModel.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/screens/splash/components/body.dart';
import 'package:shop/services/customers/customer_services.dart';
import 'package:shop/services/pages/page_services.dart';
import 'package:shop/services/store/store_services.dart';
import 'package:shop/services/store_services.dart';
import 'package:shop/services/users/user_services.dart';

class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    // Provider.of<StoreServices>(context, listen: false).getStores();
    // Provider.of<StoreServices>(context, listen: false).createStore(new StoreModel(storeId: "1", name: "Essam", status: StoreStatus.Active.index));
    // Provider.of<StoreServices>(context, listen: false)
    //     .updateStore(storeModel: new StoreModel(storeId: "10", name: "name", status: StoreStatus.Active.index));
    // Provider.of<StoreServices>(context, listen: false).deleteStore(storeId: "10");
    // You have to call it on your starting screen


    // Provider.of<CustomerServices>(context, listen: false).createCustomer(
    //     new CustomerModel(
    //         customerId: CollectionsNames.customers.generateId(),
    //         name: 'customer1',
    //         notes: 'notes',
    //         storeId: 'store1'));

    // Provider.of<CustomerServices>(context, listen: false).updateCustomer(model: new CustomerModel(customerId: "26c32eea-3c2c-52b5-9513-07ce6148b444", name: "Ahmed", notes: "Updated", storeId: "Store2"));


    Provider.of<UserServices>(context , listen:  false).createUser(model: new UserModel(userId: CollectionsNames.users.generateId(), name: 'ahmed abdullah'  , role: roleType.owner, storeId: 'Store1', email: 'ahmedabdullah111@gmail.com'))  ;
    Provider.of<UserServices>(context , listen:  false).createUser(model: new UserModel(userId: CollectionsNames.users.generateId(), name: 'essam mabrouk'  , role: roleType.emp, storeId: 'Store1', email: 'essam22@gmail.com'))  ;


    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
    );
  }
}
