import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/custom_surfix_icon.dart';
import 'package:shop/components/default_button.dart';
import 'package:shop/components/form_error.dart';
import 'package:shop/core/collectionsNames.dart';
import 'package:shop/core/extensions/generateId.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/models/storeModel.dart';
import 'package:shop/screens/complete_store/state_management/complete_store_state.dart';
import 'package:shop/screens/navigation/navigation_screen.dart';

import '../../../core/constants.dart';
import '../../../services/store/store_services.dart';

class CompleteProfileForm extends StatefulWidget {
  final Function(bool) loading;

  const CompleteProfileForm({required this.loading});

  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];

  // String? storeId;
  String storeName = "";
  String storeDescription = "";

  // String? description;
  late StoreStatus status = StoreStatus.Active;

  late StoreServices storeServices;

  // late AuthServices authServices;
  // late UserServices userServices;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //storeServices = Provider.of<StoreServices>(context, listen: false);
    // userServices = Provider.of<UserServices>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildStoreNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildStoreDescriptionFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          // buildPhoneNumberFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          // buildAddressFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: "Create Store",
            press: () async {
              if (_formKey.currentState!.validate()) {
                Provider.of<CompleteStoreState>(context, listen: false)
                    .createStore(
                      storeModel: new StoreModel(
                        storeId: CollectionsNames.stores.generateId(),
                        name: storeName,
                        status: StoreStatus.Active.index,
                        description: storeDescription,
                      ),
                    )
                    .then((value) => {if (value) Navigator.pushNamed(context, NavigationScreen.routeName)});
              }
            },
          ),
          DefaultButton(
            text: "clear data",
            press: () async {
              new GetStorage().erase();
            },
          ),
        ],
      ),
    );
  }

  // TextFormField buildAddressFormField() {
  //   return TextFormField(
  //     onSaved: (newValue) => address = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kAddressNullError);
  //       }
  //       return null;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kAddressNullError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Address",
  //       hintText: "Enter your phone address",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
  //     ),
  //   );
  // }

  // TextFormField buildPhoneNumberFormField() {
  //   return TextFormField(
  //     keyboardType: TextInputType.phone,
  //     onSaved: (newValue) => phoneNumber = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kPhoneNumberNullError);
  //       }
  //       return null;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kPhoneNumberNullError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "Phone Number",
  //       hintText: "Enter your phone number",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
  //     ),
  //   );
  // }

  TextFormField buildStoreDescriptionFormField() {
    return TextFormField(
      onSaved: (newValue) {
        if (newValue != null) {
          storeDescription = newValue;
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        storeDescription = value;
        return null;
      },
      decoration: InputDecoration(
        labelText: "Store descriptions",
        hintText: "Enter your Store descriptions",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
      maxLines: 8,
    );
  }

  TextFormField buildStoreNameFormField() {
    return TextFormField(
      onSaved: (newValue) {
        if (newValue != null) {
          storeName = newValue;
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        storeName = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Store Name",
        hintText: "Enter your Store Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }
}
